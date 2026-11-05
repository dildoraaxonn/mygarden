import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../../trees/view/tree_labels.dart';

/// The greenhouse drawn to scale, with every tree where it really stands.
///
/// * tap a tree → [onTapTree]
/// * tap empty ground → [onTapGround] (only used while planting)
/// * long-press a tree and drag → [onMoveTree]
///
/// Positions are in meters: x along the length, y across the width.
class PlotMapCanvas extends StatefulWidget {
  const PlotMapCanvas({
    super.key,
    required this.plot,
    required this.trees,
    required this.pixelsPerMeter,
    required this.onTapTree,
    required this.onMoveTree,
    this.onTapGround,
    this.highlightedTreeId,
  });

  final Plot plot;
  final List<Tree> trees;
  final double pixelsPerMeter;
  final void Function(Tree tree) onTapTree;
  final void Function(Tree tree, Offset meters) onMoveTree;
  final void Function(Offset meters)? onTapGround;

  /// Shown lifted, e.g. while choosing where to move it.
  final int? highlightedTreeId;

  /// Shorter than Flutter's default 500 ms, so holding a tree wins over
  /// panning the map even if the finger starts moving a little early.
  static const holdToDrag = Duration(milliseconds: 300);

  @override
  State<PlotMapCanvas> createState() => _PlotMapCanvasState();
}

class _PlotMapCanvasState extends State<PlotMapCanvas> {
  final _key = GlobalKey();
  int? _draggingId;
  Offset? _dragMeters;

  double get _ppm => widget.pixelsPerMeter;

  /// Keeps a point half a meter inside the walls.
  Offset _clamp(Offset meters) => Offset(
    meters.dx.clamp(0.5, widget.plot.lengthM - 0.5),
    meters.dy.clamp(0.5, widget.plot.widthM - 0.5),
  );

  Offset _globalToMeters(Offset global) {
    final box = _key.currentContext!.findRenderObject()! as RenderBox;
    return _clamp(box.globalToLocal(global) / _ppm);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final markerSize = (_ppm * 1.2).clamp(30.0, 56.0);
    return SizedBox(
      key: _key,
      width: widget.plot.lengthM * _ppm,
      height: widget.plot.widthM * _ppm,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: widget.onTapGround == null
            ? null
            : (d) => widget.onTapGround!(_clamp(d.localPosition / _ppm)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GroundPainter(
                  plot: widget.plot,
                  ppm: _ppm,
                  ground: scheme.surfaceContainerLow,
                  line: scheme.outlineVariant,
                  wall: scheme.outline,
                  label: scheme.onSurfaceVariant,
                  meterUnit: AppLocalizations.of(context).meterUnit,
                ),
              ),
            ),
            for (final tree in widget.trees) _positioned(tree, markerSize),
          ],
        ),
      ),
    );
  }

  Widget _positioned(Tree tree, double size) {
    final dragging = tree.id == _draggingId;
    final lifted = dragging || tree.id == widget.highlightedTreeId;
    final meters = dragging && _dragMeters != null
        ? _dragMeters!
        : Offset(tree.xM, tree.yM);
    return Positioned(
      key: ValueKey(tree.id),
      left: meters.dx * _ppm - size / 2,
      top: meters.dy * _ppm - size / 2,
      width: size,
      height: size,
      child: RawGestureDetector(
        gestures: {
          TapGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                TapGestureRecognizer.new,
                (r) => r.onTap = () => widget.onTapTree(tree),
              ),
          LongPressGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
                () => LongPressGestureRecognizer(
                  duration: PlotMapCanvas.holdToDrag,
                ),
                (r) => r
                  ..onLongPressStart = (d) {
                    HapticFeedback.mediumImpact();
                    setState(() {
                      _draggingId = tree.id;
                      _dragMeters = _globalToMeters(d.globalPosition);
                    });
                  }
                  ..onLongPressMoveUpdate = (d) {
                    setState(
                      () => _dragMeters = _globalToMeters(d.globalPosition),
                    );
                  }
                  ..onLongPressEnd = (_) {
                    final target = _dragMeters;
                    setState(() {
                      _draggingId = null;
                      _dragMeters = null;
                    });
                    if (target != null) widget.onMoveTree(tree, target);
                  },
              ),
        },
        child: AnimatedScale(
          scale: lifted ? 1.3 : 1,
          duration: const Duration(milliseconds: 120),
          child: TreeMarker(tree: tree, lifted: lifted),
        ),
      ),
    );
  }
}

/// Round tree icon coloured by stage, with a flower badge when flowering.
class TreeMarker extends StatelessWidget {
  const TreeMarker({super.key, required this.tree, this.lifted = false});

  final Tree tree;
  final bool lifted;

  @override
  Widget build(BuildContext context) {
    final type = context.select(
      (FruitTypesCubit c) => c.state.byId(tree.fruitTypeId),
    );
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tree.stage.color(scheme),
              border: Border.all(
                color: tree.stage == TreeStage.fruiting
                    ? Colors.orange.shade700
                    : scheme.outline,
                width: tree.stage == TreeStage.fruiting ? 2.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: lifted ? 0.35 : 0.15),
                  blurRadius: lifted ? 10 : 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: FittedBox(child: Text(type?.emoji ?? '🌳')),
            ),
          ),
        ),
        if (tree.stage == TreeStage.flowering)
          const Positioned(
            right: -4,
            top: -4,
            child: Text('🌸', style: TextStyle(fontSize: 14)),
          ),
      ],
    );
  }
}

class _GroundPainter extends CustomPainter {
  _GroundPainter({
    required this.plot,
    required this.ppm,
    required this.ground,
    required this.line,
    required this.wall,
    required this.label,
    required this.meterUnit,
  });

  final Plot plot;
  final double ppm;
  final Color ground;
  final Color line;
  final Color wall;
  final Color label;
  final String meterUnit;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = const Radius.circular(8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius),
      Paint()..color = ground,
    );

    // Faint line every meter, stronger every 5 m, with labels.
    final thin = Paint()
      ..color = line.withValues(alpha: 0.35)
      ..strokeWidth = 0.5;
    final thick = Paint()
      ..color = line
      ..strokeWidth = 1;
    for (var m = 1; m < plot.lengthM; m++) {
      final x = m * ppm;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        m % 5 == 0 ? thick : thin,
      );
      if (m % 5 == 0) _label(canvas, '$m', Offset(x + 3, 3));
    }
    for (var m = 1; m < plot.widthM; m++) {
      final y = m * ppm;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        m % 5 == 0 ? thick : thin,
      );
      if (m % 5 == 0) _label(canvas, '$m', Offset(3, y + 2));
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(1), radius),
      Paint()
        ..color = wall
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  void _label(Canvas canvas, String text, Offset at) {
    final painter = TextPainter(
      text: TextSpan(
        text: '$text $meterUnit',
        style: TextStyle(color: label, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, at);
  }

  @override
  bool shouldRepaint(_GroundPainter old) =>
      old.plot != plot || old.ppm != ppm || old.ground != ground;
}

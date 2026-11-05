import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../../journal/data/journal_repository.dart';
import '../../journal/view/journal_labels.dart';
import '../../trees/data/tree_repository.dart';
import '../cubit/plot_map_cubit.dart';
import '../data/plot_repository.dart';
import 'widgets/plot_form_dialog.dart';
import 'widgets/plot_map_canvas.dart';
import 'widgets/tree_action_sheet.dart';

/// A greenhouse map. Turns the phone to landscape while open, because a
/// 50 m long greenhouse reads much better sideways.
class PlotMapPage extends StatefulWidget {
  const PlotMapPage({super.key, required this.plotId});

  final int plotId;

  static Future<void> open(BuildContext context, int plotId) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => PlotMapPage(plotId: plotId)),
  );

  @override
  State<PlotMapPage> createState() => _PlotMapPageState();
}

class _PlotMapPageState extends State<PlotMapPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlotMapCubit(
        plotId: widget.plotId,
        plots: context.read<PlotRepository>(),
        trees: context.read<TreeRepository>(),
        journal: context.read<JournalRepository>(),
      ),
      child: const PlotMapView(),
    );
  }
}

class PlotMapView extends StatelessWidget {
  const PlotMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlotMapCubit, PlotMapState>(
      builder: (context, state) {
        final plot = state.plot;
        if (plot == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _TopBar(plot: plot, treeCount: state.trees.length),
                      Expanded(child: _Map(state: state)),
                    ],
                  ),
                ),
                _PlantToolbar(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.plot, required this.treeCount});

  final Plot plot;
  final int treeCount;

  Future<void> _edit(BuildContext context) async {
    final cubit = context.read<PlotMapCubit>();
    final result = await showPlotFormDialog(context, plot);
    if (result != null) {
      await cubit.savePlot(
        name: result.name,
        widthM: result.widthM,
        lengthM: result.lengthM,
      );
    }
  }

  Future<void> _logWholePlot(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<PlotMapCubit>();
    final kind = await showModalBottomSheet<JournalKind>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.plotLogWhole(plot.name),
                style: Theme.of(sheetContext).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              JournalActionChips(
                kinds: plotJournalKinds,
                onSelected: (k) => Navigator.pop(sheetContext, k),
              ),
            ],
          ),
        ),
      ),
    );
    if (kind == null || !context.mounted) return;
    final answer = await askJournalNote(context, kind);
    if (answer == null) return;
    await cubit.logForWholePlot(kind, note: answer.note);
    if (context.mounted) {
      showSnack(
        context,
        l10n.journalSaved('${kind.emoji} ${kind.label(l10n)}'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
      child: Row(
        children: [
          const BackButton(),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: plot.name,
                style: theme.textTheme.titleMedium,
                children: [
                  TextSpan(
                    text:
                        '   ${l10n.plotSize(formatMeters(plot.widthM), formatMeters(plot.lengthM))}'
                        ' · ${l10n.treeCount(treeCount)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton.icon(
            onPressed: () => _logWholePlot(context),
            icon: const Text('💧'),
            label: Text(l10n.plotLogWholeShort),
          ),
          IconButton(
            tooltip: l10n.plotEdit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _edit(context),
          ),
        ],
      ),
    );
  }
}

class _Map extends StatelessWidget {
  const _Map({required this.state});

  final PlotMapState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<PlotMapCubit>();
    final plot = state.plot!;
    final types = context.watch<FruitTypesCubit>().state;
    final brush = state.brushTypeId == null
        ? null
        : types.byId(state.brushTypeId!);
    final moving = state.movingTree;
    final movingType = moving == null ? null : types.byId(moving.fruitTypeId);

    return LayoutBuilder(
      builder: (context, constraints) {
        const margin = 12.0;
        // Fit the greenhouse's width to the screen height; scroll sideways
        // along its length. Pinch out to see the whole thing.
        final ppm = (constraints.maxHeight - margin * 2) / plot.widthM;
        final contentWidth = plot.lengthM * ppm + margin * 2;
        final minScale = (constraints.maxWidth / contentWidth).clamp(0.1, 1.0);

        return Stack(
          children: [
            InteractiveViewer(
              constrained: false,
              minScale: minScale,
              maxScale: 4,
              // Scroll along the length only; no drifting into empty space
              // above or below the greenhouse.
              boundaryMargin: const EdgeInsets.symmetric(horizontal: 64),
              child: Padding(
                padding: const EdgeInsets.all(margin),
                child: PlotMapCanvas(
                  plot: plot,
                  trees: state.trees,
                  pixelsPerMeter: ppm,
                  highlightedTreeId: state.movingTreeId,
                  onTapTree: (tree) => showTreeActionSheet(
                    context,
                    tree,
                    onMove: () => cubit.startMove(tree.id),
                  ),
                  onMoveTree: (tree, meters) => cubit.moveTree(tree.id, meters),
                  onTapGround: brush == null && moving == null
                      ? null
                      : (meters) {
                          HapticFeedback.lightImpact();
                          cubit.tapGround(meters);
                        },
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 8,
              child: IgnorePointer(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.inverseSurface.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      moving != null
                          ? l10n.mapMoveHint(movingType?.label(context) ?? '')
                          : brush != null
                          ? l10n.mapPlantingHint(brush.label(context))
                          : l10n.mapHint,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Right-hand toolbar: pick a fruit, then tap the map to plant it.
class _PlantToolbar extends StatelessWidget {
  const _PlantToolbar({required this.state});

  final PlotMapState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    final cubit = context.read<PlotMapCubit>();
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 96,
      color: scheme.surfaceContainer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Text(
              l10n.mapPlant,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                for (final type in types)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _BrushButton(
                      type: type,
                      selected: state.brushTypeId == type.id,
                      onTap: () => cubit.toggleBrush(type.id),
                    ),
                  ),
              ],
            ),
          ),
          if (state.brushTypeId != null || state.movingTreeId != null)
            IconButton(
              tooltip: l10n.mapStopPlanting,
              onPressed: cubit.cancelMode,
              icon: const Icon(Icons.close),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: IconButton.outlined(
              tooltip: l10n.undo,
              onPressed: state.placedIds.isEmpty ? null : cubit.undoPlant,
              icon: const Icon(Icons.undo),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrushButton extends StatelessWidget {
  const _BrushButton({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final FruitType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Column(
            children: [
              Text(type.emoji, style: const TextStyle(fontSize: 26)),
              Text(
                type.localizedName(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: selected ? scheme.onPrimary : scheme.onSurface,
                  fontWeight: selected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

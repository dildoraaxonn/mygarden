import 'dart:async';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../journal/data/journal_repository.dart';
import '../../trees/data/tree_repository.dart';
import '../data/plot_repository.dart';

class PlotMapState extends Equatable {
  const PlotMapState({
    this.plot,
    this.trees = const [],
    this.brushTypeId,
    this.movingTreeId,
    this.placedIds = const [],
  });

  final Plot? plot;
  final List<Tree> trees;

  /// Fruit type to plant when the map is tapped. Null = planting is off,
  /// so stray taps don't add trees.
  final int? brushTypeId;

  /// Tree waiting for a tap on its new spot ("Move" from the tree sheet).
  final int? movingTreeId;

  /// Trees planted during this visit, newest last (for undo).
  final List<int> placedIds;

  bool get loaded => plot != null;

  Tree? get movingTree {
    for (final t in trees) {
      if (t.id == movingTreeId) return t;
    }
    return null;
  }

  PlotMapState copyWith({
    Plot? plot,
    List<Tree>? trees,
    int? Function()? brushTypeId,
    int? Function()? movingTreeId,
    List<int>? placedIds,
  }) {
    return PlotMapState(
      plot: plot ?? this.plot,
      trees: trees ?? this.trees,
      brushTypeId: brushTypeId != null ? brushTypeId() : this.brushTypeId,
      movingTreeId: movingTreeId != null ? movingTreeId() : this.movingTreeId,
      placedIds: placedIds ?? this.placedIds,
    );
  }

  @override
  List<Object?> get props => [
    plot,
    trees,
    brushTypeId,
    movingTreeId,
    placedIds,
  ];
}

class PlotMapCubit extends Cubit<PlotMapState> {
  PlotMapCubit({
    required this.plotId,
    required PlotRepository plots,
    required TreeRepository trees,
    required JournalRepository journal,
  }) : _plots = plots,
       _trees = trees,
       _journal = journal,
       super(const PlotMapState()) {
    _subscriptions = [
      plots.watch(plotId).listen((p) {
        if (p != null) emit(state.copyWith(plot: p));
      }),
      trees.watchByPlot(plotId).listen((t) => emit(state.copyWith(trees: t))),
    ];
  }

  final int plotId;
  final PlotRepository _plots;
  final TreeRepository _trees;
  final JournalRepository _journal;
  late final List<StreamSubscription<Object?>> _subscriptions;

  /// Tap the selected fruit again to turn planting off.
  void toggleBrush(int fruitTypeId) => emit(
    state.copyWith(
      brushTypeId: () => state.brushTypeId == fruitTypeId ? null : fruitTypeId,
      movingTreeId: () => null,
    ),
  );

  /// Next tap on the ground moves this tree there.
  void startMove(int treeId) =>
      emit(state.copyWith(movingTreeId: () => treeId, brushTypeId: () => null));

  /// Leaves planting or moving mode.
  void cancelMode() =>
      emit(state.copyWith(brushTypeId: () => null, movingTreeId: () => null));

  /// Handles a tap on empty ground: plants or moves, depending on the mode.
  Future<void> tapGround(Offset meters) async {
    final moving = state.movingTreeId;
    if (moving != null) {
      emit(state.copyWith(movingTreeId: () => null));
      await moveTree(moving, meters);
    } else {
      await plantAt(meters);
    }
  }

  /// Plants the selected fruit at [meters] (x along length, y across width).
  Future<void> plantAt(Offset meters) async {
    final typeId = state.brushTypeId;
    if (typeId == null) return;
    final id = await _trees.add(
      plotId: plotId,
      fruitTypeId: typeId,
      xM: meters.dx,
      yM: meters.dy,
    );
    emit(state.copyWith(placedIds: [...state.placedIds, id]));
  }

  Future<void> undoPlant() async {
    if (state.placedIds.isEmpty) return;
    final last = state.placedIds.last;
    emit(
      state.copyWith(
        placedIds: state.placedIds.sublist(0, state.placedIds.length - 1),
      ),
    );
    await _trees.delete(last);
  }

  Future<void> moveTree(int treeId, Offset meters) =>
      _trees.move(treeId, xM: meters.dx, yM: meters.dy);

  Future<void> logForWholePlot(JournalKind kind, {String? note}) =>
      _journal.logForPlot(plotId, kind, note: note);

  Future<void> savePlot({
    required String name,
    required double widthM,
    required double lengthM,
  }) async {
    final plot = state.plot;
    if (plot == null) return;
    await _plots.update(
      plot.copyWith(name: name, widthM: widthM, lengthM: lengthM),
    );
    await _trees.keepInside(plotId, widthM: widthM, lengthM: lengthM);
  }

  @override
  Future<void> close() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    return super.close();
  }
}

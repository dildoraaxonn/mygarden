import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../plots/data/plot_repository.dart';
import '../data/tree_repository.dart';

class TreesListState extends Equatable {
  const TreesListState({
    this.loaded = false,
    this.trees = const [],
    this.plots = const [],
  });

  final bool loaded;
  final List<Tree> trees;
  final List<Plot> plots;

  Map<int, Plot> get plotsById => {for (final p in plots) p.id: p};

  /// Fruit type id -> trees of that type, in garden order.
  Map<int, List<Tree>> get byFruitType {
    final groups = <int, List<Tree>>{};
    for (final t in trees) {
      groups.putIfAbsent(t.fruitTypeId, () => []).add(t);
    }
    return groups;
  }

  @override
  List<Object?> get props => [loaded, trees, plots];
}

class TreesListCubit extends Cubit<TreesListState> {
  TreesListCubit({required TreeRepository trees, required PlotRepository plots})
    : super(const TreesListState()) {
    _subscriptions = [
      trees.watchAll().listen(
        (t) => emit(TreesListState(loaded: true, trees: t, plots: state.plots)),
      ),
      plots.watchAll().listen(
        (p) => emit(
          TreesListState(loaded: state.loaded, trees: state.trees, plots: p),
        ),
      ),
    ];
  }

  late final List<StreamSubscription<Object?>> _subscriptions;

  @override
  Future<void> close() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    return super.close();
  }
}

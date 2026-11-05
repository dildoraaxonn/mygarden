import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../fruit_types/data/fruit_type_repository.dart';
import '../../journal/data/journal_repository.dart';
import '../../plots/data/plot_repository.dart';
import '../../records/data/records_repository.dart';
import '../../trees/data/tree_repository.dart';
import '../../trees/domain/fruiting.dart';

class PlotSummary extends Equatable {
  const PlotSummary(this.plot, this.treeCount);

  final Plot plot;
  final int treeCount;

  @override
  List<Object?> get props => [plot, treeCount];
}

class UpcomingFruit extends Equatable {
  const UpcomingFruit({
    required this.tree,
    required this.fruitType,
    required this.plot,
    required this.forecast,
  });

  final Tree tree;
  final FruitType fruitType;
  final Plot plot;
  final FruitingForecast forecast;

  @override
  List<Object?> get props => [tree, fruitType, plot, forecast.status];
}

/// Everything the home screen shows.
class HomeState extends Equatable {
  const HomeState({
    this.loaded = false,
    this.plots = const [],
    this.treesById = const {},
    this.totalTrees = 0,
    this.countsByType = const {},
    this.fruitingCount = 0,
    this.upcoming = const [],
    this.lastCare = const {},
    this.yearIncome = 0,
    this.yearSpent = 0,
    this.recentJournal = const [],
  });

  /// Care kinds shown in the "last care" card.
  static const careKinds = [
    JournalKind.watered,
    JournalKind.fertilized,
    JournalKind.sprayed,
  ];

  /// Builds the home summary from raw data. Kept pure so it is easy to test.
  factory HomeState.compute({
    required List<Plot> plots,
    required List<Tree> trees,
    required List<FruitType> fruitTypes,
    required List<JournalEntry> journal,
    required List<Sale> sales,
    required List<Expense> expenses,
    required DateTime now,
  }) {
    final typesById = {for (final t in fruitTypes) t.id: t};
    final plotsById = {for (final p in plots) p.id: p};
    final horizon = DateTime(now.year, now.month + 6, now.day);

    final countsByType = <int, int>{};
    final countsByPlot = <int, int>{};
    final upcoming = <UpcomingFruit>[];
    var fruiting = 0;

    for (final tree in trees) {
      countsByType.update(tree.fruitTypeId, (c) => c + 1, ifAbsent: () => 1);
      countsByPlot.update(tree.plotId, (c) => c + 1, ifAbsent: () => 1);
      if (tree.stage == TreeStage.fruiting) fruiting++;

      final type = typesById[tree.fruitTypeId];
      final plot = plotsById[tree.plotId];
      if (type == null || plot == null) continue;
      final forecast = forecastFruiting(tree, type, now);
      final soon =
          forecast.status == FruitingStatus.due ||
          (forecast.status == FruitingStatus.upcoming &&
              !forecast.expectedDate!.isAfter(horizon));
      if (soon) {
        upcoming.add(
          UpcomingFruit(
            tree: tree,
            fruitType: type,
            plot: plot,
            forecast: forecast,
          ),
        );
      }
    }
    upcoming.sort(
      (a, b) => a.forecast.expectedDate!.compareTo(b.forecast.expectedDate!),
    );

    // Journal is newest first, so the first match is the latest.
    final lastCare = <JournalKind, DateTime>{};
    for (final entry in journal) {
      if (careKinds.contains(entry.kind)) {
        lastCare.putIfAbsent(entry.kind, () => entry.date);
      }
    }

    return HomeState(
      loaded: true,
      plots: [for (final p in plots) PlotSummary(p, countsByPlot[p.id] ?? 0)],
      treesById: {for (final t in trees) t.id: t},
      totalTrees: trees.length,
      countsByType: countsByType,
      fruitingCount: fruiting,
      upcoming: upcoming,
      lastCare: lastCare,
      yearIncome: sales
          .where((s) => s.date.year == now.year)
          .fold(0, (sum, s) => sum + s.amount),
      yearSpent: expenses
          .where((e) => e.date.year == now.year)
          .fold(0, (sum, e) => sum + e.amount),
      recentJournal: journal.take(5).toList(),
    );
  }

  final bool loaded;
  final List<PlotSummary> plots;
  final Map<int, Tree> treesById;
  final int totalTrees;

  /// Fruit type id -> number of trees.
  final Map<int, int> countsByType;
  final int fruitingCount;
  final List<UpcomingFruit> upcoming;
  final Map<JournalKind, DateTime> lastCare;
  final int yearIncome;
  final int yearSpent;
  final List<JournalEntry> recentJournal;

  Plot? plotById(int id) {
    for (final s in plots) {
      if (s.plot.id == id) return s.plot;
    }
    return null;
  }

  @override
  List<Object?> get props => [
    loaded,
    plots,
    treesById,
    countsByType,
    fruitingCount,
    upcoming,
    lastCare,
    yearIncome,
    yearSpent,
    recentJournal,
  ];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required PlotRepository plots,
    required TreeRepository trees,
    required FruitTypeRepository fruitTypes,
    required JournalRepository journal,
    required RecordsRepository records,
  }) : super(const HomeState()) {
    _subscriptions = [
      plots.watchAll().listen((v) => _set(() => _plots = v)),
      trees.watchAll().listen((v) => _set(() => _trees = v)),
      fruitTypes.watchAll().listen((v) => _set(() => _types = v)),
      journal.watchAll().listen((v) => _set(() => _journal = v)),
      records.watchSales().listen((v) => _set(() => _sales = v)),
      records.watchExpenses().listen((v) => _set(() => _expenses = v)),
    ];
  }

  late final List<StreamSubscription<Object?>> _subscriptions;
  List<Plot>? _plots;
  List<Tree>? _trees;
  List<FruitType>? _types;
  List<JournalEntry>? _journal;
  List<Sale>? _sales;
  List<Expense>? _expenses;

  void _set(void Function() assign) {
    assign();
    final plots = _plots, trees = _trees, types = _types;
    final journal = _journal, sales = _sales, expenses = _expenses;
    if (plots == null ||
        trees == null ||
        types == null ||
        journal == null ||
        sales == null ||
        expenses == null) {
      return;
    }
    emit(
      HomeState.compute(
        plots: plots,
        trees: trees,
        fruitTypes: types,
        journal: journal,
        sales: sales,
        expenses: expenses,
        now: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> close() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    return super.close();
  }
}

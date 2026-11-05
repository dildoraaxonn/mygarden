import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../data/records_repository.dart';

enum RecordsPeriod { month, year, all }

/// Totals for a period. Pure, so it is easy to test.
class RecordsSummary extends Equatable {
  const RecordsSummary({
    required this.income,
    required this.spent,
    required this.harvestKgByType,
    required this.soldKgByType,
    required this.incomeByType,
    required this.spentByCategory,
  });

  factory RecordsSummary.of({
    required List<Harvest> harvests,
    required List<Sale> sales,
    required List<Expense> expenses,
  }) {
    final harvestKg = <int, double>{};
    for (final h in harvests) {
      harvestKg.update(h.fruitTypeId, (v) => v + h.kg, ifAbsent: () => h.kg);
    }
    final soldKg = <int, double>{};
    final incomeByType = <int?, int>{};
    var income = 0;
    for (final s in sales) {
      income += s.amount;
      incomeByType.update(
        s.fruitTypeId,
        (v) => v + s.amount,
        ifAbsent: () => s.amount,
      );
      final kg = s.kg;
      final type = s.fruitTypeId;
      if (kg != null && type != null) {
        soldKg.update(type, (v) => v + kg, ifAbsent: () => kg);
      }
    }
    final byCategory = <ExpenseCategory, int>{};
    var spent = 0;
    for (final e in expenses) {
      spent += e.amount;
      byCategory.update(
        e.category,
        (v) => v + e.amount,
        ifAbsent: () => e.amount,
      );
    }
    return RecordsSummary(
      income: income,
      spent: spent,
      harvestKgByType: harvestKg,
      soldKgByType: soldKg,
      incomeByType: incomeByType,
      spentByCategory: byCategory,
    );
  }

  final int income;
  final int spent;
  int get profit => income - spent;

  /// Fruit type id -> kg.
  final Map<int, double> harvestKgByType;
  final Map<int, double> soldKgByType;

  /// Fruit type id (null = not specified) -> so'm.
  final Map<int?, int> incomeByType;
  final Map<ExpenseCategory, int> spentByCategory;

  @override
  List<Object?> get props => [
    income,
    spent,
    harvestKgByType,
    soldKgByType,
    incomeByType,
    spentByCategory,
  ];
}

class RecordsState extends Equatable {
  const RecordsState({
    this.loaded = false,
    this.period = RecordsPeriod.year,
    this.allHarvests = const [],
    this.allSales = const [],
    this.allExpenses = const [],
    DateTime? now,
  }) : _now = now;

  final bool loaded;
  final RecordsPeriod period;
  final List<Harvest> allHarvests;
  final List<Sale> allSales;
  final List<Expense> allExpenses;
  final DateTime? _now;

  DateTime get now => _now ?? DateTime.now();

  bool inPeriod(DateTime date) => switch (period) {
    RecordsPeriod.month => date.year == now.year && date.month == now.month,
    RecordsPeriod.year => date.year == now.year,
    RecordsPeriod.all => true,
  };

  List<Harvest> get harvests =>
      allHarvests.where((h) => inPeriod(h.date)).toList();
  List<Sale> get sales => allSales.where((s) => inPeriod(s.date)).toList();
  List<Expense> get expenses =>
      allExpenses.where((e) => inPeriod(e.date)).toList();

  RecordsSummary get summary =>
      RecordsSummary.of(harvests: harvests, sales: sales, expenses: expenses);

  RecordsState copyWith({
    bool? loaded,
    RecordsPeriod? period,
    List<Harvest>? allHarvests,
    List<Sale>? allSales,
    List<Expense>? allExpenses,
  }) {
    return RecordsState(
      loaded: loaded ?? this.loaded,
      period: period ?? this.period,
      allHarvests: allHarvests ?? this.allHarvests,
      allSales: allSales ?? this.allSales,
      allExpenses: allExpenses ?? this.allExpenses,
      now: _now,
    );
  }

  @override
  List<Object?> get props => [
    loaded,
    period,
    allHarvests,
    allSales,
    allExpenses,
  ];
}

class RecordsCubit extends Cubit<RecordsState> {
  RecordsCubit(this._repository) : super(const RecordsState()) {
    _subscriptions = [
      _repository.watchHarvests().listen((v) {
        _received.add('harvests');
        emit(state.copyWith(allHarvests: v, loaded: _received.length == 3));
      }),
      _repository.watchSales().listen((v) {
        _received.add('sales');
        emit(state.copyWith(allSales: v, loaded: _received.length == 3));
      }),
      _repository.watchExpenses().listen((v) {
        _received.add('expenses');
        emit(state.copyWith(allExpenses: v, loaded: _received.length == 3));
      }),
    ];
  }

  final RecordsRepository _repository;
  late final List<StreamSubscription<Object?>> _subscriptions;

  /// Which streams have delivered their first value.
  final _received = <String>{};

  void setPeriod(RecordsPeriod period) => emit(state.copyWith(period: period));

  Future<void> deleteHarvest(int id) => _repository.deleteHarvest(id);
  Future<void> deleteSale(int id) => _repository.deleteSale(id);
  Future<void> deleteExpense(int id) => _repository.deleteExpense(id);

  @override
  Future<void> close() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    return super.close();
  }
}

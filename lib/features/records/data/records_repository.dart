import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Harvests, sales and expenses.
class RecordsRepository {
  RecordsRepository(this._db);

  final AppDatabase _db;

  Stream<List<Harvest>> watchHarvests() =>
      (_db.select(_db.harvests)..orderBy([
            (h) => OrderingTerm(expression: h.date, mode: OrderingMode.desc),
            (h) => OrderingTerm(expression: h.id, mode: OrderingMode.desc),
          ]))
          .watch();

  Stream<List<Harvest>> watchHarvestsForTree(int treeId) =>
      (_db.select(_db.harvests)
            ..where((h) => h.treeId.equals(treeId))
            ..orderBy([
              (h) => OrderingTerm(expression: h.date, mode: OrderingMode.desc),
            ]))
          .watch();

  Stream<List<Sale>> watchSales() =>
      (_db.select(_db.sales)..orderBy([
            (s) => OrderingTerm(expression: s.date, mode: OrderingMode.desc),
            (s) => OrderingTerm(expression: s.id, mode: OrderingMode.desc),
          ]))
          .watch();

  Stream<List<Expense>> watchExpenses() =>
      (_db.select(_db.expenses)..orderBy([
            (e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc),
            (e) => OrderingTerm(expression: e.id, mode: OrderingMode.desc),
          ]))
          .watch();

  /// Inserts a new harvest, or updates it when `id` is set. A harvest from a
  /// tree also marks that tree as fruiting.
  Future<void> saveHarvest(HarvestsCompanion harvest) {
    return _db.transaction(() async {
      await _db.into(_db.harvests).insertOnConflictUpdate(harvest);
      final treeId = harvest.treeId.present ? harvest.treeId.value : null;
      if (treeId != null) {
        await (_db.update(_db.trees)..where((t) => t.id.equals(treeId))).write(
          const TreesCompanion(stage: Value(TreeStage.fruiting)),
        );
      }
    });
  }

  Future<void> saveSale(SalesCompanion sale) =>
      _db.into(_db.sales).insertOnConflictUpdate(sale);

  Future<void> saveExpense(ExpensesCompanion expense) =>
      _db.into(_db.expenses).insertOnConflictUpdate(expense);

  Future<void> deleteHarvest(int id) =>
      (_db.delete(_db.harvests)..where((h) => h.id.equals(id))).go();

  Future<void> deleteSale(int id) =>
      (_db.delete(_db.sales)..where((s) => s.id.equals(id))).go();

  Future<void> deleteExpense(int id) =>
      (_db.delete(_db.expenses)..where((e) => e.id.equals(id))).go();
}

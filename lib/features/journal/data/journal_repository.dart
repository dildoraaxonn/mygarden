import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// The garden diary: watering, fertilizing, spraying, notes...
class JournalRepository {
  JournalRepository(this._db);

  final AppDatabase _db;

  List<OrderingTerm Function($JournalEntriesTable)> get _newestFirst => [
    (j) => OrderingTerm(expression: j.date, mode: OrderingMode.desc),
    (j) => OrderingTerm(expression: j.id, mode: OrderingMode.desc),
  ];

  Stream<List<JournalEntry>> watchAll() =>
      (_db.select(_db.journalEntries)..orderBy(_newestFirst)).watch();

  /// Entries for this tree, plus entries for its whole greenhouse.
  Stream<List<JournalEntry>> watchForTree(Tree tree) =>
      (_db.select(_db.journalEntries)
            ..where(
              (j) =>
                  j.treeId.equals(tree.id) |
                  (j.treeId.isNull() & j.plotId.equals(tree.plotId)),
            )
            ..orderBy(_newestFirst))
          .watch();

  /// Logs an event for one tree. "Flowering" also moves the tree's stage
  /// forward, so the map shows it without an extra step.
  Future<void> logForTree(
    Tree tree,
    JournalKind kind, {
    String? note,
    DateTime? date,
  }) {
    return _db.transaction(() async {
      await _db
          .into(_db.journalEntries)
          .insert(
            JournalEntriesCompanion.insert(
              plotId: tree.plotId,
              treeId: Value(tree.id),
              kind: kind,
              note: Value(note),
              date: date ?? DateTime.now(),
            ),
          );
      if (kind == JournalKind.flowering &&
          tree.stage.index < TreeStage.flowering.index) {
        await (_db.update(_db.trees)..where((t) => t.id.equals(tree.id))).write(
          const TreesCompanion(stage: Value(TreeStage.flowering)),
        );
      }
    });
  }

  /// Logs an event for a whole greenhouse (e.g. watered everything).
  Future<void> logForPlot(
    int plotId,
    JournalKind kind, {
    String? note,
    DateTime? date,
  }) async {
    await _db
        .into(_db.journalEntries)
        .insert(
          JournalEntriesCompanion.insert(
            plotId: plotId,
            kind: kind,
            note: Value(note),
            date: date ?? DateTime.now(),
          ),
        );
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.journalEntries)..where((j) => j.id.equals(id))).go();
  }
}

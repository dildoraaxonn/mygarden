import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class FruitTypeRepository {
  FruitTypeRepository(this._db);

  final AppDatabase _db;

  Stream<List<FruitType>> watchAll() => (_db.select(
    _db.fruitTypes,
  )..orderBy([(f) => OrderingTerm(expression: f.id)])).watch();

  Future<int> add({
    required String nameEn,
    required String nameRu,
    required String emoji,
    required int monthsToFruit,
  }) {
    return _db
        .into(_db.fruitTypes)
        .insert(
          FruitTypesCompanion.insert(
            nameEn: nameEn,
            nameRu: nameRu,
            emoji: Value(emoji),
            monthsToFruit: Value(monthsToFruit),
          ),
        );
  }

  Future<void> update(FruitType type) async {
    await _db.update(_db.fruitTypes).replace(type);
  }

  /// Deletes the fruit type. Returns false (and deletes nothing) when trees,
  /// harvests or sales still refer to it.
  Future<bool> delete(int id) async {
    final used = await _db
        .customSelect(
          'SELECT (SELECT COUNT(*) FROM trees WHERE fruit_type_id = ?1)'
          ' + (SELECT COUNT(*) FROM harvests WHERE fruit_type_id = ?1)'
          ' + (SELECT COUNT(*) FROM sales WHERE fruit_type_id = ?1) AS used',
          variables: [Variable.withInt(id)],
        )
        .map((row) => row.read<int>('used'))
        .getSingle();
    if (used > 0) return false;

    await (_db.delete(_db.fruitTypes)..where((f) => f.id.equals(id))).go();
    return true;
  }
}

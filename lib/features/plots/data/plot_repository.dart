import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class PlotRepository {
  PlotRepository(this._db);

  final AppDatabase _db;

  Stream<List<Plot>> watchAll() => (_db.select(
    _db.plots,
  )..orderBy([(p) => OrderingTerm(expression: p.id)])).watch();

  Stream<Plot?> watch(int id) => (_db.select(
    _db.plots,
  )..where((p) => p.id.equals(id))).watchSingleOrNull();

  Future<void> update(Plot plot) async {
    await _db.update(_db.plots).replace(plot);
  }
}

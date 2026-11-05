import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/storage/photo_storage.dart';

class TreeRepository {
  TreeRepository(this._db, this._photos);

  final AppDatabase _db;
  final PhotoStorage _photos;

  Stream<List<Tree>> watchAll() =>
      (_db.select(_db.trees)..orderBy([
            (t) => OrderingTerm(expression: t.plotId),
            (t) => OrderingTerm(expression: t.id),
          ]))
          .watch();

  Stream<List<Tree>> watchByPlot(int plotId) =>
      (_db.select(_db.trees)
            ..where((t) => t.plotId.equals(plotId))
            ..orderBy([(t) => OrderingTerm(expression: t.id)]))
          .watch();

  Stream<Tree?> watch(int id) => (_db.select(
    _db.trees,
  )..where((t) => t.id.equals(id))).watchSingleOrNull();

  /// Adds a tree at a spot on the map (meters) and returns its id.
  Future<int> add({
    required int plotId,
    required int fruitTypeId,
    required double xM,
    required double yM,
  }) {
    return _db
        .into(_db.trees)
        .insert(
          TreesCompanion.insert(
            plotId: plotId,
            fruitTypeId: fruitTypeId,
            xM: xM,
            yM: yM,
          ),
        );
  }

  Future<void> update(Tree tree) async {
    await _db.update(_db.trees).replace(tree);
  }

  Future<void> move(int id, {required double xM, required double yM}) async {
    await (_db.update(_db.trees)..where((t) => t.id.equals(id))).write(
      TreesCompanion(xM: Value(xM), yM: Value(yM)),
    );
  }

  /// Pulls trees back inside the greenhouse after it was made smaller.
  Future<void> keepInside(
    int plotId, {
    required double widthM,
    required double lengthM,
  }) {
    return _db.customUpdate(
      'UPDATE trees SET x_m = MIN(x_m, ?), y_m = MIN(y_m, ?) WHERE plot_id = ?',
      variables: [
        Variable.withReal(lengthM - 0.5),
        Variable.withReal(widthM - 0.5),
        Variable.withInt(plotId),
      ],
      updates: {_db.trees},
    );
  }

  /// Deletes the tree, its diary, diagnoses and photos. Harvest records are
  /// kept.
  Future<void> delete(int id) async {
    final photos = await (_db.select(
      _db.treePhotos,
    )..where((p) => p.treeId.equals(id))).get();
    await _db.transaction(() async {
      await (_db.delete(
        _db.treePhotos,
      )..where((p) => p.treeId.equals(id))).go();
      await (_db.delete(
        _db.journalEntries,
      )..where((j) => j.treeId.equals(id))).go();
      await (_db.delete(_db.diagnoses)..where((d) => d.treeId.equals(id))).go();
      await (_db.update(_db.harvests)..where((h) => h.treeId.equals(id))).write(
        const HarvestsCompanion(treeId: Value(null)),
      );
      await (_db.delete(_db.trees)..where((t) => t.id.equals(id))).go();
    });
    for (final photo in photos) {
      await _photos.delete(photo.fileName);
    }
  }

  Stream<List<TreePhoto>> watchPhotos(int treeId) =>
      (_db.select(_db.treePhotos)
            ..where((p) => p.treeId.equals(treeId))
            ..orderBy([
              (p) =>
                  OrderingTerm(expression: p.takenAt, mode: OrderingMode.desc),
              (p) => OrderingTerm(expression: p.id, mode: OrderingMode.desc),
            ]))
          .watch();

  /// Copies the image into app storage, links it to the tree, and returns
  /// the stored file name.
  Future<String> addPhoto(int treeId, String sourcePath) async {
    final fileName = await _photos.save(sourcePath);
    await _db
        .into(_db.treePhotos)
        .insert(TreePhotosCompanion.insert(treeId: treeId, fileName: fileName));
    return fileName;
  }

  Future<void> deletePhoto(TreePhoto photo) async {
    await (_db.delete(
      _db.treePhotos,
    )..where((p) => p.id.equals(photo.id))).go();
    await _photos.delete(photo.fileName);
  }
}

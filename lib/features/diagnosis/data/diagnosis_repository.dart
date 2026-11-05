import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../trees/data/tree_repository.dart';
import 'diagnosis_api.dart';
import 'models/diagnosis.dart';
import 'models/diagnosis_request.dart';

/// Builds the request from what we know about the tree, sends it, and keeps
/// the photo and answer in the tree's history.
class DiagnosisRepository {
  DiagnosisRepository(this._db, this._trees, this._api);

  final AppDatabase _db;
  final TreeRepository _trees;
  final DiagnosisApi _api;

  bool get isDemo => _api.isDemo;

  Future<DiagnosisRecord> diagnose({
    required int treeId,
    required String imagePath,
    required String language,
    String? question,
    String? location,
    double? outsideMinTempC,
    CancelToken? cancel,
  }) async {
    final tree = await (_db.select(
      _db.trees,
    )..where((t) => t.id.equals(treeId))).getSingle();
    final type = await (_db.select(
      _db.fruitTypes,
    )..where((f) => f.id.equals(tree.fruitTypeId))).getSingle();
    final care =
        await (_db.select(_db.journalEntries)
              ..where(
                (j) =>
                    j.treeId.equals(tree.id) |
                    (j.treeId.isNull() & j.plotId.equals(tree.plotId)),
              )
              ..orderBy([
                (j) =>
                    OrderingTerm(expression: j.date, mode: OrderingMode.desc),
              ])
              ..limit(8))
            .get();

    final diagnosis = await _api.diagnose(
      DiagnosisRequest(
        imagePath: imagePath,
        language: language,
        fruit: type.nameEn,
        fruitLocal: language == 'ru' ? type.nameRu : null,
        variety: tree.variety,
        stage: tree.stage.name,
        plantedOn: tree.plantedOn,
        location: location,
        outsideMinTempC: outsideMinTempC,
        question: question,
        recentCare: [
          for (final c in care)
            CareEvent(kind: c.kind.name, date: c.date, note: c.note),
        ],
      ),
      cancel: cancel,
    );

    // Only keep the photo once we have an answer worth keeping.
    final fileName = await _trees.addPhoto(treeId, imagePath);
    final id = await _db
        .into(_db.diagnoses)
        .insert(
          DiagnosesCompanion.insert(
            treeId: treeId,
            photoFileName: Value(fileName),
            question: Value(question),
            healthy: diagnosis.healthy,
            summary: diagnosis.summary,
            resultJson: jsonEncode(diagnosis.toJson()),
            date: DateTime.now(),
          ),
        );
    return (_db.select(
      _db.diagnoses,
    )..where((d) => d.id.equals(id))).getSingle();
  }

  Stream<List<DiagnosisRecord>> watchForTree(int treeId) =>
      (_db.select(_db.diagnoses)
            ..where((d) => d.treeId.equals(treeId))
            ..orderBy([
              (d) => OrderingTerm(expression: d.date, mode: OrderingMode.desc),
            ]))
          .watch();

  Stream<DiagnosisRecord?> watch(int id) => (_db.select(
    _db.diagnoses,
  )..where((d) => d.id.equals(id))).watchSingleOrNull();

  /// Deletes the diagnosis; its photo stays in the tree's photos.
  Future<void> delete(int id) =>
      (_db.delete(_db.diagnoses)..where((d) => d.id.equals(id))).go();

  static Diagnosis decode(DiagnosisRecord record) =>
      Diagnosis.fromJson(jsonDecode(record.resultJson) as Map<String, dynamic>);
}

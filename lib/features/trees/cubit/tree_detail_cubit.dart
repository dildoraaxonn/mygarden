import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../diagnosis/data/diagnosis_repository.dart';
import '../../journal/data/journal_repository.dart';
import '../../plots/data/plot_repository.dart';
import '../../records/data/records_repository.dart';
import '../data/tree_repository.dart';

class TreeDetailState extends Equatable {
  const TreeDetailState({
    this.loaded = false,
    this.tree,
    this.plots = const [],
    this.photos = const [],
    this.journal = const [],
    this.harvests = const [],
    this.diagnoses = const [],
  });

  final bool loaded;

  /// Null once loaded means the tree was deleted.
  final Tree? tree;
  final List<Plot> plots;
  final List<TreePhoto> photos;

  /// Diary entries for this tree and its whole greenhouse, newest first.
  final List<JournalEntry> journal;
  final List<Harvest> harvests;
  final List<DiagnosisRecord> diagnoses;

  Plot? get plot {
    for (final p in plots) {
      if (p.id == tree?.plotId) return p;
    }
    return null;
  }

  double get totalHarvestKg => harvests.fold(0, (sum, h) => sum + h.kg);

  TreeDetailState copyWith({
    bool? loaded,
    Tree? Function()? tree,
    List<Plot>? plots,
    List<TreePhoto>? photos,
    List<JournalEntry>? journal,
    List<Harvest>? harvests,
    List<DiagnosisRecord>? diagnoses,
  }) {
    return TreeDetailState(
      loaded: loaded ?? this.loaded,
      tree: tree != null ? tree() : this.tree,
      plots: plots ?? this.plots,
      photos: photos ?? this.photos,
      journal: journal ?? this.journal,
      harvests: harvests ?? this.harvests,
      diagnoses: diagnoses ?? this.diagnoses,
    );
  }

  @override
  List<Object?> get props => [
    loaded,
    tree,
    plots,
    photos,
    journal,
    harvests,
    diagnoses,
  ];
}

class TreeDetailCubit extends Cubit<TreeDetailState> {
  TreeDetailCubit({
    required this.treeId,
    required TreeRepository trees,
    required PlotRepository plots,
    required JournalRepository journal,
    required RecordsRepository records,
    required DiagnosisRepository diagnoses,
  }) : _trees = trees,
       _journal = journal,
       super(const TreeDetailState()) {
    _subscriptions = [
      trees.watch(treeId).listen(_onTree),
      plots.watchAll().listen((p) => emit(state.copyWith(plots: p))),
      trees.watchPhotos(treeId).listen((p) => emit(state.copyWith(photos: p))),
      records
          .watchHarvestsForTree(treeId)
          .listen((h) => emit(state.copyWith(harvests: h))),
      diagnoses
          .watchForTree(treeId)
          .listen((d) => emit(state.copyWith(diagnoses: d))),
    ];
  }

  final int treeId;
  final TreeRepository _trees;
  final JournalRepository _journal;
  late final List<StreamSubscription<Object?>> _subscriptions;
  StreamSubscription<List<JournalEntry>>? _journalSubscription;

  void _onTree(Tree? tree) {
    // The diary query needs the tree's greenhouse, so start it once known.
    if (tree != null && _journalSubscription == null) {
      _journalSubscription = _journal
          .watchForTree(tree)
          .listen((j) => emit(state.copyWith(journal: j)));
    }
    emit(state.copyWith(loaded: true, tree: () => tree));
  }

  Future<void> _edit(Tree Function(Tree tree) change) async {
    final tree = state.tree;
    if (tree != null) await _trees.update(change(tree));
  }

  Future<void> setStage(TreeStage stage) =>
      _edit((t) => t.copyWith(stage: stage));

  Future<void> setPlantedOn(DateTime? date) =>
      _edit((t) => t.copyWith(plantedOn: Value(date)));

  Future<void> setVariety(String text) =>
      _edit((t) => t.copyWith(variety: Value(text.isEmpty ? null : text)));

  Future<void> setNotes(String text) =>
      _edit((t) => t.copyWith(notes: Value(text.isEmpty ? null : text)));

  Future<void> addPhoto(String sourcePath) =>
      _trees.addPhoto(treeId, sourcePath);

  Future<void> deletePhoto(TreePhoto photo) => _trees.deletePhoto(photo);

  Future<void> deleteJournalEntry(int id) => _journal.delete(id);

  Future<void> deleteTree() => _trees.delete(treeId);

  @override
  Future<void> close() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    await _journalSubscription?.cancel();
    return super.close();
  }
}

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'seed_data.dart';

part 'app_database.g.dart';

// Enums are stored as their index, so only ever add new values at the end.

/// Life stage of a tree.
enum TreeStage { seedling, growing, flowering, fruiting }

/// What happened, in the garden diary.
enum JournalKind {
  watered,
  fertilized,
  sprayed,
  pruned,
  flowering,
  problem,
  note,
}

enum ExpenseCategory {
  fertilizer,
  plants,
  heating,
  utilities,
  greenhouse,
  tools,
  pestControl,
  other,
}

class FruitTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text()();
  TextColumn get nameRu => text()();
  TextColumn get emoji => text().withDefault(const Constant('🌳'))();

  /// Typical months from planting until the first harvest.
  IntColumn get monthsToFruit => integer().withDefault(const Constant(24))();
}

/// A greenhouse (or a piece of land).
class Plots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  /// Short side, drawn vertically on the map.
  RealColumn get widthM => real()();

  /// Long side, drawn horizontally on the map.
  RealColumn get lengthM => real()();
}

class Trees extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get plotId => integer().references(Plots, #id)();
  IntColumn get fruitTypeId => integer().references(FruitTypes, #id)();

  /// Position on the map in meters: x along the length, y across the width.
  RealColumn get xM => real()();
  RealColumn get yM => real()();
  TextColumn get variety => text().nullable()();
  DateTimeColumn get plantedOn => dateTime().nullable()();
  IntColumn get stage =>
      intEnum<TreeStage>().withDefault(const Constant(1))(); // growing
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TreePhotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();

  /// File name inside the app's photo folder (not a full path, because the
  /// app folder path can change between iOS updates).
  TextColumn get fileName => text()();
  DateTimeColumn get takenAt => dateTime().withDefault(currentDateAndTime)();
}

/// Garden diary. An entry belongs to one tree, or to a whole greenhouse
/// when [treeId] is null.
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get plotId => integer().references(Plots, #id)();
  IntColumn get treeId => integer().nullable().references(
    Trees,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get kind => intEnum<JournalKind>()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()();
}

class Harvests extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get fruitTypeId => integer().references(FruitTypes, #id)();

  /// Kept when the tree is deleted, so harvest history isn't lost.
  IntColumn get treeId => integer().nullable().references(
    Trees,
    #id,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get kg => real()();
  TextColumn get note => text().nullable()();
}

class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get fruitTypeId =>
      integer().nullable().references(FruitTypes, #id)();
  RealColumn get kg => real().nullable()();

  /// Total received, in so'm.
  IntColumn get amount => integer()();
  TextColumn get buyer => text().nullable()();
  TextColumn get note => text().nullable()();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get category => intEnum<ExpenseCategory>()();

  /// Amount spent, in so'm.
  IntColumn get amount => integer()();
  TextColumn get note => text().nullable()();
}

/// A plant-doctor answer for one photo of a tree.
@DataClassName('DiagnosisRecord')
class Diagnoses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();

  /// The photo that was checked (also kept in [TreePhotos]).
  TextColumn get photoFileName => text().nullable()();

  /// What the user asked, e.g. "leaves turn yellow".
  TextColumn get question => text().nullable()();
  BoolColumn get healthy => boolean()();

  /// Short one-line result, for lists and the timeline.
  TextColumn get summary => text()();

  /// The full API answer as JSON (problems, actions, tips...).
  TextColumn get resultJson => text()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(
  tables: [
    FruitTypes,
    Plots,
    Trees,
    TreePhotos,
    JournalEntries,
    Harvests,
    Sales,
    Expenses,
    Diagnoses,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'mygarden'));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await batch((b) {
        b.insertAll(fruitTypes, seedFruitTypes);
        b.insertAll(plots, seedPlots);
      });
    },
    onUpgrade: (m, from, to) async {
      await customStatement('PRAGMA foreign_keys = OFF');
      if (from < 2) await _migrateRowsToMap(m);
      if (from < 3) await m.createTable(diagnoses);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Version 1 stored trees by row and position. Version 2 uses a free map,
  /// so existing trees are laid out where their rows were: rows spread across
  /// the width, trees 1.5 m apart along the length.
  Future<void> _migrateRowsToMap(Migrator m) async {
    await m.alterTable(
      TableMigration(
        trees,
        newColumns: [trees.xM, trees.yM],
        columnTransformer: {
          trees.xM: const CustomExpression<double>(
            'MIN(position * 1.5 - 0.5, '
            '(SELECT p.length_m - 0.5 FROM plots p WHERE p.id = plot_id))',
          ),
          trees.yM: const CustomExpression<double>(
            '(row_number - 0.5) * '
            '(SELECT p.width_m / MAX(p.row_count, row_number) '
            'FROM plots p WHERE p.id = plot_id)',
          ),
        },
      ),
    );
    await m.alterTable(TableMigration(plots));
    await m.createTable(journalEntries);
    await m.createTable(harvests);
    await m.createTable(sales);
    await m.createTable(expenses);
  }
}

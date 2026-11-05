// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FruitTypesTable extends FruitTypes
    with TableInfo<$FruitTypesTable, FruitType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FruitTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameRuMeta = const VerificationMeta('nameRu');
  @override
  late final GeneratedColumn<String> nameRu = GeneratedColumn<String>(
    'name_ru',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('🌳'),
  );
  static const VerificationMeta _monthsToFruitMeta = const VerificationMeta(
    'monthsToFruit',
  );
  @override
  late final GeneratedColumn<int> monthsToFruit = GeneratedColumn<int>(
    'months_to_fruit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(24),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameRu,
    emoji,
    monthsToFruit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fruit_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<FruitType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_ru')) {
      context.handle(
        _nameRuMeta,
        nameRu.isAcceptableOrUnknown(data['name_ru']!, _nameRuMeta),
      );
    } else if (isInserting) {
      context.missing(_nameRuMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    }
    if (data.containsKey('months_to_fruit')) {
      context.handle(
        _monthsToFruitMeta,
        monthsToFruit.isAcceptableOrUnknown(
          data['months_to_fruit']!,
          _monthsToFruitMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FruitType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FruitType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameRu: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ru'],
      )!,
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      )!,
      monthsToFruit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}months_to_fruit'],
      )!,
    );
  }

  @override
  $FruitTypesTable createAlias(String alias) {
    return $FruitTypesTable(attachedDatabase, alias);
  }
}

class FruitType extends DataClass implements Insertable<FruitType> {
  final int id;
  final String nameEn;
  final String nameRu;
  final String emoji;

  /// Typical months from planting until the first harvest.
  final int monthsToFruit;
  const FruitType({
    required this.id,
    required this.nameEn,
    required this.nameRu,
    required this.emoji,
    required this.monthsToFruit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_ru'] = Variable<String>(nameRu);
    map['emoji'] = Variable<String>(emoji);
    map['months_to_fruit'] = Variable<int>(monthsToFruit);
    return map;
  }

  FruitTypesCompanion toCompanion(bool nullToAbsent) {
    return FruitTypesCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameRu: Value(nameRu),
      emoji: Value(emoji),
      monthsToFruit: Value(monthsToFruit),
    );
  }

  factory FruitType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FruitType(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameRu: serializer.fromJson<String>(json['nameRu']),
      emoji: serializer.fromJson<String>(json['emoji']),
      monthsToFruit: serializer.fromJson<int>(json['monthsToFruit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameRu': serializer.toJson<String>(nameRu),
      'emoji': serializer.toJson<String>(emoji),
      'monthsToFruit': serializer.toJson<int>(monthsToFruit),
    };
  }

  FruitType copyWith({
    int? id,
    String? nameEn,
    String? nameRu,
    String? emoji,
    int? monthsToFruit,
  }) => FruitType(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameRu: nameRu ?? this.nameRu,
    emoji: emoji ?? this.emoji,
    monthsToFruit: monthsToFruit ?? this.monthsToFruit,
  );
  FruitType copyWithCompanion(FruitTypesCompanion data) {
    return FruitType(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameRu: data.nameRu.present ? data.nameRu.value : this.nameRu,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      monthsToFruit: data.monthsToFruit.present
          ? data.monthsToFruit.value
          : this.monthsToFruit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FruitType(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameRu: $nameRu, ')
          ..write('emoji: $emoji, ')
          ..write('monthsToFruit: $monthsToFruit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameRu, emoji, monthsToFruit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FruitType &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameRu == this.nameRu &&
          other.emoji == this.emoji &&
          other.monthsToFruit == this.monthsToFruit);
}

class FruitTypesCompanion extends UpdateCompanion<FruitType> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameRu;
  final Value<String> emoji;
  final Value<int> monthsToFruit;
  const FruitTypesCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameRu = const Value.absent(),
    this.emoji = const Value.absent(),
    this.monthsToFruit = const Value.absent(),
  });
  FruitTypesCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameRu,
    this.emoji = const Value.absent(),
    this.monthsToFruit = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameRu = Value(nameRu);
  static Insertable<FruitType> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameRu,
    Expression<String>? emoji,
    Expression<int>? monthsToFruit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameRu != null) 'name_ru': nameRu,
      if (emoji != null) 'emoji': emoji,
      if (monthsToFruit != null) 'months_to_fruit': monthsToFruit,
    });
  }

  FruitTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameRu,
    Value<String>? emoji,
    Value<int>? monthsToFruit,
  }) {
    return FruitTypesCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameRu: nameRu ?? this.nameRu,
      emoji: emoji ?? this.emoji,
      monthsToFruit: monthsToFruit ?? this.monthsToFruit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameRu.present) {
      map['name_ru'] = Variable<String>(nameRu.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (monthsToFruit.present) {
      map['months_to_fruit'] = Variable<int>(monthsToFruit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FruitTypesCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameRu: $nameRu, ')
          ..write('emoji: $emoji, ')
          ..write('monthsToFruit: $monthsToFruit')
          ..write(')'))
        .toString();
  }
}

class $PlotsTable extends Plots with TableInfo<$PlotsTable, Plot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMMeta = const VerificationMeta('widthM');
  @override
  late final GeneratedColumn<double> widthM = GeneratedColumn<double>(
    'width_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lengthMMeta = const VerificationMeta(
    'lengthM',
  );
  @override
  late final GeneratedColumn<double> lengthM = GeneratedColumn<double>(
    'length_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, widthM, lengthM];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plots';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('width_m')) {
      context.handle(
        _widthMMeta,
        widthM.isAcceptableOrUnknown(data['width_m']!, _widthMMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMMeta);
    }
    if (data.containsKey('length_m')) {
      context.handle(
        _lengthMMeta,
        lengthM.isAcceptableOrUnknown(data['length_m']!, _lengthMMeta),
      );
    } else if (isInserting) {
      context.missing(_lengthMMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      widthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width_m'],
      )!,
      lengthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length_m'],
      )!,
    );
  }

  @override
  $PlotsTable createAlias(String alias) {
    return $PlotsTable(attachedDatabase, alias);
  }
}

class Plot extends DataClass implements Insertable<Plot> {
  final int id;
  final String name;

  /// Short side, drawn vertically on the map.
  final double widthM;

  /// Long side, drawn horizontally on the map.
  final double lengthM;
  const Plot({
    required this.id,
    required this.name,
    required this.widthM,
    required this.lengthM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['width_m'] = Variable<double>(widthM);
    map['length_m'] = Variable<double>(lengthM);
    return map;
  }

  PlotsCompanion toCompanion(bool nullToAbsent) {
    return PlotsCompanion(
      id: Value(id),
      name: Value(name),
      widthM: Value(widthM),
      lengthM: Value(lengthM),
    );
  }

  factory Plot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plot(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      widthM: serializer.fromJson<double>(json['widthM']),
      lengthM: serializer.fromJson<double>(json['lengthM']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'widthM': serializer.toJson<double>(widthM),
      'lengthM': serializer.toJson<double>(lengthM),
    };
  }

  Plot copyWith({int? id, String? name, double? widthM, double? lengthM}) =>
      Plot(
        id: id ?? this.id,
        name: name ?? this.name,
        widthM: widthM ?? this.widthM,
        lengthM: lengthM ?? this.lengthM,
      );
  Plot copyWithCompanion(PlotsCompanion data) {
    return Plot(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      widthM: data.widthM.present ? data.widthM.value : this.widthM,
      lengthM: data.lengthM.present ? data.lengthM.value : this.lengthM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plot(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('widthM: $widthM, ')
          ..write('lengthM: $lengthM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, widthM, lengthM);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plot &&
          other.id == this.id &&
          other.name == this.name &&
          other.widthM == this.widthM &&
          other.lengthM == this.lengthM);
}

class PlotsCompanion extends UpdateCompanion<Plot> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> widthM;
  final Value<double> lengthM;
  const PlotsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.widthM = const Value.absent(),
    this.lengthM = const Value.absent(),
  });
  PlotsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double widthM,
    required double lengthM,
  }) : name = Value(name),
       widthM = Value(widthM),
       lengthM = Value(lengthM);
  static Insertable<Plot> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? widthM,
    Expression<double>? lengthM,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (widthM != null) 'width_m': widthM,
      if (lengthM != null) 'length_m': lengthM,
    });
  }

  PlotsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? widthM,
    Value<double>? lengthM,
  }) {
    return PlotsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      widthM: widthM ?? this.widthM,
      lengthM: lengthM ?? this.lengthM,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (widthM.present) {
      map['width_m'] = Variable<double>(widthM.value);
    }
    if (lengthM.present) {
      map['length_m'] = Variable<double>(lengthM.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlotsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('widthM: $widthM, ')
          ..write('lengthM: $lengthM')
          ..write(')'))
        .toString();
  }
}

class $TreesTable extends Trees with TableInfo<$TreesTable, Tree> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _plotIdMeta = const VerificationMeta('plotId');
  @override
  late final GeneratedColumn<int> plotId = GeneratedColumn<int>(
    'plot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plots (id)',
    ),
  );
  static const VerificationMeta _fruitTypeIdMeta = const VerificationMeta(
    'fruitTypeId',
  );
  @override
  late final GeneratedColumn<int> fruitTypeId = GeneratedColumn<int>(
    'fruit_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fruit_types (id)',
    ),
  );
  static const VerificationMeta _xMMeta = const VerificationMeta('xM');
  @override
  late final GeneratedColumn<double> xM = GeneratedColumn<double>(
    'x_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMMeta = const VerificationMeta('yM');
  @override
  late final GeneratedColumn<double> yM = GeneratedColumn<double>(
    'y_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _varietyMeta = const VerificationMeta(
    'variety',
  );
  @override
  late final GeneratedColumn<String> variety = GeneratedColumn<String>(
    'variety',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plantedOnMeta = const VerificationMeta(
    'plantedOn',
  );
  @override
  late final GeneratedColumn<DateTime> plantedOn = GeneratedColumn<DateTime>(
    'planted_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TreeStage, int> stage =
      GeneratedColumn<int>(
        'stage',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(1),
      ).withConverter<TreeStage>($TreesTable.$converterstage);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    plotId,
    fruitTypeId,
    xM,
    yM,
    variety,
    plantedOn,
    stage,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tree> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plot_id')) {
      context.handle(
        _plotIdMeta,
        plotId.isAcceptableOrUnknown(data['plot_id']!, _plotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_plotIdMeta);
    }
    if (data.containsKey('fruit_type_id')) {
      context.handle(
        _fruitTypeIdMeta,
        fruitTypeId.isAcceptableOrUnknown(
          data['fruit_type_id']!,
          _fruitTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fruitTypeIdMeta);
    }
    if (data.containsKey('x_m')) {
      context.handle(_xMMeta, xM.isAcceptableOrUnknown(data['x_m']!, _xMMeta));
    } else if (isInserting) {
      context.missing(_xMMeta);
    }
    if (data.containsKey('y_m')) {
      context.handle(_yMMeta, yM.isAcceptableOrUnknown(data['y_m']!, _yMMeta));
    } else if (isInserting) {
      context.missing(_yMMeta);
    }
    if (data.containsKey('variety')) {
      context.handle(
        _varietyMeta,
        variety.isAcceptableOrUnknown(data['variety']!, _varietyMeta),
      );
    }
    if (data.containsKey('planted_on')) {
      context.handle(
        _plantedOnMeta,
        plantedOn.isAcceptableOrUnknown(data['planted_on']!, _plantedOnMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tree map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tree(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      plotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plot_id'],
      )!,
      fruitTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fruit_type_id'],
      )!,
      xM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x_m'],
      )!,
      yM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}y_m'],
      )!,
      variety: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variety'],
      ),
      plantedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planted_on'],
      ),
      stage: $TreesTable.$converterstage.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}stage'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TreesTable createAlias(String alias) {
    return $TreesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TreeStage, int, int> $converterstage =
      const EnumIndexConverter<TreeStage>(TreeStage.values);
}

class Tree extends DataClass implements Insertable<Tree> {
  final int id;
  final int plotId;
  final int fruitTypeId;

  /// Position on the map in meters: x along the length, y across the width.
  final double xM;
  final double yM;
  final String? variety;
  final DateTime? plantedOn;
  final TreeStage stage;
  final String? notes;
  final DateTime createdAt;
  const Tree({
    required this.id,
    required this.plotId,
    required this.fruitTypeId,
    required this.xM,
    required this.yM,
    this.variety,
    this.plantedOn,
    required this.stage,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plot_id'] = Variable<int>(plotId);
    map['fruit_type_id'] = Variable<int>(fruitTypeId);
    map['x_m'] = Variable<double>(xM);
    map['y_m'] = Variable<double>(yM);
    if (!nullToAbsent || variety != null) {
      map['variety'] = Variable<String>(variety);
    }
    if (!nullToAbsent || plantedOn != null) {
      map['planted_on'] = Variable<DateTime>(plantedOn);
    }
    {
      map['stage'] = Variable<int>($TreesTable.$converterstage.toSql(stage));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TreesCompanion toCompanion(bool nullToAbsent) {
    return TreesCompanion(
      id: Value(id),
      plotId: Value(plotId),
      fruitTypeId: Value(fruitTypeId),
      xM: Value(xM),
      yM: Value(yM),
      variety: variety == null && nullToAbsent
          ? const Value.absent()
          : Value(variety),
      plantedOn: plantedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(plantedOn),
      stage: Value(stage),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Tree.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tree(
      id: serializer.fromJson<int>(json['id']),
      plotId: serializer.fromJson<int>(json['plotId']),
      fruitTypeId: serializer.fromJson<int>(json['fruitTypeId']),
      xM: serializer.fromJson<double>(json['xM']),
      yM: serializer.fromJson<double>(json['yM']),
      variety: serializer.fromJson<String?>(json['variety']),
      plantedOn: serializer.fromJson<DateTime?>(json['plantedOn']),
      stage: $TreesTable.$converterstage.fromJson(
        serializer.fromJson<int>(json['stage']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plotId': serializer.toJson<int>(plotId),
      'fruitTypeId': serializer.toJson<int>(fruitTypeId),
      'xM': serializer.toJson<double>(xM),
      'yM': serializer.toJson<double>(yM),
      'variety': serializer.toJson<String?>(variety),
      'plantedOn': serializer.toJson<DateTime?>(plantedOn),
      'stage': serializer.toJson<int>(
        $TreesTable.$converterstage.toJson(stage),
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tree copyWith({
    int? id,
    int? plotId,
    int? fruitTypeId,
    double? xM,
    double? yM,
    Value<String?> variety = const Value.absent(),
    Value<DateTime?> plantedOn = const Value.absent(),
    TreeStage? stage,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Tree(
    id: id ?? this.id,
    plotId: plotId ?? this.plotId,
    fruitTypeId: fruitTypeId ?? this.fruitTypeId,
    xM: xM ?? this.xM,
    yM: yM ?? this.yM,
    variety: variety.present ? variety.value : this.variety,
    plantedOn: plantedOn.present ? plantedOn.value : this.plantedOn,
    stage: stage ?? this.stage,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Tree copyWithCompanion(TreesCompanion data) {
    return Tree(
      id: data.id.present ? data.id.value : this.id,
      plotId: data.plotId.present ? data.plotId.value : this.plotId,
      fruitTypeId: data.fruitTypeId.present
          ? data.fruitTypeId.value
          : this.fruitTypeId,
      xM: data.xM.present ? data.xM.value : this.xM,
      yM: data.yM.present ? data.yM.value : this.yM,
      variety: data.variety.present ? data.variety.value : this.variety,
      plantedOn: data.plantedOn.present ? data.plantedOn.value : this.plantedOn,
      stage: data.stage.present ? data.stage.value : this.stage,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tree(')
          ..write('id: $id, ')
          ..write('plotId: $plotId, ')
          ..write('fruitTypeId: $fruitTypeId, ')
          ..write('xM: $xM, ')
          ..write('yM: $yM, ')
          ..write('variety: $variety, ')
          ..write('plantedOn: $plantedOn, ')
          ..write('stage: $stage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    plotId,
    fruitTypeId,
    xM,
    yM,
    variety,
    plantedOn,
    stage,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tree &&
          other.id == this.id &&
          other.plotId == this.plotId &&
          other.fruitTypeId == this.fruitTypeId &&
          other.xM == this.xM &&
          other.yM == this.yM &&
          other.variety == this.variety &&
          other.plantedOn == this.plantedOn &&
          other.stage == this.stage &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class TreesCompanion extends UpdateCompanion<Tree> {
  final Value<int> id;
  final Value<int> plotId;
  final Value<int> fruitTypeId;
  final Value<double> xM;
  final Value<double> yM;
  final Value<String?> variety;
  final Value<DateTime?> plantedOn;
  final Value<TreeStage> stage;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const TreesCompanion({
    this.id = const Value.absent(),
    this.plotId = const Value.absent(),
    this.fruitTypeId = const Value.absent(),
    this.xM = const Value.absent(),
    this.yM = const Value.absent(),
    this.variety = const Value.absent(),
    this.plantedOn = const Value.absent(),
    this.stage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TreesCompanion.insert({
    this.id = const Value.absent(),
    required int plotId,
    required int fruitTypeId,
    required double xM,
    required double yM,
    this.variety = const Value.absent(),
    this.plantedOn = const Value.absent(),
    this.stage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : plotId = Value(plotId),
       fruitTypeId = Value(fruitTypeId),
       xM = Value(xM),
       yM = Value(yM);
  static Insertable<Tree> custom({
    Expression<int>? id,
    Expression<int>? plotId,
    Expression<int>? fruitTypeId,
    Expression<double>? xM,
    Expression<double>? yM,
    Expression<String>? variety,
    Expression<DateTime>? plantedOn,
    Expression<int>? stage,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plotId != null) 'plot_id': plotId,
      if (fruitTypeId != null) 'fruit_type_id': fruitTypeId,
      if (xM != null) 'x_m': xM,
      if (yM != null) 'y_m': yM,
      if (variety != null) 'variety': variety,
      if (plantedOn != null) 'planted_on': plantedOn,
      if (stage != null) 'stage': stage,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TreesCompanion copyWith({
    Value<int>? id,
    Value<int>? plotId,
    Value<int>? fruitTypeId,
    Value<double>? xM,
    Value<double>? yM,
    Value<String?>? variety,
    Value<DateTime?>? plantedOn,
    Value<TreeStage>? stage,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return TreesCompanion(
      id: id ?? this.id,
      plotId: plotId ?? this.plotId,
      fruitTypeId: fruitTypeId ?? this.fruitTypeId,
      xM: xM ?? this.xM,
      yM: yM ?? this.yM,
      variety: variety ?? this.variety,
      plantedOn: plantedOn ?? this.plantedOn,
      stage: stage ?? this.stage,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (plotId.present) {
      map['plot_id'] = Variable<int>(plotId.value);
    }
    if (fruitTypeId.present) {
      map['fruit_type_id'] = Variable<int>(fruitTypeId.value);
    }
    if (xM.present) {
      map['x_m'] = Variable<double>(xM.value);
    }
    if (yM.present) {
      map['y_m'] = Variable<double>(yM.value);
    }
    if (variety.present) {
      map['variety'] = Variable<String>(variety.value);
    }
    if (plantedOn.present) {
      map['planted_on'] = Variable<DateTime>(plantedOn.value);
    }
    if (stage.present) {
      map['stage'] = Variable<int>(
        $TreesTable.$converterstage.toSql(stage.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreesCompanion(')
          ..write('id: $id, ')
          ..write('plotId: $plotId, ')
          ..write('fruitTypeId: $fruitTypeId, ')
          ..write('xM: $xM, ')
          ..write('yM: $yM, ')
          ..write('variety: $variety, ')
          ..write('plantedOn: $plantedOn, ')
          ..write('stage: $stage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TreePhotosTable extends TreePhotos
    with TableInfo<$TreePhotosTable, TreePhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<int> treeId = GeneratedColumn<int>(
    'tree_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, treeId, fileName, takenAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tree_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreePhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TreePhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreePhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tree_id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      )!,
    );
  }

  @override
  $TreePhotosTable createAlias(String alias) {
    return $TreePhotosTable(attachedDatabase, alias);
  }
}

class TreePhoto extends DataClass implements Insertable<TreePhoto> {
  final int id;
  final int treeId;

  /// File name inside the app's photo folder (not a full path, because the
  /// app folder path can change between iOS updates).
  final String fileName;
  final DateTime takenAt;
  const TreePhoto({
    required this.id,
    required this.treeId,
    required this.fileName,
    required this.takenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tree_id'] = Variable<int>(treeId);
    map['file_name'] = Variable<String>(fileName);
    map['taken_at'] = Variable<DateTime>(takenAt);
    return map;
  }

  TreePhotosCompanion toCompanion(bool nullToAbsent) {
    return TreePhotosCompanion(
      id: Value(id),
      treeId: Value(treeId),
      fileName: Value(fileName),
      takenAt: Value(takenAt),
    );
  }

  factory TreePhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreePhoto(
      id: serializer.fromJson<int>(json['id']),
      treeId: serializer.fromJson<int>(json['treeId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'treeId': serializer.toJson<int>(treeId),
      'fileName': serializer.toJson<String>(fileName),
      'takenAt': serializer.toJson<DateTime>(takenAt),
    };
  }

  TreePhoto copyWith({
    int? id,
    int? treeId,
    String? fileName,
    DateTime? takenAt,
  }) => TreePhoto(
    id: id ?? this.id,
    treeId: treeId ?? this.treeId,
    fileName: fileName ?? this.fileName,
    takenAt: takenAt ?? this.takenAt,
  );
  TreePhoto copyWithCompanion(TreePhotosCompanion data) {
    return TreePhoto(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreePhoto(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('fileName: $fileName, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, treeId, fileName, takenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreePhoto &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.fileName == this.fileName &&
          other.takenAt == this.takenAt);
}

class TreePhotosCompanion extends UpdateCompanion<TreePhoto> {
  final Value<int> id;
  final Value<int> treeId;
  final Value<String> fileName;
  final Value<DateTime> takenAt;
  const TreePhotosCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.takenAt = const Value.absent(),
  });
  TreePhotosCompanion.insert({
    this.id = const Value.absent(),
    required int treeId,
    required String fileName,
    this.takenAt = const Value.absent(),
  }) : treeId = Value(treeId),
       fileName = Value(fileName);
  static Insertable<TreePhoto> custom({
    Expression<int>? id,
    Expression<int>? treeId,
    Expression<String>? fileName,
    Expression<DateTime>? takenAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (fileName != null) 'file_name': fileName,
      if (takenAt != null) 'taken_at': takenAt,
    });
  }

  TreePhotosCompanion copyWith({
    Value<int>? id,
    Value<int>? treeId,
    Value<String>? fileName,
    Value<DateTime>? takenAt,
  }) {
    return TreePhotosCompanion(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      fileName: fileName ?? this.fileName,
      takenAt: takenAt ?? this.takenAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<int>(treeId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreePhotosCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('fileName: $fileName, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _plotIdMeta = const VerificationMeta('plotId');
  @override
  late final GeneratedColumn<int> plotId = GeneratedColumn<int>(
    'plot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plots (id)',
    ),
  );
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<int> treeId = GeneratedColumn<int>(
    'tree_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trees (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<JournalKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<JournalKind>($JournalEntriesTable.$converterkind);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, plotId, treeId, kind, note, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plot_id')) {
      context.handle(
        _plotIdMeta,
        plotId.isAcceptableOrUnknown(data['plot_id']!, _plotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_plotIdMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      plotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plot_id'],
      )!,
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tree_id'],
      ),
      kind: $JournalEntriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<JournalKind, int, int> $converterkind =
      const EnumIndexConverter<JournalKind>(JournalKind.values);
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final int plotId;
  final int? treeId;
  final JournalKind kind;
  final String? note;
  final DateTime date;
  const JournalEntry({
    required this.id,
    required this.plotId,
    this.treeId,
    required this.kind,
    this.note,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plot_id'] = Variable<int>(plotId);
    if (!nullToAbsent || treeId != null) {
      map['tree_id'] = Variable<int>(treeId);
    }
    {
      map['kind'] = Variable<int>(
        $JournalEntriesTable.$converterkind.toSql(kind),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      plotId: Value(plotId),
      treeId: treeId == null && nullToAbsent
          ? const Value.absent()
          : Value(treeId),
      kind: Value(kind),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      date: Value(date),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      plotId: serializer.fromJson<int>(json['plotId']),
      treeId: serializer.fromJson<int?>(json['treeId']),
      kind: $JournalEntriesTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      note: serializer.fromJson<String?>(json['note']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plotId': serializer.toJson<int>(plotId),
      'treeId': serializer.toJson<int?>(treeId),
      'kind': serializer.toJson<int>(
        $JournalEntriesTable.$converterkind.toJson(kind),
      ),
      'note': serializer.toJson<String?>(note),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  JournalEntry copyWith({
    int? id,
    int? plotId,
    Value<int?> treeId = const Value.absent(),
    JournalKind? kind,
    Value<String?> note = const Value.absent(),
    DateTime? date,
  }) => JournalEntry(
    id: id ?? this.id,
    plotId: plotId ?? this.plotId,
    treeId: treeId.present ? treeId.value : this.treeId,
    kind: kind ?? this.kind,
    note: note.present ? note.value : this.note,
    date: date ?? this.date,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      plotId: data.plotId.present ? data.plotId.value : this.plotId,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      kind: data.kind.present ? data.kind.value : this.kind,
      note: data.note.present ? data.note.value : this.note,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('plotId: $plotId, ')
          ..write('treeId: $treeId, ')
          ..write('kind: $kind, ')
          ..write('note: $note, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, plotId, treeId, kind, note, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.plotId == this.plotId &&
          other.treeId == this.treeId &&
          other.kind == this.kind &&
          other.note == this.note &&
          other.date == this.date);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<int> plotId;
  final Value<int?> treeId;
  final Value<JournalKind> kind;
  final Value<String?> note;
  final Value<DateTime> date;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.plotId = const Value.absent(),
    this.treeId = const Value.absent(),
    this.kind = const Value.absent(),
    this.note = const Value.absent(),
    this.date = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int plotId,
    this.treeId = const Value.absent(),
    required JournalKind kind,
    this.note = const Value.absent(),
    required DateTime date,
  }) : plotId = Value(plotId),
       kind = Value(kind),
       date = Value(date);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<int>? plotId,
    Expression<int>? treeId,
    Expression<int>? kind,
    Expression<String>? note,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plotId != null) 'plot_id': plotId,
      if (treeId != null) 'tree_id': treeId,
      if (kind != null) 'kind': kind,
      if (note != null) 'note': note,
      if (date != null) 'date': date,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? plotId,
    Value<int?>? treeId,
    Value<JournalKind>? kind,
    Value<String?>? note,
    Value<DateTime>? date,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      plotId: plotId ?? this.plotId,
      treeId: treeId ?? this.treeId,
      kind: kind ?? this.kind,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (plotId.present) {
      map['plot_id'] = Variable<int>(plotId.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<int>(treeId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $JournalEntriesTable.$converterkind.toSql(kind.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('plotId: $plotId, ')
          ..write('treeId: $treeId, ')
          ..write('kind: $kind, ')
          ..write('note: $note, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $HarvestsTable extends Harvests with TableInfo<$HarvestsTable, Harvest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HarvestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fruitTypeIdMeta = const VerificationMeta(
    'fruitTypeId',
  );
  @override
  late final GeneratedColumn<int> fruitTypeId = GeneratedColumn<int>(
    'fruit_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fruit_types (id)',
    ),
  );
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<int> treeId = GeneratedColumn<int>(
    'tree_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trees (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _kgMeta = const VerificationMeta('kg');
  @override
  late final GeneratedColumn<double> kg = GeneratedColumn<double>(
    'kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    fruitTypeId,
    treeId,
    kg,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'harvests';
  @override
  VerificationContext validateIntegrity(
    Insertable<Harvest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('fruit_type_id')) {
      context.handle(
        _fruitTypeIdMeta,
        fruitTypeId.isAcceptableOrUnknown(
          data['fruit_type_id']!,
          _fruitTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fruitTypeIdMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    }
    if (data.containsKey('kg')) {
      context.handle(_kgMeta, kg.isAcceptableOrUnknown(data['kg']!, _kgMeta));
    } else if (isInserting) {
      context.missing(_kgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Harvest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Harvest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      fruitTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fruit_type_id'],
      )!,
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tree_id'],
      ),
      kg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kg'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $HarvestsTable createAlias(String alias) {
    return $HarvestsTable(attachedDatabase, alias);
  }
}

class Harvest extends DataClass implements Insertable<Harvest> {
  final int id;
  final DateTime date;
  final int fruitTypeId;

  /// Kept when the tree is deleted, so harvest history isn't lost.
  final int? treeId;
  final double kg;
  final String? note;
  const Harvest({
    required this.id,
    required this.date,
    required this.fruitTypeId,
    this.treeId,
    required this.kg,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['fruit_type_id'] = Variable<int>(fruitTypeId);
    if (!nullToAbsent || treeId != null) {
      map['tree_id'] = Variable<int>(treeId);
    }
    map['kg'] = Variable<double>(kg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  HarvestsCompanion toCompanion(bool nullToAbsent) {
    return HarvestsCompanion(
      id: Value(id),
      date: Value(date),
      fruitTypeId: Value(fruitTypeId),
      treeId: treeId == null && nullToAbsent
          ? const Value.absent()
          : Value(treeId),
      kg: Value(kg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Harvest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Harvest(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      fruitTypeId: serializer.fromJson<int>(json['fruitTypeId']),
      treeId: serializer.fromJson<int?>(json['treeId']),
      kg: serializer.fromJson<double>(json['kg']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'fruitTypeId': serializer.toJson<int>(fruitTypeId),
      'treeId': serializer.toJson<int?>(treeId),
      'kg': serializer.toJson<double>(kg),
      'note': serializer.toJson<String?>(note),
    };
  }

  Harvest copyWith({
    int? id,
    DateTime? date,
    int? fruitTypeId,
    Value<int?> treeId = const Value.absent(),
    double? kg,
    Value<String?> note = const Value.absent(),
  }) => Harvest(
    id: id ?? this.id,
    date: date ?? this.date,
    fruitTypeId: fruitTypeId ?? this.fruitTypeId,
    treeId: treeId.present ? treeId.value : this.treeId,
    kg: kg ?? this.kg,
    note: note.present ? note.value : this.note,
  );
  Harvest copyWithCompanion(HarvestsCompanion data) {
    return Harvest(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      fruitTypeId: data.fruitTypeId.present
          ? data.fruitTypeId.value
          : this.fruitTypeId,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      kg: data.kg.present ? data.kg.value : this.kg,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Harvest(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('fruitTypeId: $fruitTypeId, ')
          ..write('treeId: $treeId, ')
          ..write('kg: $kg, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, fruitTypeId, treeId, kg, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Harvest &&
          other.id == this.id &&
          other.date == this.date &&
          other.fruitTypeId == this.fruitTypeId &&
          other.treeId == this.treeId &&
          other.kg == this.kg &&
          other.note == this.note);
}

class HarvestsCompanion extends UpdateCompanion<Harvest> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> fruitTypeId;
  final Value<int?> treeId;
  final Value<double> kg;
  final Value<String?> note;
  const HarvestsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.fruitTypeId = const Value.absent(),
    this.treeId = const Value.absent(),
    this.kg = const Value.absent(),
    this.note = const Value.absent(),
  });
  HarvestsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int fruitTypeId,
    this.treeId = const Value.absent(),
    required double kg,
    this.note = const Value.absent(),
  }) : date = Value(date),
       fruitTypeId = Value(fruitTypeId),
       kg = Value(kg);
  static Insertable<Harvest> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? fruitTypeId,
    Expression<int>? treeId,
    Expression<double>? kg,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (fruitTypeId != null) 'fruit_type_id': fruitTypeId,
      if (treeId != null) 'tree_id': treeId,
      if (kg != null) 'kg': kg,
      if (note != null) 'note': note,
    });
  }

  HarvestsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? fruitTypeId,
    Value<int?>? treeId,
    Value<double>? kg,
    Value<String?>? note,
  }) {
    return HarvestsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      fruitTypeId: fruitTypeId ?? this.fruitTypeId,
      treeId: treeId ?? this.treeId,
      kg: kg ?? this.kg,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (fruitTypeId.present) {
      map['fruit_type_id'] = Variable<int>(fruitTypeId.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<int>(treeId.value);
    }
    if (kg.present) {
      map['kg'] = Variable<double>(kg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HarvestsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('fruitTypeId: $fruitTypeId, ')
          ..write('treeId: $treeId, ')
          ..write('kg: $kg, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fruitTypeIdMeta = const VerificationMeta(
    'fruitTypeId',
  );
  @override
  late final GeneratedColumn<int> fruitTypeId = GeneratedColumn<int>(
    'fruit_type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fruit_types (id)',
    ),
  );
  static const VerificationMeta _kgMeta = const VerificationMeta('kg');
  @override
  late final GeneratedColumn<double> kg = GeneratedColumn<double>(
    'kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buyerMeta = const VerificationMeta('buyer');
  @override
  late final GeneratedColumn<String> buyer = GeneratedColumn<String>(
    'buyer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    fruitTypeId,
    kg,
    amount,
    buyer,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('fruit_type_id')) {
      context.handle(
        _fruitTypeIdMeta,
        fruitTypeId.isAcceptableOrUnknown(
          data['fruit_type_id']!,
          _fruitTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('kg')) {
      context.handle(_kgMeta, kg.isAcceptableOrUnknown(data['kg']!, _kgMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('buyer')) {
      context.handle(
        _buyerMeta,
        buyer.isAcceptableOrUnknown(data['buyer']!, _buyerMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      fruitTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fruit_type_id'],
      ),
      kg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kg'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      buyer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buyer'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final DateTime date;
  final int? fruitTypeId;
  final double? kg;

  /// Total received, in so'm.
  final int amount;
  final String? buyer;
  final String? note;
  const Sale({
    required this.id,
    required this.date,
    this.fruitTypeId,
    this.kg,
    required this.amount,
    this.buyer,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || fruitTypeId != null) {
      map['fruit_type_id'] = Variable<int>(fruitTypeId);
    }
    if (!nullToAbsent || kg != null) {
      map['kg'] = Variable<double>(kg);
    }
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || buyer != null) {
      map['buyer'] = Variable<String>(buyer);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      date: Value(date),
      fruitTypeId: fruitTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(fruitTypeId),
      kg: kg == null && nullToAbsent ? const Value.absent() : Value(kg),
      amount: Value(amount),
      buyer: buyer == null && nullToAbsent
          ? const Value.absent()
          : Value(buyer),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      fruitTypeId: serializer.fromJson<int?>(json['fruitTypeId']),
      kg: serializer.fromJson<double?>(json['kg']),
      amount: serializer.fromJson<int>(json['amount']),
      buyer: serializer.fromJson<String?>(json['buyer']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'fruitTypeId': serializer.toJson<int?>(fruitTypeId),
      'kg': serializer.toJson<double?>(kg),
      'amount': serializer.toJson<int>(amount),
      'buyer': serializer.toJson<String?>(buyer),
      'note': serializer.toJson<String?>(note),
    };
  }

  Sale copyWith({
    int? id,
    DateTime? date,
    Value<int?> fruitTypeId = const Value.absent(),
    Value<double?> kg = const Value.absent(),
    int? amount,
    Value<String?> buyer = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => Sale(
    id: id ?? this.id,
    date: date ?? this.date,
    fruitTypeId: fruitTypeId.present ? fruitTypeId.value : this.fruitTypeId,
    kg: kg.present ? kg.value : this.kg,
    amount: amount ?? this.amount,
    buyer: buyer.present ? buyer.value : this.buyer,
    note: note.present ? note.value : this.note,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      fruitTypeId: data.fruitTypeId.present
          ? data.fruitTypeId.value
          : this.fruitTypeId,
      kg: data.kg.present ? data.kg.value : this.kg,
      amount: data.amount.present ? data.amount.value : this.amount,
      buyer: data.buyer.present ? data.buyer.value : this.buyer,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('fruitTypeId: $fruitTypeId, ')
          ..write('kg: $kg, ')
          ..write('amount: $amount, ')
          ..write('buyer: $buyer, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, fruitTypeId, kg, amount, buyer, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.date == this.date &&
          other.fruitTypeId == this.fruitTypeId &&
          other.kg == this.kg &&
          other.amount == this.amount &&
          other.buyer == this.buyer &&
          other.note == this.note);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int?> fruitTypeId;
  final Value<double?> kg;
  final Value<int> amount;
  final Value<String?> buyer;
  final Value<String?> note;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.fruitTypeId = const Value.absent(),
    this.kg = const Value.absent(),
    this.amount = const Value.absent(),
    this.buyer = const Value.absent(),
    this.note = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.fruitTypeId = const Value.absent(),
    this.kg = const Value.absent(),
    required int amount,
    this.buyer = const Value.absent(),
    this.note = const Value.absent(),
  }) : date = Value(date),
       amount = Value(amount);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? fruitTypeId,
    Expression<double>? kg,
    Expression<int>? amount,
    Expression<String>? buyer,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (fruitTypeId != null) 'fruit_type_id': fruitTypeId,
      if (kg != null) 'kg': kg,
      if (amount != null) 'amount': amount,
      if (buyer != null) 'buyer': buyer,
      if (note != null) 'note': note,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int?>? fruitTypeId,
    Value<double?>? kg,
    Value<int>? amount,
    Value<String?>? buyer,
    Value<String?>? note,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      fruitTypeId: fruitTypeId ?? this.fruitTypeId,
      kg: kg ?? this.kg,
      amount: amount ?? this.amount,
      buyer: buyer ?? this.buyer,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (fruitTypeId.present) {
      map['fruit_type_id'] = Variable<int>(fruitTypeId.value);
    }
    if (kg.present) {
      map['kg'] = Variable<double>(kg.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (buyer.present) {
      map['buyer'] = Variable<String>(buyer.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('fruitTypeId: $fruitTypeId, ')
          ..write('kg: $kg, ')
          ..write('amount: $amount, ')
          ..write('buyer: $buyer, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, int> category =
      GeneratedColumn<int>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ExpenseCategory>($ExpensesTable.$convertercategory);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, category, amount, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: $ExpensesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}category'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExpenseCategory, int, int> $convertercategory =
      const EnumIndexConverter<ExpenseCategory>(ExpenseCategory.values);
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final DateTime date;
  final ExpenseCategory category;

  /// Amount spent, in so'm.
  final int amount;
  final String? note;
  const Expense({
    required this.id,
    required this.date,
    required this.category,
    required this.amount,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    {
      map['category'] = Variable<int>(
        $ExpensesTable.$convertercategory.toSql(category),
      );
    }
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: $ExpensesTable.$convertercategory.fromJson(
        serializer.fromJson<int>(json['category']),
      ),
      amount: serializer.fromJson<int>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<int>(
        $ExpensesTable.$convertercategory.toJson(category),
      ),
      'amount': serializer.toJson<int>(amount),
      'note': serializer.toJson<String?>(note),
    };
  }

  Expense copyWith({
    int? id,
    DateTime? date,
    ExpenseCategory? category,
    int? amount,
    Value<String?> note = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    date: date ?? this.date,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    note: note.present ? note.value : this.note,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, category, amount, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.note == this.note);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<ExpenseCategory> category;
  final Value<int> amount;
  final Value<String?> note;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required ExpenseCategory category,
    required int amount,
    this.note = const Value.absent(),
  }) : date = Value(date),
       category = Value(category),
       amount = Value(amount);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? category,
    Expression<int>? amount,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<ExpenseCategory>? category,
    Value<int>? amount,
    Value<String?>? note,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
        $ExpensesTable.$convertercategory.toSql(category.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $DiagnosesTable extends Diagnoses
    with TableInfo<$DiagnosesTable, DiagnosisRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiagnosesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<int> treeId = GeneratedColumn<int>(
    'tree_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _photoFileNameMeta = const VerificationMeta(
    'photoFileName',
  );
  @override
  late final GeneratedColumn<String> photoFileName = GeneratedColumn<String>(
    'photo_file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _healthyMeta = const VerificationMeta(
    'healthy',
  );
  @override
  late final GeneratedColumn<bool> healthy = GeneratedColumn<bool>(
    'healthy',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("healthy" IN (0, 1))',
    ),
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultJsonMeta = const VerificationMeta(
    'resultJson',
  );
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
    'result_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treeId,
    photoFileName,
    question,
    healthy,
    summary,
    resultJson,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diagnoses';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiagnosisRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('photo_file_name')) {
      context.handle(
        _photoFileNameMeta,
        photoFileName.isAcceptableOrUnknown(
          data['photo_file_name']!,
          _photoFileNameMeta,
        ),
      );
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    }
    if (data.containsKey('healthy')) {
      context.handle(
        _healthyMeta,
        healthy.isAcceptableOrUnknown(data['healthy']!, _healthyMeta),
      );
    } else if (isInserting) {
      context.missing(_healthyMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('result_json')) {
      context.handle(
        _resultJsonMeta,
        resultJson.isAcceptableOrUnknown(data['result_json']!, _resultJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_resultJsonMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiagnosisRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiagnosisRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tree_id'],
      )!,
      photoFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_file_name'],
      ),
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      ),
      healthy: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}healthy'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      resultJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_json'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $DiagnosesTable createAlias(String alias) {
    return $DiagnosesTable(attachedDatabase, alias);
  }
}

class DiagnosisRecord extends DataClass implements Insertable<DiagnosisRecord> {
  final int id;
  final int treeId;

  /// The photo that was checked (also kept in [TreePhotos]).
  final String? photoFileName;

  /// What the user asked, e.g. "leaves turn yellow".
  final String? question;
  final bool healthy;

  /// Short one-line result, for lists and the timeline.
  final String summary;

  /// The full API answer as JSON (problems, actions, tips...).
  final String resultJson;
  final DateTime date;
  const DiagnosisRecord({
    required this.id,
    required this.treeId,
    this.photoFileName,
    this.question,
    required this.healthy,
    required this.summary,
    required this.resultJson,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tree_id'] = Variable<int>(treeId);
    if (!nullToAbsent || photoFileName != null) {
      map['photo_file_name'] = Variable<String>(photoFileName);
    }
    if (!nullToAbsent || question != null) {
      map['question'] = Variable<String>(question);
    }
    map['healthy'] = Variable<bool>(healthy);
    map['summary'] = Variable<String>(summary);
    map['result_json'] = Variable<String>(resultJson);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  DiagnosesCompanion toCompanion(bool nullToAbsent) {
    return DiagnosesCompanion(
      id: Value(id),
      treeId: Value(treeId),
      photoFileName: photoFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(photoFileName),
      question: question == null && nullToAbsent
          ? const Value.absent()
          : Value(question),
      healthy: Value(healthy),
      summary: Value(summary),
      resultJson: Value(resultJson),
      date: Value(date),
    );
  }

  factory DiagnosisRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiagnosisRecord(
      id: serializer.fromJson<int>(json['id']),
      treeId: serializer.fromJson<int>(json['treeId']),
      photoFileName: serializer.fromJson<String?>(json['photoFileName']),
      question: serializer.fromJson<String?>(json['question']),
      healthy: serializer.fromJson<bool>(json['healthy']),
      summary: serializer.fromJson<String>(json['summary']),
      resultJson: serializer.fromJson<String>(json['resultJson']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'treeId': serializer.toJson<int>(treeId),
      'photoFileName': serializer.toJson<String?>(photoFileName),
      'question': serializer.toJson<String?>(question),
      'healthy': serializer.toJson<bool>(healthy),
      'summary': serializer.toJson<String>(summary),
      'resultJson': serializer.toJson<String>(resultJson),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  DiagnosisRecord copyWith({
    int? id,
    int? treeId,
    Value<String?> photoFileName = const Value.absent(),
    Value<String?> question = const Value.absent(),
    bool? healthy,
    String? summary,
    String? resultJson,
    DateTime? date,
  }) => DiagnosisRecord(
    id: id ?? this.id,
    treeId: treeId ?? this.treeId,
    photoFileName: photoFileName.present
        ? photoFileName.value
        : this.photoFileName,
    question: question.present ? question.value : this.question,
    healthy: healthy ?? this.healthy,
    summary: summary ?? this.summary,
    resultJson: resultJson ?? this.resultJson,
    date: date ?? this.date,
  );
  DiagnosisRecord copyWithCompanion(DiagnosesCompanion data) {
    return DiagnosisRecord(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      photoFileName: data.photoFileName.present
          ? data.photoFileName.value
          : this.photoFileName,
      question: data.question.present ? data.question.value : this.question,
      healthy: data.healthy.present ? data.healthy.value : this.healthy,
      summary: data.summary.present ? data.summary.value : this.summary,
      resultJson: data.resultJson.present
          ? data.resultJson.value
          : this.resultJson,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosisRecord(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('photoFileName: $photoFileName, ')
          ..write('question: $question, ')
          ..write('healthy: $healthy, ')
          ..write('summary: $summary, ')
          ..write('resultJson: $resultJson, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    treeId,
    photoFileName,
    question,
    healthy,
    summary,
    resultJson,
    date,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiagnosisRecord &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.photoFileName == this.photoFileName &&
          other.question == this.question &&
          other.healthy == this.healthy &&
          other.summary == this.summary &&
          other.resultJson == this.resultJson &&
          other.date == this.date);
}

class DiagnosesCompanion extends UpdateCompanion<DiagnosisRecord> {
  final Value<int> id;
  final Value<int> treeId;
  final Value<String?> photoFileName;
  final Value<String?> question;
  final Value<bool> healthy;
  final Value<String> summary;
  final Value<String> resultJson;
  final Value<DateTime> date;
  const DiagnosesCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.photoFileName = const Value.absent(),
    this.question = const Value.absent(),
    this.healthy = const Value.absent(),
    this.summary = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.date = const Value.absent(),
  });
  DiagnosesCompanion.insert({
    this.id = const Value.absent(),
    required int treeId,
    this.photoFileName = const Value.absent(),
    this.question = const Value.absent(),
    required bool healthy,
    required String summary,
    required String resultJson,
    required DateTime date,
  }) : treeId = Value(treeId),
       healthy = Value(healthy),
       summary = Value(summary),
       resultJson = Value(resultJson),
       date = Value(date);
  static Insertable<DiagnosisRecord> custom({
    Expression<int>? id,
    Expression<int>? treeId,
    Expression<String>? photoFileName,
    Expression<String>? question,
    Expression<bool>? healthy,
    Expression<String>? summary,
    Expression<String>? resultJson,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (photoFileName != null) 'photo_file_name': photoFileName,
      if (question != null) 'question': question,
      if (healthy != null) 'healthy': healthy,
      if (summary != null) 'summary': summary,
      if (resultJson != null) 'result_json': resultJson,
      if (date != null) 'date': date,
    });
  }

  DiagnosesCompanion copyWith({
    Value<int>? id,
    Value<int>? treeId,
    Value<String?>? photoFileName,
    Value<String?>? question,
    Value<bool>? healthy,
    Value<String>? summary,
    Value<String>? resultJson,
    Value<DateTime>? date,
  }) {
    return DiagnosesCompanion(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      photoFileName: photoFileName ?? this.photoFileName,
      question: question ?? this.question,
      healthy: healthy ?? this.healthy,
      summary: summary ?? this.summary,
      resultJson: resultJson ?? this.resultJson,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<int>(treeId.value);
    }
    if (photoFileName.present) {
      map['photo_file_name'] = Variable<String>(photoFileName.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (healthy.present) {
      map['healthy'] = Variable<bool>(healthy.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosesCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('photoFileName: $photoFileName, ')
          ..write('question: $question, ')
          ..write('healthy: $healthy, ')
          ..write('summary: $summary, ')
          ..write('resultJson: $resultJson, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FruitTypesTable fruitTypes = $FruitTypesTable(this);
  late final $PlotsTable plots = $PlotsTable(this);
  late final $TreesTable trees = $TreesTable(this);
  late final $TreePhotosTable treePhotos = $TreePhotosTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $HarvestsTable harvests = $HarvestsTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $DiagnosesTable diagnoses = $DiagnosesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    fruitTypes,
    plots,
    trees,
    treePhotos,
    journalEntries,
    harvests,
    sales,
    expenses,
    diagnoses,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tree_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('harvests', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('diagnoses', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$FruitTypesTableCreateCompanionBuilder =
    FruitTypesCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameRu,
      Value<String> emoji,
      Value<int> monthsToFruit,
    });
typedef $$FruitTypesTableUpdateCompanionBuilder =
    FruitTypesCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameRu,
      Value<String> emoji,
      Value<int> monthsToFruit,
    });

final class $$FruitTypesTableReferences
    extends BaseReferences<_$AppDatabase, $FruitTypesTable, FruitType> {
  $$FruitTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TreesTable, List<Tree>> _treesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trees,
    aliasName: 'fruit_types__id__trees__fruit_type_id',
  );

  $$TreesTableProcessedTableManager get treesRefs {
    final manager = $$TreesTableTableManager(
      $_db,
      $_db.trees,
    ).filter((f) => f.fruitTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_treesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HarvestsTable, List<Harvest>> _harvestsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.harvests,
    aliasName: 'fruit_types__id__harvests__fruit_type_id',
  );

  $$HarvestsTableProcessedTableManager get harvestsRefs {
    final manager = $$HarvestsTableTableManager(
      $_db,
      $_db.harvests,
    ).filter((f) => f.fruitTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_harvestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SalesTable, List<Sale>> _salesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sales,
    aliasName: 'fruit_types__id__sales__fruit_type_id',
  );

  $$SalesTableProcessedTableManager get salesRefs {
    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.fruitTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FruitTypesTableFilterComposer
    extends Composer<_$AppDatabase, $FruitTypesTable> {
  $$FruitTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameRu => $composableBuilder(
    column: $table.nameRu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthsToFruit => $composableBuilder(
    column: $table.monthsToFruit,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> treesRefs(
    Expression<bool> Function($$TreesTableFilterComposer f) f,
  ) {
    final $$TreesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.fruitTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableFilterComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> harvestsRefs(
    Expression<bool> Function($$HarvestsTableFilterComposer f) f,
  ) {
    final $$HarvestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.harvests,
      getReferencedColumn: (t) => t.fruitTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestsTableFilterComposer(
            $db: $db,
            $table: $db.harvests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesRefs(
    Expression<bool> Function($$SalesTableFilterComposer f) f,
  ) {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.fruitTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FruitTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $FruitTypesTable> {
  $$FruitTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameRu => $composableBuilder(
    column: $table.nameRu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthsToFruit => $composableBuilder(
    column: $table.monthsToFruit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FruitTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FruitTypesTable> {
  $$FruitTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameRu =>
      $composableBuilder(column: $table.nameRu, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<int> get monthsToFruit => $composableBuilder(
    column: $table.monthsToFruit,
    builder: (column) => column,
  );

  Expression<T> treesRefs<T extends Object>(
    Expression<T> Function($$TreesTableAnnotationComposer a) f,
  ) {
    final $$TreesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.fruitTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableAnnotationComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> harvestsRefs<T extends Object>(
    Expression<T> Function($$HarvestsTableAnnotationComposer a) f,
  ) {
    final $$HarvestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.harvests,
      getReferencedColumn: (t) => t.fruitTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestsTableAnnotationComposer(
            $db: $db,
            $table: $db.harvests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesRefs<T extends Object>(
    Expression<T> Function($$SalesTableAnnotationComposer a) f,
  ) {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.fruitTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FruitTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FruitTypesTable,
          FruitType,
          $$FruitTypesTableFilterComposer,
          $$FruitTypesTableOrderingComposer,
          $$FruitTypesTableAnnotationComposer,
          $$FruitTypesTableCreateCompanionBuilder,
          $$FruitTypesTableUpdateCompanionBuilder,
          (FruitType, $$FruitTypesTableReferences),
          FruitType,
          PrefetchHooks Function({
            bool treesRefs,
            bool harvestsRefs,
            bool salesRefs,
          })
        > {
  $$FruitTypesTableTableManager(_$AppDatabase db, $FruitTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FruitTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FruitTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FruitTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameRu = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                Value<int> monthsToFruit = const Value.absent(),
              }) => FruitTypesCompanion(
                id: id,
                nameEn: nameEn,
                nameRu: nameRu,
                emoji: emoji,
                monthsToFruit: monthsToFruit,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameRu,
                Value<String> emoji = const Value.absent(),
                Value<int> monthsToFruit = const Value.absent(),
              }) => FruitTypesCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameRu: nameRu,
                emoji: emoji,
                monthsToFruit: monthsToFruit,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FruitTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({treesRefs = false, harvestsRefs = false, salesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (treesRefs) db.trees,
                    if (harvestsRefs) db.harvests,
                    if (salesRefs) db.sales,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (treesRefs)
                        await $_getPrefetchedData<
                          FruitType,
                          $FruitTypesTable,
                          Tree
                        >(
                          currentTable: table,
                          referencedTable: $$FruitTypesTableReferences
                              ._treesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FruitTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).treesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fruitTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (harvestsRefs)
                        await $_getPrefetchedData<
                          FruitType,
                          $FruitTypesTable,
                          Harvest
                        >(
                          currentTable: table,
                          referencedTable: $$FruitTypesTableReferences
                              ._harvestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FruitTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).harvestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fruitTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesRefs)
                        await $_getPrefetchedData<
                          FruitType,
                          $FruitTypesTable,
                          Sale
                        >(
                          currentTable: table,
                          referencedTable: $$FruitTypesTableReferences
                              ._salesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FruitTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).salesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fruitTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FruitTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FruitTypesTable,
      FruitType,
      $$FruitTypesTableFilterComposer,
      $$FruitTypesTableOrderingComposer,
      $$FruitTypesTableAnnotationComposer,
      $$FruitTypesTableCreateCompanionBuilder,
      $$FruitTypesTableUpdateCompanionBuilder,
      (FruitType, $$FruitTypesTableReferences),
      FruitType,
      PrefetchHooks Function({
        bool treesRefs,
        bool harvestsRefs,
        bool salesRefs,
      })
    >;
typedef $$PlotsTableCreateCompanionBuilder =
    PlotsCompanion Function({
      Value<int> id,
      required String name,
      required double widthM,
      required double lengthM,
    });
typedef $$PlotsTableUpdateCompanionBuilder =
    PlotsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> widthM,
      Value<double> lengthM,
    });

final class $$PlotsTableReferences
    extends BaseReferences<_$AppDatabase, $PlotsTable, Plot> {
  $$PlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TreesTable, List<Tree>> _treesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trees,
    aliasName: 'plots__id__trees__plot_id',
  );

  $$TreesTableProcessedTableManager get treesRefs {
    final manager = $$TreesTableTableManager(
      $_db,
      $_db.trees,
    ).filter((f) => f.plotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_treesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntry>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: 'plots__id__journal_entries__plot_id',
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.plotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlotsTableFilterComposer extends Composer<_$AppDatabase, $PlotsTable> {
  $$PlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get widthM => $composableBuilder(
    column: $table.widthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lengthM => $composableBuilder(
    column: $table.lengthM,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> treesRefs(
    Expression<bool> Function($$TreesTableFilterComposer f) f,
  ) {
    final $$TreesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.plotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableFilterComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.plotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlotsTable> {
  $$PlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get widthM => $composableBuilder(
    column: $table.widthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lengthM => $composableBuilder(
    column: $table.lengthM,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlotsTable> {
  $$PlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get widthM =>
      $composableBuilder(column: $table.widthM, builder: (column) => column);

  GeneratedColumn<double> get lengthM =>
      $composableBuilder(column: $table.lengthM, builder: (column) => column);

  Expression<T> treesRefs<T extends Object>(
    Expression<T> Function($$TreesTableAnnotationComposer a) f,
  ) {
    final $$TreesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.plotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableAnnotationComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.plotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlotsTable,
          Plot,
          $$PlotsTableFilterComposer,
          $$PlotsTableOrderingComposer,
          $$PlotsTableAnnotationComposer,
          $$PlotsTableCreateCompanionBuilder,
          $$PlotsTableUpdateCompanionBuilder,
          (Plot, $$PlotsTableReferences),
          Plot,
          PrefetchHooks Function({bool treesRefs, bool journalEntriesRefs})
        > {
  $$PlotsTableTableManager(_$AppDatabase db, $PlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> widthM = const Value.absent(),
                Value<double> lengthM = const Value.absent(),
              }) => PlotsCompanion(
                id: id,
                name: name,
                widthM: widthM,
                lengthM: lengthM,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double widthM,
                required double lengthM,
              }) => PlotsCompanion.insert(
                id: id,
                name: name,
                widthM: widthM,
                lengthM: lengthM,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlotsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({treesRefs = false, journalEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (treesRefs) db.trees,
                    if (journalEntriesRefs) db.journalEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (treesRefs)
                        await $_getPrefetchedData<Plot, $PlotsTable, Tree>(
                          currentTable: table,
                          referencedTable: $$PlotsTableReferences
                              ._treesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlotsTableReferences(db, table, p0).treesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.plotId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          Plot,
                          $PlotsTable,
                          JournalEntry
                        >(
                          currentTable: table,
                          referencedTable: $$PlotsTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlotsTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.plotId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlotsTable,
      Plot,
      $$PlotsTableFilterComposer,
      $$PlotsTableOrderingComposer,
      $$PlotsTableAnnotationComposer,
      $$PlotsTableCreateCompanionBuilder,
      $$PlotsTableUpdateCompanionBuilder,
      (Plot, $$PlotsTableReferences),
      Plot,
      PrefetchHooks Function({bool treesRefs, bool journalEntriesRefs})
    >;
typedef $$TreesTableCreateCompanionBuilder =
    TreesCompanion Function({
      Value<int> id,
      required int plotId,
      required int fruitTypeId,
      required double xM,
      required double yM,
      Value<String?> variety,
      Value<DateTime?> plantedOn,
      Value<TreeStage> stage,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$TreesTableUpdateCompanionBuilder =
    TreesCompanion Function({
      Value<int> id,
      Value<int> plotId,
      Value<int> fruitTypeId,
      Value<double> xM,
      Value<double> yM,
      Value<String?> variety,
      Value<DateTime?> plantedOn,
      Value<TreeStage> stage,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$TreesTableReferences
    extends BaseReferences<_$AppDatabase, $TreesTable, Tree> {
  $$TreesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlotsTable _plotIdTable(_$AppDatabase db) =>
      db.plots.createAlias('trees__plot_id__plots__id');

  $$PlotsTableProcessedTableManager get plotId {
    final $_column = $_itemColumn<int>('plot_id')!;

    final manager = $$PlotsTableTableManager(
      $_db,
      $_db.plots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FruitTypesTable _fruitTypeIdTable(_$AppDatabase db) =>
      db.fruitTypes.createAlias('trees__fruit_type_id__fruit_types__id');

  $$FruitTypesTableProcessedTableManager get fruitTypeId {
    final $_column = $_itemColumn<int>('fruit_type_id')!;

    final manager = $$FruitTypesTableTableManager(
      $_db,
      $_db.fruitTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fruitTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TreePhotosTable, List<TreePhoto>>
  _treePhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.treePhotos,
    aliasName: 'trees__id__tree_photos__tree_id',
  );

  $$TreePhotosTableProcessedTableManager get treePhotosRefs {
    final manager = $$TreePhotosTableTableManager(
      $_db,
      $_db.treePhotos,
    ).filter((f) => f.treeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_treePhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntry>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: 'trees__id__journal_entries__tree_id',
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.treeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HarvestsTable, List<Harvest>> _harvestsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.harvests,
    aliasName: 'trees__id__harvests__tree_id',
  );

  $$HarvestsTableProcessedTableManager get harvestsRefs {
    final manager = $$HarvestsTableTableManager(
      $_db,
      $_db.harvests,
    ).filter((f) => f.treeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_harvestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DiagnosesTable, List<DiagnosisRecord>>
  _diagnosesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.diagnoses,
    aliasName: 'trees__id__diagnoses__tree_id',
  );

  $$DiagnosesTableProcessedTableManager get diagnosesRefs {
    final manager = $$DiagnosesTableTableManager(
      $_db,
      $_db.diagnoses,
    ).filter((f) => f.treeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_diagnosesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TreesTableFilterComposer extends Composer<_$AppDatabase, $TreesTable> {
  $$TreesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get xM => $composableBuilder(
    column: $table.xM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yM => $composableBuilder(
    column: $table.yM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variety => $composableBuilder(
    column: $table.variety,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plantedOn => $composableBuilder(
    column: $table.plantedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TreeStage, TreeStage, int> get stage =>
      $composableBuilder(
        column: $table.stage,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlotsTableFilterComposer get plotId {
    final $$PlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plotId,
      referencedTable: $db.plots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlotsTableFilterComposer(
            $db: $db,
            $table: $db.plots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FruitTypesTableFilterComposer get fruitTypeId {
    final $$FruitTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableFilterComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> treePhotosRefs(
    Expression<bool> Function($$TreePhotosTableFilterComposer f) f,
  ) {
    final $$TreePhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.treePhotos,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreePhotosTableFilterComposer(
            $db: $db,
            $table: $db.treePhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> harvestsRefs(
    Expression<bool> Function($$HarvestsTableFilterComposer f) f,
  ) {
    final $$HarvestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.harvests,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestsTableFilterComposer(
            $db: $db,
            $table: $db.harvests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> diagnosesRefs(
    Expression<bool> Function($$DiagnosesTableFilterComposer f) f,
  ) {
    final $$DiagnosesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diagnoses,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiagnosesTableFilterComposer(
            $db: $db,
            $table: $db.diagnoses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TreesTableOrderingComposer
    extends Composer<_$AppDatabase, $TreesTable> {
  $$TreesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get xM => $composableBuilder(
    column: $table.xM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yM => $composableBuilder(
    column: $table.yM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variety => $composableBuilder(
    column: $table.variety,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plantedOn => $composableBuilder(
    column: $table.plantedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlotsTableOrderingComposer get plotId {
    final $$PlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plotId,
      referencedTable: $db.plots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlotsTableOrderingComposer(
            $db: $db,
            $table: $db.plots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FruitTypesTableOrderingComposer get fruitTypeId {
    final $$FruitTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableOrderingComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreesTable> {
  $$TreesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get xM =>
      $composableBuilder(column: $table.xM, builder: (column) => column);

  GeneratedColumn<double> get yM =>
      $composableBuilder(column: $table.yM, builder: (column) => column);

  GeneratedColumn<String> get variety =>
      $composableBuilder(column: $table.variety, builder: (column) => column);

  GeneratedColumn<DateTime> get plantedOn =>
      $composableBuilder(column: $table.plantedOn, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TreeStage, int> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlotsTableAnnotationComposer get plotId {
    final $$PlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plotId,
      referencedTable: $db.plots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.plots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FruitTypesTableAnnotationComposer get fruitTypeId {
    final $$FruitTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> treePhotosRefs<T extends Object>(
    Expression<T> Function($$TreePhotosTableAnnotationComposer a) f,
  ) {
    final $$TreePhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.treePhotos,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreePhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.treePhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> harvestsRefs<T extends Object>(
    Expression<T> Function($$HarvestsTableAnnotationComposer a) f,
  ) {
    final $$HarvestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.harvests,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestsTableAnnotationComposer(
            $db: $db,
            $table: $db.harvests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> diagnosesRefs<T extends Object>(
    Expression<T> Function($$DiagnosesTableAnnotationComposer a) f,
  ) {
    final $$DiagnosesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diagnoses,
      getReferencedColumn: (t) => t.treeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiagnosesTableAnnotationComposer(
            $db: $db,
            $table: $db.diagnoses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TreesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TreesTable,
          Tree,
          $$TreesTableFilterComposer,
          $$TreesTableOrderingComposer,
          $$TreesTableAnnotationComposer,
          $$TreesTableCreateCompanionBuilder,
          $$TreesTableUpdateCompanionBuilder,
          (Tree, $$TreesTableReferences),
          Tree,
          PrefetchHooks Function({
            bool plotId,
            bool fruitTypeId,
            bool treePhotosRefs,
            bool journalEntriesRefs,
            bool harvestsRefs,
            bool diagnosesRefs,
          })
        > {
  $$TreesTableTableManager(_$AppDatabase db, $TreesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> plotId = const Value.absent(),
                Value<int> fruitTypeId = const Value.absent(),
                Value<double> xM = const Value.absent(),
                Value<double> yM = const Value.absent(),
                Value<String?> variety = const Value.absent(),
                Value<DateTime?> plantedOn = const Value.absent(),
                Value<TreeStage> stage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TreesCompanion(
                id: id,
                plotId: plotId,
                fruitTypeId: fruitTypeId,
                xM: xM,
                yM: yM,
                variety: variety,
                plantedOn: plantedOn,
                stage: stage,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int plotId,
                required int fruitTypeId,
                required double xM,
                required double yM,
                Value<String?> variety = const Value.absent(),
                Value<DateTime?> plantedOn = const Value.absent(),
                Value<TreeStage> stage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TreesCompanion.insert(
                id: id,
                plotId: plotId,
                fruitTypeId: fruitTypeId,
                xM: xM,
                yM: yM,
                variety: variety,
                plantedOn: plantedOn,
                stage: stage,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TreesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                plotId = false,
                fruitTypeId = false,
                treePhotosRefs = false,
                journalEntriesRefs = false,
                harvestsRefs = false,
                diagnosesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (treePhotosRefs) db.treePhotos,
                    if (journalEntriesRefs) db.journalEntries,
                    if (harvestsRefs) db.harvests,
                    if (diagnosesRefs) db.diagnoses,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (plotId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.plotId,
                                    referencedTable: $$TreesTableReferences
                                        ._plotIdTable(db),
                                    referencedColumn: $$TreesTableReferences
                                        ._plotIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (fruitTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fruitTypeId,
                                    referencedTable: $$TreesTableReferences
                                        ._fruitTypeIdTable(db),
                                    referencedColumn: $$TreesTableReferences
                                        ._fruitTypeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (treePhotosRefs)
                        await $_getPrefetchedData<Tree, $TreesTable, TreePhoto>(
                          currentTable: table,
                          referencedTable: $$TreesTableReferences
                              ._treePhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TreesTableReferences(
                                db,
                                table,
                                p0,
                              ).treePhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.treeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          Tree,
                          $TreesTable,
                          JournalEntry
                        >(
                          currentTable: table,
                          referencedTable: $$TreesTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TreesTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.treeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (harvestsRefs)
                        await $_getPrefetchedData<Tree, $TreesTable, Harvest>(
                          currentTable: table,
                          referencedTable: $$TreesTableReferences
                              ._harvestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TreesTableReferences(
                                db,
                                table,
                                p0,
                              ).harvestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.treeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (diagnosesRefs)
                        await $_getPrefetchedData<
                          Tree,
                          $TreesTable,
                          DiagnosisRecord
                        >(
                          currentTable: table,
                          referencedTable: $$TreesTableReferences
                              ._diagnosesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TreesTableReferences(
                                db,
                                table,
                                p0,
                              ).diagnosesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.treeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TreesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TreesTable,
      Tree,
      $$TreesTableFilterComposer,
      $$TreesTableOrderingComposer,
      $$TreesTableAnnotationComposer,
      $$TreesTableCreateCompanionBuilder,
      $$TreesTableUpdateCompanionBuilder,
      (Tree, $$TreesTableReferences),
      Tree,
      PrefetchHooks Function({
        bool plotId,
        bool fruitTypeId,
        bool treePhotosRefs,
        bool journalEntriesRefs,
        bool harvestsRefs,
        bool diagnosesRefs,
      })
    >;
typedef $$TreePhotosTableCreateCompanionBuilder =
    TreePhotosCompanion Function({
      Value<int> id,
      required int treeId,
      required String fileName,
      Value<DateTime> takenAt,
    });
typedef $$TreePhotosTableUpdateCompanionBuilder =
    TreePhotosCompanion Function({
      Value<int> id,
      Value<int> treeId,
      Value<String> fileName,
      Value<DateTime> takenAt,
    });

final class $$TreePhotosTableReferences
    extends BaseReferences<_$AppDatabase, $TreePhotosTable, TreePhoto> {
  $$TreePhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TreesTable _treeIdTable(_$AppDatabase db) =>
      db.trees.createAlias('tree_photos__tree_id__trees__id');

  $$TreesTableProcessedTableManager get treeId {
    final $_column = $_itemColumn<int>('tree_id')!;

    final manager = $$TreesTableTableManager(
      $_db,
      $_db.trees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_treeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TreePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $TreePhotosTable> {
  $$TreePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TreesTableFilterComposer get treeId {
    final $$TreesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableFilterComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $TreePhotosTable> {
  $$TreePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TreesTableOrderingComposer get treeId {
    final $$TreesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableOrderingComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreePhotosTable> {
  $$TreePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  $$TreesTableAnnotationComposer get treeId {
    final $$TreesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableAnnotationComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreePhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TreePhotosTable,
          TreePhoto,
          $$TreePhotosTableFilterComposer,
          $$TreePhotosTableOrderingComposer,
          $$TreePhotosTableAnnotationComposer,
          $$TreePhotosTableCreateCompanionBuilder,
          $$TreePhotosTableUpdateCompanionBuilder,
          (TreePhoto, $$TreePhotosTableReferences),
          TreePhoto,
          PrefetchHooks Function({bool treeId})
        > {
  $$TreePhotosTableTableManager(_$AppDatabase db, $TreePhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreePhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> treeId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
              }) => TreePhotosCompanion(
                id: id,
                treeId: treeId,
                fileName: fileName,
                takenAt: takenAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int treeId,
                required String fileName,
                Value<DateTime> takenAt = const Value.absent(),
              }) => TreePhotosCompanion.insert(
                id: id,
                treeId: treeId,
                fileName: fileName,
                takenAt: takenAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TreePhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({treeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (treeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.treeId,
                                referencedTable: $$TreePhotosTableReferences
                                    ._treeIdTable(db),
                                referencedColumn: $$TreePhotosTableReferences
                                    ._treeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TreePhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TreePhotosTable,
      TreePhoto,
      $$TreePhotosTableFilterComposer,
      $$TreePhotosTableOrderingComposer,
      $$TreePhotosTableAnnotationComposer,
      $$TreePhotosTableCreateCompanionBuilder,
      $$TreePhotosTableUpdateCompanionBuilder,
      (TreePhoto, $$TreePhotosTableReferences),
      TreePhoto,
      PrefetchHooks Function({bool treeId})
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      required int plotId,
      Value<int?> treeId,
      required JournalKind kind,
      Value<String?> note,
      required DateTime date,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<int> plotId,
      Value<int?> treeId,
      Value<JournalKind> kind,
      Value<String?> note,
      Value<DateTime> date,
    });

final class $$JournalEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlotsTable _plotIdTable(_$AppDatabase db) =>
      db.plots.createAlias('journal_entries__plot_id__plots__id');

  $$PlotsTableProcessedTableManager get plotId {
    final $_column = $_itemColumn<int>('plot_id')!;

    final manager = $$PlotsTableTableManager(
      $_db,
      $_db.plots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TreesTable _treeIdTable(_$AppDatabase db) =>
      db.trees.createAlias('journal_entries__tree_id__trees__id');

  $$TreesTableProcessedTableManager? get treeId {
    final $_column = $_itemColumn<int>('tree_id');
    if ($_column == null) return null;
    final manager = $$TreesTableTableManager(
      $_db,
      $_db.trees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_treeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<JournalKind, JournalKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$PlotsTableFilterComposer get plotId {
    final $$PlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plotId,
      referencedTable: $db.plots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlotsTableFilterComposer(
            $db: $db,
            $table: $db.plots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TreesTableFilterComposer get treeId {
    final $$TreesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableFilterComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlotsTableOrderingComposer get plotId {
    final $$PlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plotId,
      referencedTable: $db.plots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlotsTableOrderingComposer(
            $db: $db,
            $table: $db.plots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TreesTableOrderingComposer get treeId {
    final $$TreesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableOrderingComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JournalKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$PlotsTableAnnotationComposer get plotId {
    final $$PlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plotId,
      referencedTable: $db.plots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.plots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TreesTableAnnotationComposer get treeId {
    final $$TreesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableAnnotationComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalEntry, $$JournalEntriesTableReferences),
          JournalEntry,
          PrefetchHooks Function({bool plotId, bool treeId})
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> plotId = const Value.absent(),
                Value<int?> treeId = const Value.absent(),
                Value<JournalKind> kind = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                plotId: plotId,
                treeId: treeId,
                kind: kind,
                note: note,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int plotId,
                Value<int?> treeId = const Value.absent(),
                required JournalKind kind,
                Value<String?> note = const Value.absent(),
                required DateTime date,
              }) => JournalEntriesCompanion.insert(
                id: id,
                plotId: plotId,
                treeId: treeId,
                kind: kind,
                note: note,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({plotId = false, treeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (plotId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.plotId,
                                referencedTable: $$JournalEntriesTableReferences
                                    ._plotIdTable(db),
                                referencedColumn:
                                    $$JournalEntriesTableReferences
                                        ._plotIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (treeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.treeId,
                                referencedTable: $$JournalEntriesTableReferences
                                    ._treeIdTable(db),
                                referencedColumn:
                                    $$JournalEntriesTableReferences
                                        ._treeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalEntry, $$JournalEntriesTableReferences),
      JournalEntry,
      PrefetchHooks Function({bool plotId, bool treeId})
    >;
typedef $$HarvestsTableCreateCompanionBuilder =
    HarvestsCompanion Function({
      Value<int> id,
      required DateTime date,
      required int fruitTypeId,
      Value<int?> treeId,
      required double kg,
      Value<String?> note,
    });
typedef $$HarvestsTableUpdateCompanionBuilder =
    HarvestsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> fruitTypeId,
      Value<int?> treeId,
      Value<double> kg,
      Value<String?> note,
    });

final class $$HarvestsTableReferences
    extends BaseReferences<_$AppDatabase, $HarvestsTable, Harvest> {
  $$HarvestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FruitTypesTable _fruitTypeIdTable(_$AppDatabase db) =>
      db.fruitTypes.createAlias('harvests__fruit_type_id__fruit_types__id');

  $$FruitTypesTableProcessedTableManager get fruitTypeId {
    final $_column = $_itemColumn<int>('fruit_type_id')!;

    final manager = $$FruitTypesTableTableManager(
      $_db,
      $_db.fruitTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fruitTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TreesTable _treeIdTable(_$AppDatabase db) =>
      db.trees.createAlias('harvests__tree_id__trees__id');

  $$TreesTableProcessedTableManager? get treeId {
    final $_column = $_itemColumn<int>('tree_id');
    if ($_column == null) return null;
    final manager = $$TreesTableTableManager(
      $_db,
      $_db.trees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_treeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HarvestsTableFilterComposer
    extends Composer<_$AppDatabase, $HarvestsTable> {
  $$HarvestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$FruitTypesTableFilterComposer get fruitTypeId {
    final $$FruitTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableFilterComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TreesTableFilterComposer get treeId {
    final $$TreesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableFilterComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HarvestsTableOrderingComposer
    extends Composer<_$AppDatabase, $HarvestsTable> {
  $$HarvestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$FruitTypesTableOrderingComposer get fruitTypeId {
    final $$FruitTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableOrderingComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TreesTableOrderingComposer get treeId {
    final $$TreesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableOrderingComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HarvestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HarvestsTable> {
  $$HarvestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get kg =>
      $composableBuilder(column: $table.kg, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$FruitTypesTableAnnotationComposer get fruitTypeId {
    final $$FruitTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TreesTableAnnotationComposer get treeId {
    final $$TreesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableAnnotationComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HarvestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HarvestsTable,
          Harvest,
          $$HarvestsTableFilterComposer,
          $$HarvestsTableOrderingComposer,
          $$HarvestsTableAnnotationComposer,
          $$HarvestsTableCreateCompanionBuilder,
          $$HarvestsTableUpdateCompanionBuilder,
          (Harvest, $$HarvestsTableReferences),
          Harvest,
          PrefetchHooks Function({bool fruitTypeId, bool treeId})
        > {
  $$HarvestsTableTableManager(_$AppDatabase db, $HarvestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HarvestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HarvestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HarvestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> fruitTypeId = const Value.absent(),
                Value<int?> treeId = const Value.absent(),
                Value<double> kg = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => HarvestsCompanion(
                id: id,
                date: date,
                fruitTypeId: fruitTypeId,
                treeId: treeId,
                kg: kg,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int fruitTypeId,
                Value<int?> treeId = const Value.absent(),
                required double kg,
                Value<String?> note = const Value.absent(),
              }) => HarvestsCompanion.insert(
                id: id,
                date: date,
                fruitTypeId: fruitTypeId,
                treeId: treeId,
                kg: kg,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HarvestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fruitTypeId = false, treeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fruitTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fruitTypeId,
                                referencedTable: $$HarvestsTableReferences
                                    ._fruitTypeIdTable(db),
                                referencedColumn: $$HarvestsTableReferences
                                    ._fruitTypeIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (treeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.treeId,
                                referencedTable: $$HarvestsTableReferences
                                    ._treeIdTable(db),
                                referencedColumn: $$HarvestsTableReferences
                                    ._treeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HarvestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HarvestsTable,
      Harvest,
      $$HarvestsTableFilterComposer,
      $$HarvestsTableOrderingComposer,
      $$HarvestsTableAnnotationComposer,
      $$HarvestsTableCreateCompanionBuilder,
      $$HarvestsTableUpdateCompanionBuilder,
      (Harvest, $$HarvestsTableReferences),
      Harvest,
      PrefetchHooks Function({bool fruitTypeId, bool treeId})
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<int?> fruitTypeId,
      Value<double?> kg,
      required int amount,
      Value<String?> buyer,
      Value<String?> note,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int?> fruitTypeId,
      Value<double?> kg,
      Value<int> amount,
      Value<String?> buyer,
      Value<String?> note,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FruitTypesTable _fruitTypeIdTable(_$AppDatabase db) =>
      db.fruitTypes.createAlias('sales__fruit_type_id__fruit_types__id');

  $$FruitTypesTableProcessedTableManager? get fruitTypeId {
    final $_column = $_itemColumn<int>('fruit_type_id');
    if ($_column == null) return null;
    final manager = $$FruitTypesTableTableManager(
      $_db,
      $_db.fruitTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fruitTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyer => $composableBuilder(
    column: $table.buyer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$FruitTypesTableFilterComposer get fruitTypeId {
    final $$FruitTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableFilterComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyer => $composableBuilder(
    column: $table.buyer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$FruitTypesTableOrderingComposer get fruitTypeId {
    final $$FruitTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableOrderingComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get kg =>
      $composableBuilder(column: $table.kg, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get buyer =>
      $composableBuilder(column: $table.buyer, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$FruitTypesTableAnnotationComposer get fruitTypeId {
    final $$FruitTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fruitTypeId,
      referencedTable: $db.fruitTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FruitTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.fruitTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool fruitTypeId})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int?> fruitTypeId = const Value.absent(),
                Value<double?> kg = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> buyer = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                date: date,
                fruitTypeId: fruitTypeId,
                kg: kg,
                amount: amount,
                buyer: buyer,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<int?> fruitTypeId = const Value.absent(),
                Value<double?> kg = const Value.absent(),
                required int amount,
                Value<String?> buyer = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                date: date,
                fruitTypeId: fruitTypeId,
                kg: kg,
                amount: amount,
                buyer: buyer,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SalesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({fruitTypeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fruitTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fruitTypeId,
                                referencedTable: $$SalesTableReferences
                                    ._fruitTypeIdTable(db),
                                referencedColumn: $$SalesTableReferences
                                    ._fruitTypeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool fruitTypeId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required DateTime date,
      required ExpenseCategory category,
      required int amount,
      Value<String?> note,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<ExpenseCategory> category,
      Value<int> amount,
      Value<String?> note,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, int>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseCategory, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<ExpenseCategory> category = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                date: date,
                category: category,
                amount: amount,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required ExpenseCategory category,
                required int amount,
                Value<String?> note = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                date: date,
                category: category,
                amount: amount,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$DiagnosesTableCreateCompanionBuilder =
    DiagnosesCompanion Function({
      Value<int> id,
      required int treeId,
      Value<String?> photoFileName,
      Value<String?> question,
      required bool healthy,
      required String summary,
      required String resultJson,
      required DateTime date,
    });
typedef $$DiagnosesTableUpdateCompanionBuilder =
    DiagnosesCompanion Function({
      Value<int> id,
      Value<int> treeId,
      Value<String?> photoFileName,
      Value<String?> question,
      Value<bool> healthy,
      Value<String> summary,
      Value<String> resultJson,
      Value<DateTime> date,
    });

final class $$DiagnosesTableReferences
    extends BaseReferences<_$AppDatabase, $DiagnosesTable, DiagnosisRecord> {
  $$DiagnosesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TreesTable _treeIdTable(_$AppDatabase db) =>
      db.trees.createAlias('diagnoses__tree_id__trees__id');

  $$TreesTableProcessedTableManager get treeId {
    final $_column = $_itemColumn<int>('tree_id')!;

    final manager = $$TreesTableTableManager(
      $_db,
      $_db.trees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_treeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DiagnosesTableFilterComposer
    extends Composer<_$AppDatabase, $DiagnosesTable> {
  $$DiagnosesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoFileName => $composableBuilder(
    column: $table.photoFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get healthy => $composableBuilder(
    column: $table.healthy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$TreesTableFilterComposer get treeId {
    final $$TreesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableFilterComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiagnosesTableOrderingComposer
    extends Composer<_$AppDatabase, $DiagnosesTable> {
  $$DiagnosesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoFileName => $composableBuilder(
    column: $table.photoFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get healthy => $composableBuilder(
    column: $table.healthy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$TreesTableOrderingComposer get treeId {
    final $$TreesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableOrderingComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiagnosesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiagnosesTable> {
  $$DiagnosesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get photoFileName => $composableBuilder(
    column: $table.photoFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<bool> get healthy =>
      $composableBuilder(column: $table.healthy, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$TreesTableAnnotationComposer get treeId {
    final $$TreesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.treeId,
      referencedTable: $db.trees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreesTableAnnotationComposer(
            $db: $db,
            $table: $db.trees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiagnosesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiagnosesTable,
          DiagnosisRecord,
          $$DiagnosesTableFilterComposer,
          $$DiagnosesTableOrderingComposer,
          $$DiagnosesTableAnnotationComposer,
          $$DiagnosesTableCreateCompanionBuilder,
          $$DiagnosesTableUpdateCompanionBuilder,
          (DiagnosisRecord, $$DiagnosesTableReferences),
          DiagnosisRecord,
          PrefetchHooks Function({bool treeId})
        > {
  $$DiagnosesTableTableManager(_$AppDatabase db, $DiagnosesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiagnosesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiagnosesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiagnosesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> treeId = const Value.absent(),
                Value<String?> photoFileName = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<bool> healthy = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> resultJson = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => DiagnosesCompanion(
                id: id,
                treeId: treeId,
                photoFileName: photoFileName,
                question: question,
                healthy: healthy,
                summary: summary,
                resultJson: resultJson,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int treeId,
                Value<String?> photoFileName = const Value.absent(),
                Value<String?> question = const Value.absent(),
                required bool healthy,
                required String summary,
                required String resultJson,
                required DateTime date,
              }) => DiagnosesCompanion.insert(
                id: id,
                treeId: treeId,
                photoFileName: photoFileName,
                question: question,
                healthy: healthy,
                summary: summary,
                resultJson: resultJson,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DiagnosesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({treeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (treeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.treeId,
                                referencedTable: $$DiagnosesTableReferences
                                    ._treeIdTable(db),
                                referencedColumn: $$DiagnosesTableReferences
                                    ._treeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DiagnosesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiagnosesTable,
      DiagnosisRecord,
      $$DiagnosesTableFilterComposer,
      $$DiagnosesTableOrderingComposer,
      $$DiagnosesTableAnnotationComposer,
      $$DiagnosesTableCreateCompanionBuilder,
      $$DiagnosesTableUpdateCompanionBuilder,
      (DiagnosisRecord, $$DiagnosesTableReferences),
      DiagnosisRecord,
      PrefetchHooks Function({bool treeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FruitTypesTableTableManager get fruitTypes =>
      $$FruitTypesTableTableManager(_db, _db.fruitTypes);
  $$PlotsTableTableManager get plots =>
      $$PlotsTableTableManager(_db, _db.plots);
  $$TreesTableTableManager get trees =>
      $$TreesTableTableManager(_db, _db.trees);
  $$TreePhotosTableTableManager get treePhotos =>
      $$TreePhotosTableTableManager(_db, _db.treePhotos);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$HarvestsTableTableManager get harvests =>
      $$HarvestsTableTableManager(_db, _db.harvests);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$DiagnosesTableTableManager get diagnoses =>
      $$DiagnosesTableTableManager(_db, _db.diagnoses);
}

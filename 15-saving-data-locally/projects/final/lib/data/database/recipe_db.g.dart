// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_db.dart';

// ignore_for_file: type=lint
class $DbRecipeTable extends DbRecipe
    with TableInfo<$DbRecipeTable, DbRecipeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbRecipeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, label, image];
  @override
  String get aliasedName => _alias ?? 'db_recipe';
  @override
  String get actualTableName => 'db_recipe';
  @override
  VerificationContext validateIntegrity(Insertable<DbRecipeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbRecipeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbRecipeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
    );
  }

  @override
  $DbRecipeTable createAlias(String alias) {
    return $DbRecipeTable(attachedDatabase, alias);
  }
}

class DbRecipeData extends DataClass implements Insertable<DbRecipeData> {
  final int id;
  final String label;
  final String image;
  const DbRecipeData(
      {required this.id, required this.label, required this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['image'] = Variable<String>(image);
    return map;
  }

  DbRecipeCompanion toCompanion(bool nullToAbsent) {
    return DbRecipeCompanion(
      id: Value(id),
      label: Value(label),
      image: Value(image),
    );
  }

  factory DbRecipeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbRecipeData(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'image': serializer.toJson<String>(image),
    };
  }

  DbRecipeData copyWith({int? id, String? label, String? image}) =>
      DbRecipeData(
        id: id ?? this.id,
        label: label ?? this.label,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('DbRecipeData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbRecipeData &&
          other.id == this.id &&
          other.label == this.label &&
          other.image == this.image);
}

class DbRecipeCompanion extends UpdateCompanion<DbRecipeData> {
  final Value<int> id;
  final Value<String> label;
  final Value<String> image;
  const DbRecipeCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.image = const Value.absent(),
  });
  DbRecipeCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required String image,
  })  : label = Value(label),
        image = Value(image);
  static Insertable<DbRecipeData> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (image != null) 'image': image,
    });
  }

  DbRecipeCompanion copyWith(
      {Value<int>? id, Value<String>? label, Value<String>? image}) {
    return DbRecipeCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbRecipeCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $DbIngredientTable extends DbIngredient
    with TableInfo<$DbIngredientTable, DbIngredientData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbIngredientTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _recipeIdMeta =
      const VerificationMeta('recipeId');
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
      'recipe_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, recipeId, name, weight];
  @override
  String get aliasedName => _alias ?? 'db_ingredient';
  @override
  String get actualTableName => 'db_ingredient';
  @override
  VerificationContext validateIntegrity(Insertable<DbIngredientData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(_recipeIdMeta,
          recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta));
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbIngredientData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbIngredientData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      recipeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}recipe_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $DbIngredientTable createAlias(String alias) {
    return $DbIngredientTable(attachedDatabase, alias);
  }
}

class DbIngredientData extends DataClass
    implements Insertable<DbIngredientData> {
  final int id;
  final int recipeId;
  final String name;
  final double weight;
  const DbIngredientData(
      {required this.id,
      required this.recipeId,
      required this.name,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['name'] = Variable<String>(name);
    map['weight'] = Variable<double>(weight);
    return map;
  }

  DbIngredientCompanion toCompanion(bool nullToAbsent) {
    return DbIngredientCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      name: Value(name),
      weight: Value(weight),
    );
  }

  factory DbIngredientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbIngredientData(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      name: serializer.fromJson<String>(json['name']),
      weight: serializer.fromJson<double>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'name': serializer.toJson<String>(name),
      'weight': serializer.toJson<double>(weight),
    };
  }

  DbIngredientData copyWith(
          {int? id, int? recipeId, String? name, double? weight}) =>
      DbIngredientData(
        id: id ?? this.id,
        recipeId: recipeId ?? this.recipeId,
        name: name ?? this.name,
        weight: weight ?? this.weight,
      );
  @override
  String toString() {
    return (StringBuffer('DbIngredientData(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recipeId, name, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbIngredientData &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.name == this.name &&
          other.weight == this.weight);
}

class DbIngredientCompanion extends UpdateCompanion<DbIngredientData> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<String> name;
  final Value<double> weight;
  const DbIngredientCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.name = const Value.absent(),
    this.weight = const Value.absent(),
  });
  DbIngredientCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required String name,
    required double weight,
  })  : recipeId = Value(recipeId),
        name = Value(name),
        weight = Value(weight);
  static Insertable<DbIngredientData> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<String>? name,
    Expression<double>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (name != null) 'name': name,
      if (weight != null) 'weight': weight,
    });
  }

  DbIngredientCompanion copyWith(
      {Value<int>? id,
      Value<int>? recipeId,
      Value<String>? name,
      Value<double>? weight}) {
    return DbIngredientCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbIngredientCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

abstract class _$RecipeDatabase extends GeneratedDatabase {
  _$RecipeDatabase(QueryExecutor e) : super(e);
  late final $DbRecipeTable dbRecipe = $DbRecipeTable(this);
  late final $DbIngredientTable dbIngredient = $DbIngredientTable(this);
  late final RecipeDao recipeDao = RecipeDao(this as RecipeDatabase);
  late final IngredientDao ingredientDao =
      IngredientDao(this as RecipeDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dbRecipe, dbIngredient];
}

mixin _$RecipeDaoMixin on DatabaseAccessor<RecipeDatabase> {
  $DbRecipeTable get dbRecipe => attachedDatabase.dbRecipe;
}
mixin _$IngredientDaoMixin on DatabaseAccessor<RecipeDatabase> {
  $DbIngredientTable get dbIngredient => attachedDatabase.dbIngredient;
}

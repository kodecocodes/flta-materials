// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorRecipeData extends DataClass implements Insertable<MoorRecipeData> {
  final int id;
  final String label;
  final String image;
  final String url;
  final double calories;
  final double totalWeight;
  final double totalTime;
  MoorRecipeData(
      {@required this.id,
      @required this.label,
      @required this.image,
      @required this.url,
      @required this.calories,
      @required this.totalWeight,
      @required this.totalTime});
  factory MoorRecipeData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return MoorRecipeData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      label:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}label']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      calories: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}calories']),
      totalWeight: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_weight']),
      totalTime: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || calories != null) {
      map['calories'] = Variable<double>(calories);
    }
    if (!nullToAbsent || totalWeight != null) {
      map['total_weight'] = Variable<double>(totalWeight);
    }
    if (!nullToAbsent || totalTime != null) {
      map['total_time'] = Variable<double>(totalTime);
    }
    return map;
  }

  MoorRecipeCompanion toCompanion(bool nullToAbsent) {
    return MoorRecipeCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      calories: calories == null && nullToAbsent
          ? const Value.absent()
          : Value(calories),
      totalWeight: totalWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(totalWeight),
      totalTime: totalTime == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTime),
    );
  }

  factory MoorRecipeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorRecipeData(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      image: serializer.fromJson<String>(json['image']),
      url: serializer.fromJson<String>(json['url']),
      calories: serializer.fromJson<double>(json['calories']),
      totalWeight: serializer.fromJson<double>(json['totalWeight']),
      totalTime: serializer.fromJson<double>(json['totalTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'image': serializer.toJson<String>(image),
      'url': serializer.toJson<String>(url),
      'calories': serializer.toJson<double>(calories),
      'totalWeight': serializer.toJson<double>(totalWeight),
      'totalTime': serializer.toJson<double>(totalTime),
    };
  }

  MoorRecipeData copyWith(
          {int id,
          String label,
          String image,
          String url,
          double calories,
          double totalWeight,
          double totalTime}) =>
      MoorRecipeData(
        id: id ?? this.id,
        label: label ?? this.label,
        image: image ?? this.image,
        url: url ?? this.url,
        calories: calories ?? this.calories,
        totalWeight: totalWeight ?? this.totalWeight,
        totalTime: totalTime ?? this.totalTime,
      );
  @override
  String toString() {
    return (StringBuffer('MoorRecipeData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('image: $image, ')
          ..write('url: $url, ')
          ..write('calories: $calories, ')
          ..write('totalWeight: $totalWeight, ')
          ..write('totalTime: $totalTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          label.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  url.hashCode,
                  $mrjc(calories.hashCode,
                      $mrjc(totalWeight.hashCode, totalTime.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorRecipeData &&
          other.id == this.id &&
          other.label == this.label &&
          other.image == this.image &&
          other.url == this.url &&
          other.calories == this.calories &&
          other.totalWeight == this.totalWeight &&
          other.totalTime == this.totalTime);
}

class MoorRecipeCompanion extends UpdateCompanion<MoorRecipeData> {
  final Value<int> id;
  final Value<String> label;
  final Value<String> image;
  final Value<String> url;
  final Value<double> calories;
  final Value<double> totalWeight;
  final Value<double> totalTime;
  const MoorRecipeCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.image = const Value.absent(),
    this.url = const Value.absent(),
    this.calories = const Value.absent(),
    this.totalWeight = const Value.absent(),
    this.totalTime = const Value.absent(),
  });
  MoorRecipeCompanion.insert({
    this.id = const Value.absent(),
    @required String label,
    @required String image,
    @required String url,
    @required double calories,
    @required double totalWeight,
    @required double totalTime,
  })  : label = Value(label),
        image = Value(image),
        url = Value(url),
        calories = Value(calories),
        totalWeight = Value(totalWeight),
        totalTime = Value(totalTime);
  static Insertable<MoorRecipeData> custom({
    Expression<int> id,
    Expression<String> label,
    Expression<String> image,
    Expression<String> url,
    Expression<double> calories,
    Expression<double> totalWeight,
    Expression<double> totalTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (image != null) 'image': image,
      if (url != null) 'url': url,
      if (calories != null) 'calories': calories,
      if (totalWeight != null) 'total_weight': totalWeight,
      if (totalTime != null) 'total_time': totalTime,
    });
  }

  MoorRecipeCompanion copyWith(
      {Value<int> id,
      Value<String> label,
      Value<String> image,
      Value<String> url,
      Value<double> calories,
      Value<double> totalWeight,
      Value<double> totalTime}) {
    return MoorRecipeCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      image: image ?? this.image,
      url: url ?? this.url,
      calories: calories ?? this.calories,
      totalWeight: totalWeight ?? this.totalWeight,
      totalTime: totalTime ?? this.totalTime,
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
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (totalWeight.present) {
      map['total_weight'] = Variable<double>(totalWeight.value);
    }
    if (totalTime.present) {
      map['total_time'] = Variable<double>(totalTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoorRecipeCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('image: $image, ')
          ..write('url: $url, ')
          ..write('calories: $calories, ')
          ..write('totalWeight: $totalWeight, ')
          ..write('totalTime: $totalTime')
          ..write(')'))
        .toString();
  }
}

class $MoorRecipeTable extends MoorRecipe
    with TableInfo<$MoorRecipeTable, MoorRecipeData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MoorRecipeTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _labelMeta = const VerificationMeta('label');
  GeneratedTextColumn _label;
  @override
  GeneratedTextColumn get label => _label ??= _constructLabel();
  GeneratedTextColumn _constructLabel() {
    return GeneratedTextColumn(
      'label',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _caloriesMeta = const VerificationMeta('calories');
  GeneratedRealColumn _calories;
  @override
  GeneratedRealColumn get calories => _calories ??= _constructCalories();
  GeneratedRealColumn _constructCalories() {
    return GeneratedRealColumn(
      'calories',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalWeightMeta =
      const VerificationMeta('totalWeight');
  GeneratedRealColumn _totalWeight;
  @override
  GeneratedRealColumn get totalWeight =>
      _totalWeight ??= _constructTotalWeight();
  GeneratedRealColumn _constructTotalWeight() {
    return GeneratedRealColumn(
      'total_weight',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalTimeMeta = const VerificationMeta('totalTime');
  GeneratedRealColumn _totalTime;
  @override
  GeneratedRealColumn get totalTime => _totalTime ??= _constructTotalTime();
  GeneratedRealColumn _constructTotalTime() {
    return GeneratedRealColumn(
      'total_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, label, image, url, calories, totalWeight, totalTime];
  @override
  $MoorRecipeTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'moor_recipe';
  @override
  final String actualTableName = 'moor_recipe';
  @override
  VerificationContext validateIntegrity(Insertable<MoorRecipeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label'], _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url'], _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories'], _caloriesMeta));
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('total_weight')) {
      context.handle(
          _totalWeightMeta,
          totalWeight.isAcceptableOrUnknown(
              data['total_weight'], _totalWeightMeta));
    } else if (isInserting) {
      context.missing(_totalWeightMeta);
    }
    if (data.containsKey('total_time')) {
      context.handle(_totalTimeMeta,
          totalTime.isAcceptableOrUnknown(data['total_time'], _totalTimeMeta));
    } else if (isInserting) {
      context.missing(_totalTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorRecipeData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorRecipeData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MoorRecipeTable createAlias(String alias) {
    return $MoorRecipeTable(_db, alias);
  }
}

class MoorIngredientData extends DataClass
    implements Insertable<MoorIngredientData> {
  final int id;
  final int recipeId;
  final String name;
  final double weight;
  MoorIngredientData(
      {@required this.id,
      @required this.recipeId,
      @required this.name,
      @required this.weight});
  factory MoorIngredientData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return MoorIngredientData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      recipeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}recipe_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      weight:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}weight']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<int>(recipeId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    return map;
  }

  MoorIngredientCompanion toCompanion(bool nullToAbsent) {
    return MoorIngredientCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
    );
  }

  factory MoorIngredientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorIngredientData(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      name: serializer.fromJson<String>(json['name']),
      weight: serializer.fromJson<double>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'name': serializer.toJson<String>(name),
      'weight': serializer.toJson<double>(weight),
    };
  }

  MoorIngredientData copyWith(
          {int id, int recipeId, String name, double weight}) =>
      MoorIngredientData(
        id: id ?? this.id,
        recipeId: recipeId ?? this.recipeId,
        name: name ?? this.name,
        weight: weight ?? this.weight,
      );
  @override
  String toString() {
    return (StringBuffer('MoorIngredientData(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(recipeId.hashCode, $mrjc(name.hashCode, weight.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorIngredientData &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.name == this.name &&
          other.weight == this.weight);
}

class MoorIngredientCompanion extends UpdateCompanion<MoorIngredientData> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<String> name;
  final Value<double> weight;
  const MoorIngredientCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.name = const Value.absent(),
    this.weight = const Value.absent(),
  });
  MoorIngredientCompanion.insert({
    this.id = const Value.absent(),
    @required int recipeId,
    @required String name,
    @required double weight,
  })  : recipeId = Value(recipeId),
        name = Value(name),
        weight = Value(weight);
  static Insertable<MoorIngredientData> custom({
    Expression<int> id,
    Expression<int> recipeId,
    Expression<String> name,
    Expression<double> weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (name != null) 'name': name,
      if (weight != null) 'weight': weight,
    });
  }

  MoorIngredientCompanion copyWith(
      {Value<int> id,
      Value<int> recipeId,
      Value<String> name,
      Value<double> weight}) {
    return MoorIngredientCompanion(
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
    return (StringBuffer('MoorIngredientCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $MoorIngredientTable extends MoorIngredient
    with TableInfo<$MoorIngredientTable, MoorIngredientData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MoorIngredientTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _recipeIdMeta = const VerificationMeta('recipeId');
  GeneratedIntColumn _recipeId;
  @override
  GeneratedIntColumn get recipeId => _recipeId ??= _constructRecipeId();
  GeneratedIntColumn _constructRecipeId() {
    return GeneratedIntColumn(
      'recipe_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  GeneratedRealColumn _weight;
  @override
  GeneratedRealColumn get weight => _weight ??= _constructWeight();
  GeneratedRealColumn _constructWeight() {
    return GeneratedRealColumn(
      'weight',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, recipeId, name, weight];
  @override
  $MoorIngredientTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'moor_ingredient';
  @override
  final String actualTableName = 'moor_ingredient';
  @override
  VerificationContext validateIntegrity(Insertable<MoorIngredientData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(_recipeIdMeta,
          recipeId.isAcceptableOrUnknown(data['recipe_id'], _recipeIdMeta));
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight'], _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorIngredientData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorIngredientData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MoorIngredientTable createAlias(String alias) {
    return $MoorIngredientTable(_db, alias);
  }
}

abstract class _$RecipeDatabase extends GeneratedDatabase {
  _$RecipeDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MoorRecipeTable _moorRecipe;
  $MoorRecipeTable get moorRecipe => _moorRecipe ??= $MoorRecipeTable(this);
  $MoorIngredientTable _moorIngredient;
  $MoorIngredientTable get moorIngredient =>
      _moorIngredient ??= $MoorIngredientTable(this);
  RecipeDao _recipeDao;
  RecipeDao get recipeDao => _recipeDao ??= RecipeDao(this as RecipeDatabase);
  IngredientDao _ingredientDao;
  IngredientDao get ingredientDao =>
      _ingredientDao ??= IngredientDao(this as RecipeDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [moorRecipe, moorIngredient];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$RecipeDaoMixin on DatabaseAccessor<RecipeDatabase> {
  $MoorRecipeTable get moorRecipe => attachedDatabase.moorRecipe;
}
mixin _$IngredientDaoMixin on DatabaseAccessor<RecipeDatabase> {
  $MoorIngredientTable get moorIngredient => attachedDatabase.moorIngredient;
}

import 'dart:io';

import 'package:path/path.dart';
import 'package:recipes/data/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite_common/src/collection_utils.dart';

class DatabaseHelper {
  Uuid uuid = Uuid();

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final recipeTable = 'Recipe';
  static final ingredientTable = 'Ingredient';
  static final columnId = '_id';

  static BriteDatabase _streamDatabase;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static var lock = new Lock();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // Use this object to prevent concurrent access to data
    await lock.synchronized(() async {
      // lazily instantiate the db the first time it is accessed
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database, true);
      }
    });
    return _database;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    Sqflite.setDebugModeOn(true);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $recipeTable (
            _id INTEGER PRIMARY KEY,
            label TEXT,
            image TEXT,
            url TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $ingredientTable (
            _id INTEGER PRIMARY KEY,
            recipeId INTEGER,
            name TEXT,
            weight REAL
          )
          ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    BriteDatabase db = await instance.streamDatabase;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Ingredient>> getAllIngredients() async {
    BriteDatabase db = await instance.streamDatabase;
    var ingredientList = await db.query(ingredientTable);
    List<Ingredient> ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

  Future<List<Ingredient>> getIngredients(int recipeId) async {
    BriteDatabase db = await instance.streamDatabase;
    var ingredientList = await db.query(ingredientTable, where: "recipeId = $recipeId");
    List<Ingredient> ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

  List<Ingredient> parseIngredients(List<Map<String, dynamic>> ingredientList) {
    List<Ingredient> ingredients = List<Ingredient>();
    ingredientList.forEach((ingredientMap) {
      Ingredient ingredient = Ingredient.fromJson(ingredientMap);
      ingredients.add(ingredient);
    });
    return ingredients;
  }


  Future<Recipe> getRecipeById(int id) async {
    BriteDatabase db = await instance.streamDatabase;
    var recipeList = await db.query(recipeTable, where: "id = $id");
    List<Recipe> recipes = parseRecipes(recipeList);
    return recipes.first;
  }

  Future<List<Recipe>> getRecipes() async {
    BriteDatabase db = await instance.streamDatabase;
    var recipeList = await db.query(recipeTable);
    List<Recipe> recipes = parseRecipes(recipeList);
    return recipes;
  }

  List<Recipe> parseRecipes(List<Map<String, dynamic>> recipeList) {
    List<Recipe> recipes = List<Recipe>();
    recipeList.forEach((recipeMap) {
      Recipe recipe = Recipe.fromJson(recipeMap);
      recipes.add(recipe);
    });
    return recipes;
  }

  
  Stream<List<Recipe>> streamRecipes() async* {
    BriteDatabase db = await instance.streamDatabase;
    yield* db.createQuery(recipeTable).mapToList((row) => Recipe.fromJson(row)) ;
  }

  Stream<List<Ingredient>> streamIngredients() async* {
    BriteDatabase db = await instance.streamDatabase;
    yield* db.createQuery(ingredientTable).mapToList((row) => Ingredient.fromJson(row));
  }

   Future<int> queryRowCount(String table) async {
    BriteDatabase db = await instance.streamDatabase;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    BriteDatabase db = await instance.streamDatabase;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId  = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    BriteDatabase db = await instance.streamDatabase;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteIngredients(int recipeId) async {
    BriteDatabase db = await instance.streamDatabase;
    return await db.delete(ingredientTable, where: '$recipeId = ?', whereArgs: [recipeId]);
  }

  Future<int> insertRecipe(Recipe recipe) {
    return insert(recipeTable, recipe.toJson());
  }

  Future<int> insertIngredient(Ingredient ingredient) {
    return insert(ingredientTable, ingredient.toJson());
  }

  void close() {
    _database.close();
  }
}
import 'package:moor_flutter/moor_flutter.dart';
import 'package:recipes/data/models/models.dart';

import 'moor_repository.dart';

part 'moor_db.g.dart';

class MoorRecipe extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get label => text()();

  TextColumn get image => text()();

  TextColumn get url => text()();
}

class MoorIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId => integer()();

  TextColumn get name => text()();

  RealColumn get weight => real()();
}

@UseMoor(tables: [MoorRecipe, MoorIngredient], daos: [RecipeDao, IngredientDao])
class RecipeDatabase extends _$RecipeDatabase {
  RecipeDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "recipes.sqlite", logStatements: true));

  int get schemaVersion => 1;
}

@UseDao(tables: [MoorRecipe])
class RecipeDao extends DatabaseAccessor<RecipeDatabase> with _$RecipeDaoMixin {
  final RecipeDatabase db;

  RecipeDao(this.db) : super(db);

  Future<List<MoorRecipeData>> getAllRecipes() => select(moorRecipe).get();

  Stream<List<Recipe>> watchAllRecipes() {
    return select(moorRecipe)
        .join([
          leftOuterJoin(db.moorIngredient,
              db.moorIngredient.recipeId.equalsExp(moorRecipe.id))
        ])
        .watch()
        .map((rows) {
          List<Recipe> recipes = List<Recipe>();
          rows.forEach((row) {
            var recipe = moorRecipeToRecipe(row.readTable(moorRecipe));
            if (!recipes.contains(recipe)) {
              recipe.ingredients = List<Ingredient>();
              recipes.add(recipe);
            } else {
              recipe = recipes.firstWhere((element) => element.id == recipe.id);
            }
            var ingredient =
                moorIngredientToIngredient(row.readTable(db.moorIngredient));
            if (ingredient != null) {
              recipe.ingredients.add(ingredient);
            }
          });
          return recipes;
        });
  }

  Future<List<MoorRecipeData>> findRecipe(int id) =>
      (select(moorRecipe)..where((tbl) => tbl.id.equals(id))).get();

  Future<int> insertRecipe(Insertable<MoorRecipeData> recipe) =>
      into(moorRecipe).insert(recipe);

  Future deleteRecipe(Insertable<MoorRecipeData> recipe) =>
      delete(moorRecipe).delete(recipe);
}

@UseDao(tables: [MoorIngredient])
class IngredientDao extends DatabaseAccessor<RecipeDatabase>
    with _$IngredientDaoMixin {
  final RecipeDatabase db;

  IngredientDao(this.db) : super(db);

  Future<List<MoorIngredientData>> getAllIngredients() =>
      select(moorIngredient).get();

  Stream<List<MoorIngredientData>> watchAllIngredients() =>
      select(moorIngredient).watch();

  Future<List<MoorIngredientData>> findIngredient(int id) =>
      (select(moorIngredient)..where((tbl) => tbl.recipeId.equals(id))).get();

  Future<int> insertIngredient(Insertable<MoorIngredientData> ingredient) =>
      into(moorIngredient).insert(ingredient);

  Future deleteIngredient(Insertable<MoorIngredientData> ingredient) =>
      delete(moorIngredient).delete(ingredient);
}

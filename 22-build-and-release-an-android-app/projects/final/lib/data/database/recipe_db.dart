import 'package:drift/drift.dart';

import 'connection.dart' as impl;
import '../models/models.dart';

part 'recipe_db.g.dart';

class DbRecipe extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get label => text()();

  TextColumn get image => text()();

  TextColumn get description => text()();

  BoolColumn get bookmarked  => boolean()();

}

class DbIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId => integer()();

  TextColumn get name => text()();

  RealColumn get amount => real()();

}

@DriftDatabase(
  tables: [DbRecipe, DbIngredient],
  daos: [RecipeDao, IngredientDao],
)
class RecipeDatabase extends _$RecipeDatabase {
  RecipeDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [DbRecipe])
class RecipeDao extends DatabaseAccessor<RecipeDatabase> with _$RecipeDaoMixin {
  final RecipeDatabase db;

  RecipeDao(this.db) : super(db);

  Future<List<DbRecipeData>> findAllRecipes() => select(dbRecipe).get();

  Stream<List<Recipe>> watchAllRecipes() {
    return select(dbRecipe).watch().map(
      (rows) {
        final recipes = <Recipe>[];
        for (final row in rows) {
          final recipe = dbRecipeToModelRecipe(row, <Ingredient>[]);
          if (!recipes.contains(recipe)) {
            recipes.add(recipe);
          }
        }
        return recipes;
      },
    );
  }

  Future<List<DbRecipeData>> findRecipeById(int id) =>
      (select(dbRecipe)..where((tbl) => tbl.id.equals(id))).get();

  Future<int> insertRecipe(Insertable<DbRecipeData> recipe) =>
      into(dbRecipe).insert(recipe);

  Future deleteRecipe(int id) =>
      Future.value((delete(dbRecipe)..where((tbl) => tbl.id.equals(id))).go());
}

@DriftAccessor(tables: [DbIngredient])
class IngredientDao extends DatabaseAccessor<RecipeDatabase>
    with _$IngredientDaoMixin {
  final RecipeDatabase db;

  IngredientDao(this.db) : super(db);

  Future<List<DbIngredientData>> findAllIngredients() =>
      select(dbIngredient).get();

  Stream<List<DbIngredientData>> watchAllIngredients() =>
      select(dbIngredient).watch();

  Future<List<DbIngredientData>> findRecipeIngredients(int id) =>
      (select(dbIngredient)..where((tbl) => tbl.recipeId.equals(id))).get();

  Future<int> insertIngredient(Insertable<DbIngredientData> ingredient) =>
      into(dbIngredient).insert(ingredient);

  Future deleteIngredient(int id) => Future.value(
      (delete(dbIngredient)..where((tbl) => tbl.id.equals(id))).go());
}

// Conversion Methods


Recipe dbRecipeToModelRecipe(
    DbRecipeData recipe, List<Ingredient> ingredients) {
  return Recipe(
    id: recipe.id,
    label: recipe.label,
    image: recipe.image,
    description: recipe.description,
    bookmarked: recipe.bookmarked,
    ingredients: ingredients,
  );
}



Insertable<DbRecipeData> recipeToInsertableDbRecipe(Recipe recipe) {
  return DbRecipeCompanion.insert(
    id: Value.ofNullable(recipe.id),
    label: recipe.label ?? '',
    image: recipe.image ?? '',
    description: recipe.description ?? '',
    bookmarked: recipe.bookmarked,
  );
}

Ingredient dbIngredientToIngredient(DbIngredientData ingredient) {
  return Ingredient(
    id: ingredient.id,
    recipeId: ingredient.recipeId,
    name: ingredient.name,
    amount: ingredient.amount,
  );
}

DbIngredientCompanion ingredientToInsertableDbIngredient(
    Ingredient ingredient) {
  return DbIngredientCompanion.insert(
    recipeId: ingredient.recipeId ?? 0,
    name: ingredient.name ?? '',
    amount: ingredient.amount ?? 0,
  );
}


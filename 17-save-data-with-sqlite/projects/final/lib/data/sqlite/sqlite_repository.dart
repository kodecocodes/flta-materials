import 'dart:async';

import 'package:recipes/data/repository.dart';
import 'package:recipes/data/sqlite/DatabaseHelper.dart';
import '../models/models.dart';


class SqliteRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  void close() {
    dbHelper.close();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    return dbHelper.delete(DatabaseHelper.ingredientTable, ingredient.id);
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    if (ingredients != null) {
      ingredients.forEach((ingredient) {
        if (ingredient != null) {
          dbHelper.delete(DatabaseHelper.ingredientTable, ingredient.id);
        }
      });
    }
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    dbHelper.deleteIngredients(recipeId);

  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    dbHelper.delete(DatabaseHelper.recipeTable, recipe.id);
    deleteIngredients(recipe.ingredients);
    return Future.value();
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return dbHelper.getAllIngredients();
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return dbHelper.getRecipes();
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return dbHelper.getRecipeById(id);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int id) {
    return dbHelper.getIngredients(id);
  }

  @override
  // ignore: missing_return
  Future init() {}

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    return Future(() async {
      if (ingredients != null && ingredients.length != 0) {
        List<int> ingredientIds = List<int>();
        await Future.forEach(ingredients, (ingredient) async {
          if (ingredient != null) {
            var futureId = await dbHelper.insertIngredient(ingredient);
            ingredient.id = futureId;
            ingredientIds.add(futureId);
          }
        });
        return Future.value(ingredientIds);
      } else {
        return Future.value(List<int>());
      }
    });
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    return Future(() async {
      int id = await dbHelper.insertRecipe(recipe);
      recipe.id = id;
      print("insertRecipe id: $id");
      if (recipe.ingredients != null) {
        recipe.ingredients.forEach((ingredient) {
          ingredient.recipeId = id;
        });
      }
      insertIngredients(recipe.ingredients);
      return id;
    });
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return dbHelper.streamIngredients();
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    return dbHelper.streamRecipes();
  }
}

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/current_recipe_data.dart';
import '../models/models.dart';
import 'repository.dart';
import '../database/recipe_db.dart';

class DBRepository extends Notifier<CurrentRecipeData> implements Repository {
  late RecipeDatabase recipeDatabase;
  late RecipeDao _recipeDao;
  late IngredientDao _ingredientDao;
  Stream<List<Ingredient>>? ingredientStream;
  Stream<List<Recipe>>? recipeStream;

  @override
  CurrentRecipeData build() {
    const currentRecipeData = CurrentRecipeData();
    return currentRecipeData;
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return _recipeDao.findAllRecipes().then<List<Recipe>>(
      (List<DbRecipeData> dbRecipes) async {
        final recipes = <Recipe>[];
        for (final dbRecipe in dbRecipes) {
          final ingredients = await findRecipeIngredients(dbRecipe.id);
          final recipe = dbRecipeToModelRecipe(dbRecipe, ingredients);
          recipes.add(recipe);
        }
        return recipes;
      },
    );
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    recipeStream ??= _recipeDao.watchAllRecipes();
    return recipeStream!;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if (ingredientStream == null) {
      final stream = _ingredientDao.watchAllIngredients();
      ingredientStream = stream.map(
        (dbIngredients) {
          final ingredients = <Ingredient>[];
          for (final dbIngredient in dbIngredients) {
            ingredients.add(dbIngredientToIngredient(dbIngredient));
          }
          return ingredients;
        },
      );
    }
    return ingredientStream!;
  }

  @override
  Future<Recipe> findRecipeById(int id) async {
    final ingredients = await findRecipeIngredients(id);
    return _recipeDao.findRecipeById(id).then((listOfRecipes) =>
        dbRecipeToModelRecipe(listOfRecipes.first, ingredients));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return _ingredientDao.findAllIngredients().then<List<Ingredient>>(
      (List<DbIngredientData> dbIngredients) {
        final ingredients = <Ingredient>[];
        for (final ingredient in dbIngredients) {
          ingredients.add(dbIngredientToIngredient(ingredient));
        }
        return ingredients;
      },
    );
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    return _ingredientDao.findRecipeIngredients(recipeId).then(
      (listOfIngredients) {
        final ingredients = <Ingredient>[];
        for (final ingredient in listOfIngredients) {
          ingredients.add(
            dbIngredientToIngredient(ingredient),
          );
        }
        return ingredients;
      },
    );
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    if (state.currentRecipes.contains(recipe)) {
      return Future.value(0);
    }
    return Future(
      () async {
        state =
            state.copyWith(currentRecipes: [...state.currentRecipes, recipe]);
        final id = await _recipeDao.insertRecipe(
          recipeToInsertableDbRecipe(recipe),
        );
        final ingredients = <Ingredient>[];
        for (final ingredient in recipe.ingredients) {
          ingredients.add(ingredient.copyWith(recipeId: id));
        }
        insertIngredients(ingredients);
        return id;
      },
    );
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    return Future(
      () {
        if (ingredients.isEmpty) {
          return <int>[];
        }
        final resultIds = <int>[];
        for (final ingredient in ingredients) {
          final dbIngredient = ingredientToInsertableDbIngredient(ingredient);
          _ingredientDao
              .insertIngredient(dbIngredient)
              .then((int id) => resultIds.add(id));
        }
        state = state.copyWith(
            currentIngredients: [...state.currentIngredients, ...ingredients]);
        return resultIds;
      },
    );
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    if (recipe.id != null) {
      final updatedList = [...state.currentRecipes];
      updatedList.remove(recipe);
      state = state.copyWith(currentRecipes: updatedList);
      _recipeDao.deleteRecipe(recipe.id!);
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    if (ingredient.id != null) {
      final updatedList = [...state.currentIngredients];
      updatedList.remove(ingredient);
      state = state.copyWith(currentIngredients: updatedList);
      return _ingredientDao.deleteIngredient(ingredient.id!);
    } else {
      return Future.value();
    }
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    for (final ingredient in ingredients) {
      if (ingredient.id != null) {
        final updatedList = [...state.currentIngredients];
        updatedList
            .removeWhere((ingredient) => ingredients.contains(ingredient));
        state = state.copyWith(currentIngredients: updatedList);
        _ingredientDao.deleteIngredient(ingredient.id!);
      }
    }
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) async {
    final updatedList = [...state.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    state = state.copyWith(currentIngredients: updatedList);
    final ingredients = await findRecipeIngredients(recipeId);
    return deleteIngredients(ingredients);
  }

  @override
  Future init() async {
    recipeDatabase = RecipeDatabase();
    _recipeDao = recipeDatabase.recipeDao;
    _ingredientDao = recipeDatabase.ingredientDao;
  }

  @override
  void close() {
    recipeDatabase.close();
  }
}

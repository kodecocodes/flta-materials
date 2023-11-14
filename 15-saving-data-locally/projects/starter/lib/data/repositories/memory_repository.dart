import 'dart:async';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/current_recipe_data.dart';
import '../models/models.dart';
import 'repository.dart';

class MemoryRepository extends Notifier<CurrentRecipeData>
    implements Repository {
  late Stream<List<Recipe>> _recipeStream;
  late Stream<List<Ingredient>> _ingredientStream;
  final StreamController _recipeStreamController =
  StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController =
  StreamController<List<Ingredient>>();


  MemoryRepository() {
    _recipeStream = _recipeStreamController.stream.asBroadcastStream(
      onListen: (subscription) {
        // This is to send the current recipes to new subscriber
        _recipeStreamController.sink.add(state.currentRecipes);
      },
    ) as Stream<List<Recipe>>;
    _ingredientStream = _ingredientStreamController.stream.asBroadcastStream(
      onListen: (subscription) {
        // This is to send the current ingredients to new subscriber
        _ingredientStreamController.sink.add(state.currentIngredients);
      },
    ) as Stream<List<Ingredient>>;
  }

  @override
  CurrentRecipeData build() {
    const currentRecipeData = CurrentRecipeData();
    return currentRecipeData;
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    return _recipeStream;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return _ingredientStream;
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return Future.value(state.currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
        state.currentRecipes.firstWhere((recipe) => recipe.id == id));
    }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(state.currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    final recipe =
    state.currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = state.currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    if (state.currentRecipes.contains(recipe)) {
      return Future.value(0);
    }
    state = state.copyWith(currentRecipes: [...state.currentRecipes, recipe]);
    _recipeStreamController.sink.add(state.currentRecipes);
    final ingredients = <Ingredient>[];
    for (final ingredient in recipe.ingredients) {
      ingredients.add(ingredient.copyWith(recipeId: recipe.id));
    }
    insertIngredients(ingredients);
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      state = state.copyWith(
          currentIngredients: [...state.currentIngredients, ...ingredients]);

      _ingredientStreamController.sink.add(state.currentIngredients);
    }
    return Future.value(<int>[]);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    final updatedList = [...state.currentRecipes];
    updatedList.remove(recipe);
    state = state.copyWith(currentRecipes: updatedList);
    _recipeStreamController.sink.add(state.currentRecipes);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    final updatedList = [...state.currentIngredients];
    updatedList.remove(ingredient);
    state = state.copyWith(currentIngredients: updatedList);

    _ingredientStreamController.sink.add(state.currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    final updatedList = [...state.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredients.contains(ingredient));
    state = state.copyWith(currentIngredients: updatedList);
    _ingredientStreamController.sink.add(state.currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    final updatedList = [...state.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    state = state.copyWith(currentIngredients: updatedList);
    _ingredientStreamController.sink.add(state.currentIngredients);
    return Future.value();
  }

  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}

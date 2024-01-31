import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/current_recipe_data.dart';
import '../models/models.dart';
import 'repository.dart';

class MemoryRepository extends Notifier<CurrentRecipeData>
    implements Repository {
  @override
  CurrentRecipeData build() {
    const currentRecipieData = CurrentRecipeData();
    return currentRecipieData;
  }

  @override
  List<Recipe> findAllRecipes() {
    return state.currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return state.currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return state.currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe =
        state.currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = state.currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  @override
  int insertRecipe(Recipe recipe) {
    if (state.currentRecipes.contains(recipe)) {
      return 0;
    }
    state = state.copyWith(currentRecipes: [...state.currentRecipes, recipe]);
    insertIngredients(recipe.ingredients);
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      state = state.copyWith(
          currentIngredients: [...state.currentIngredients, ...ingredients]);
    }
    return <int>[];
  }

  @override
  void deleteRecipe(Recipe recipe) {
    final updatedList = [...state.currentRecipes];
    updatedList.remove(recipe);
    state = state.copyWith(currentRecipes: updatedList);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    final updatedList = [...state.currentIngredients];
    updatedList.remove(ingredient);
    state = state.copyWith(currentIngredients: updatedList);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    final updatedList = [...state.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredients.contains(ingredient));
    state = state.copyWith(currentIngredients: updatedList);
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    final updatedList = [...state.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    state = state.copyWith(currentIngredients: updatedList);
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}

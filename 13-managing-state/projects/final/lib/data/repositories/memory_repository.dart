import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/current_recipe_data.dart';
import '../models/models.dart';
import 'repository.dart';

class MemoryRepository extends Notifier<CurrentRecipeData>
    implements Repository {
  CurrentRecipeData currentRecipeData = const CurrentRecipeData();

  @override
  List<Recipe> findAllRecipes() {
    return currentRecipeData.currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return currentRecipeData.currentRecipes
        .firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return currentRecipeData.currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe = currentRecipeData.currentRecipes
        .firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = currentRecipeData.currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  @override
  int insertRecipe(Recipe recipe) {
    currentRecipeData = currentRecipeData.copyWith(
        currentRecipes: [...currentRecipeData.currentRecipes, recipe]);
    insertIngredients(recipe.ingredients);
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      currentRecipeData = currentRecipeData.copyWith(currentIngredients: [
        ...currentRecipeData.currentIngredients,
        ...ingredients
      ]);
    }
    return <int>[];
  }

  @override
  void deleteRecipe(Recipe recipe) {
    final updatedList = [...currentRecipeData.currentRecipes];
    updatedList.remove(recipe);
    currentRecipeData = currentRecipeData.copyWith(currentRecipes: updatedList);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    final updatedList = [...currentRecipeData.currentIngredients];
    updatedList.remove(ingredient);
    currentRecipeData =
        currentRecipeData.copyWith(currentIngredients: updatedList);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    final updatedList = [...currentRecipeData.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredients.contains(ingredient));
    currentRecipeData =
        currentRecipeData.copyWith(currentIngredients: updatedList);
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    final updatedList = [...currentRecipeData.currentIngredients];
    updatedList.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    currentRecipeData =
        currentRecipeData.copyWith(currentIngredients: updatedList);
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}

  @override
  CurrentRecipeData build() {
    return currentRecipeData;
  }
}

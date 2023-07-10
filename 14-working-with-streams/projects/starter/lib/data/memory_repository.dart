import 'dart:core';
import 'package:flutter/foundation.dart';
import 'models/models.dart';

class MemoryRepository with ChangeNotifier {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    insertIngredients(recipe.ingredients);
    notifyListeners();
    return 0;
  }

  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
      notifyListeners();
    }
    return <int>[];
  }

  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    notifyListeners();
  }

  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }

  Future init() {
    return Future.value(null);
  }

  void close() {}
}

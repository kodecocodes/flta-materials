

import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:recipes/data/repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  List<Recipe> _currentRecipes = List<Recipe>();
  List<Ingredient> _currentIngredients = List<Ingredient>();

  @override
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((element) => element.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int id) {
    var recipe = _currentRecipes.firstWhere((element) => element.id == id);
    var recipeIngredients = _currentIngredients.where((element) => element.recipeId == recipe.id).toList();
    return recipeIngredients;
  }

  @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    insertIngredients(recipe.ingredients);
    notifyListeners();
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients != null && ingredients.length != 0) {
      _currentIngredients.addAll(ingredients);
      notifyListeners();
    }
    return List<int>();
  }

  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    deleteRecipeIngredients(recipe.id);
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients.removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients.forEach((ingredient) {
      if (ingredient.recipeId == recipeId) {
        _currentIngredients.remove(ingredient);
      }
    });
  }

  @override
  Future init() {
  }

  @override
  void close() {
  }

}
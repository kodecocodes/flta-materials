

import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:recipes/data/repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  List<Recipe> _currentRecipes = List<Recipe>();
  List<Ingredient> _currentIngredients = List<Ingredient>();


  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients.removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    deleteIngredients(recipe.ingredients);
    notifyListeners();
  }


  @override
  List<Ingredient>findAllIngredients() {
    return _currentIngredients;
  }


  @override
  List<Recipe>findAllRecipes() {
    return _currentRecipes;
  }


  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((element) => element.id == id);
  }

  @override
  List<Ingredient>findRecipeIngredients(int id) {
    var recipe = _currentRecipes.firstWhere((element) => element.id == id);
    var firstWhere = _currentIngredients.firstWhere((element) => element.recipeId == recipe.id);
    return List<Ingredient>.filled(1, firstWhere);
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
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    insertIngredients(recipe.ingredients);
    notifyListeners();
    return 0;
  }

  @override
  Future init() {

  }

  @override
  void close() {

  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients.forEach((ingredient) {
      if (ingredient.recipeId == recipeId) {
        _currentIngredients.remove(ingredient);
      }
    });
  }
}
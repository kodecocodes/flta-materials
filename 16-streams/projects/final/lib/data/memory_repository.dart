import 'dart:async';
import 'dart:core';

import 'package:recipes/data/repository.dart';

import 'models/models.dart';

class MemoryRepository extends Repository {
  List<Recipe> _currentRecipes = List<Recipe>();
  List<Ingredient> _currentIngredients = List<Ingredient>();
  Stream<List<Recipe>> _recipeStream;
  Stream<List<Ingredient>> _ingredientStream;
  StreamController _recipeStreamController = StreamController<List<Recipe>>();
  StreamController _ingredientStreamController =
      StreamController<List<Ingredient>>();

  @override
  Future<List<Recipe>> findAllRecipes() {
    return Future.value(_currentRecipes);
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    if (_recipeStream == null) {
      _recipeStream = _recipeStreamController.stream;
    }
    return _recipeStream;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if (_ingredientStream == null) {
      _ingredientStream = _ingredientStreamController.stream;
    }
    return _ingredientStream;
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
        _currentRecipes.firstWhere((element) => element.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int id) {
    var recipe = _currentRecipes.firstWhere((element) => element.id == id);
    var firstWhere = _currentIngredients
        .firstWhere((element) => element.recipeId == recipe.id);
    return Future.value(List<Ingredient>.filled(1, firstWhere));
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    insertIngredients(recipe.ingredients);
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients != null && ingredients.length != 0) {
      _currentIngredients.addAll(ingredients);
      _ingredientStreamController.sink.add(_currentIngredients);
    }
    return Future.value(List<int>());
  }


  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    deleteIngredients(recipe.ingredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
   _currentIngredients.remove(ingredient);
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    _ingredientStreamController.sink.add(_currentIngredients);
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

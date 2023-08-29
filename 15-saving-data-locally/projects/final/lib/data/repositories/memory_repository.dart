import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';

import '../models/models.dart';
import 'repository.dart';

class MemoryRepository with ChangeNotifier implements Repository {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];
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
        _recipeStreamController.sink.add(_currentRecipes);
      },
    ) as Stream<List<Recipe>>;
    _ingredientStream = _ingredientStreamController.stream.asBroadcastStream(
      onListen: (subscription) {
        // This is to send the current ingredients to new subscriber
        _ingredientStreamController.sink.add(_currentIngredients);
      },
    ) as Stream<List<Ingredient>>;
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
    return Future.value(_currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
        _currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    final ingredients = <Ingredient>[];
    for (final ingredient in recipe.ingredients) {
      ingredients.add(ingredient.copyWith(recipeId: recipe.id));
    }
    insertIngredients(ingredients);
    notifyListeners();
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
      _ingredientStreamController.sink.add(_currentIngredients);
    }
    notifyListeners();
    return Future.value(<int>[]);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _currentRecipes.removeWhere((element) => element.id == recipe.id);
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    notifyListeners();
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
    _ingredientStreamController.sink.add(_currentIngredients);
    notifyListeners();
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _ingredientStreamController.sink.add(_currentIngredients);
    notifyListeners();
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    _ingredientStreamController.sink.add(_currentIngredients);
    notifyListeners();
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
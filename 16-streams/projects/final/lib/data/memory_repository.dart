import 'dart:async';
import 'dart:core';
import 'package:recipes/data/repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository {
  List<Recipe> _currentRecipes = List<Recipe>();
  List<Ingredient> _currentIngredients = List<Ingredient>();
  Stream<List<Recipe>> recipeStream;
  Stream<List<Ingredient>> ingredientStream;
  StreamController _recipeStreamController = StreamController<List<Recipe>>();
  StreamController _ingredientStreamController =
      StreamController<List<Ingredient>>();

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
   _currentIngredients.remove(ingredient);
    _ingredientStreamController.sink.add(_currentIngredients);
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _ingredientStreamController.sink.add(_currentIngredients);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    deleteIngredients(recipe.ingredients);
    return Future.value();
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return Future.value(_currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
        _currentRecipes.firstWhere((element) => element.id == id));
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int id) {
    var recipe = _currentRecipes.firstWhere((element) => element.id == id);
    var firstWhere = _currentIngredients
        .firstWhere((element) => element.recipeId == recipe.id);
    return Future.value(List<Ingredient>.filled(1, firstWhere));
  }

  @override
  Future init() {}

  @override
  Future<List<String>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients != null && ingredients.length != 0) {
      _currentIngredients.addAll(ingredients);
      _ingredientStreamController.sink.add(_currentIngredients);
    }
    return Future.value(List<String>());
  }

  @override
  Future<String> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    insertIngredients(recipe.ingredients);
    return Future.value("");
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if (ingredientStream == null) {
      ingredientStream = _ingredientStreamController.stream;
    }
    return ingredientStream;
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    if (recipeStream == null) {
      recipeStream = _recipeStreamController.stream;
    }
    return recipeStream;
  }
}

import 'dart:async';
import 'package:recipes/data/models/models.dart';

import '../repository.dart';
import 'moor_db.dart';

class MoorRepository extends Repository {
  RecipeDatabase recipeDatabase;
  RecipeDao _recipeDao;
  IngredientDao _ingredientDao;
  Stream<List<Ingredient>> ingredientStream;
  Stream<List<Recipe>> recipeStream;

  @override
  Future<List<Recipe>> findAllRecipes() {
    return _recipeDao
        .findAllRecipes()
        .then<List<Recipe>>((List<MoorRecipeData> moorRecipes) {
      List<Recipe> recipes = List<Recipe>();
      moorRecipes.forEach((moorRecipe) async {
        var recipe = moorRecipeToRecipe(moorRecipe);
        recipe.ingredients = await findRecipeIngredients(recipe.id);
        recipes.add(recipe);
      });
      return recipes;
    });
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    if (recipeStream == null) {
      recipeStream = _recipeDao.watchAllRecipes();
    }
    return recipeStream;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if (ingredientStream == null) {
      var stream = _ingredientDao.watchAllIngredients();
      ingredientStream = stream.map((moorIngredients) {
        List<Ingredient> ingredients = List<Ingredient>();
        moorIngredients.forEach((moorIngredient) {
          ingredients.add(moorIngredientToIngredient(moorIngredient));
        });
        return ingredients;
      });
    }
    return ingredientStream;
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return _recipeDao
        .findRecipeById(id)
        .then((listOfRecipes) => moorRecipeToRecipe(listOfRecipes.first));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return _ingredientDao
        .findAllIngredients()
        .then<List<Ingredient>>((List<MoorIngredientData> moorIngredients) {
      List<Ingredient> ingredients = List<Ingredient>();
      moorIngredients.forEach((ingredient) async {
        ingredients.add(moorIngredientToIngredient(ingredient));
      });
      return ingredients;
    });
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int id) {
    return _ingredientDao.findRecipeIngredients(id).then((listOfIngredients) {
      List<Ingredient> ingredients = List<Ingredient>();
      listOfIngredients.forEach((ingredient) {
        ingredients.add(moorIngredientToIngredient(ingredient));
      });
      return ingredients;
    });
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    return Future(() async {
      var id =
          await _recipeDao.insertRecipe(recipeToInsertableMoorRecipe(recipe));
      recipe.ingredients.forEach((ingredient) {
        ingredient.recipeId = id;
      });
      insertIngredients(recipe.ingredients);
      return id;
    });
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    return Future(() {
      if (ingredients == null || ingredients.length == 0) {
        return List<int>();
      }
      List<int> resultIds = List<int>();
      ingredients.forEach((ingredient) {
        var moorIngredient = ingredientToInsertableMoorIngredient(ingredient);
        _ingredientDao
            .insertIngredient(moorIngredient)
            .then((int id) => resultIds.add(id));
      });
      return resultIds;
    });
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _recipeDao.deleteRecipe(recipe.id);
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    return _ingredientDao
        .deleteIngredient(ingredient.id);
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    ingredients.forEach((ingredient) {
      _ingredientDao
          .deleteIngredient(ingredient.id);
    });
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) async {
    List<Ingredient> ingredients = await findRecipeIngredients(recipeId);
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

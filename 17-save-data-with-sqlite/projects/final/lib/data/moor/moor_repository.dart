import 'dart:async';


import 'package:moor_flutter/moor_flutter.dart';
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
        .getAllRecipes()
        .then<List<Recipe>>((List<MoorRecipeData> moorRecipes) {
      List<Recipe> recipes = List<Recipe>();
      moorRecipes.forEach((recipe) async {
        var moorRecipe = moorRecipeToRecipe(recipe);
        moorRecipe.ingredients = await findRecipeIngredients(moorRecipe.id);
        recipes.add(moorRecipe);
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
        moorIngredients.forEach((ingredient) {
          ingredients.add(moorIngredientToIngredient(ingredient));
        });
        return ingredients;
      });
    }
    return ingredientStream;
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return _recipeDao
        .findRecipe(id)
        .then((listOfRecipes) => moorRecipeToRecipe(listOfRecipes.first));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return _ingredientDao
        .getAllIngredients()
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
    return _ingredientDao
        .findIngredient(id)
        .then((listOfIngredients) {
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
      var row = await _recipeDao
          .insertRecipe(recipeToInsertableMoorRecipe(recipe));
      var rowString = row;
      recipe.ingredients.forEach((ingredient) {
        ingredient.recipeId = rowString;
      });
      insertIngredients(recipe.ingredients);
      return rowString;
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
            .then((int row) => resultIds.add(row));
      });
      return resultIds;
    });
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _recipeDao.deleteRecipe(recipeToMoorDeletableRecipe(recipe));
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    return _ingredientDao
        .deleteIngredient(ingredientToDeletableMoorIngredient(ingredient));
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    ingredients.forEach((ingredient) {
      _ingredientDao
          .deleteIngredient(ingredientToDeletableMoorIngredient(ingredient));
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

Recipe moorRecipeToRecipe(MoorRecipeData recipe) {
  return Recipe(
      id: recipe.id,
      label: recipe.label,
      image: recipe.image,
      url: recipe.url);
}

Insertable<MoorRecipeData> recipeToInsertableMoorRecipe(Recipe recipe) {
  return MoorRecipeCompanion.insert(
      label: recipe.label,
      image: recipe.image,
      url: recipe.url);
}

Insertable<MoorRecipeData> recipeToMoorDeletableRecipe(Recipe recipe) {
  return MoorRecipeData(
      id: recipe.id, label: recipe.label, image: recipe.image, url: recipe.url);
}

Ingredient moorIngredientToIngredient(MoorIngredientData ingredient) {
  return Ingredient(
      id: ingredient.id,
      recipeId: ingredient.recipeId,
      name: ingredient.name,
      weight: ingredient.weight);
}

Insertable<MoorIngredientData> ingredientToInsertableMoorIngredient(Ingredient ingredient) {
  if (ingredient == null) {
    return null;
  }
  return MoorIngredientCompanion.insert(
      recipeId: ingredient.recipeId,
      name: ingredient.name,
      weight: ingredient.weight);
}

Insertable<MoorIngredientData> ingredientToDeletableMoorIngredient(
    Ingredient ingredient) {
  return MoorIngredientData(
      id: ingredient.id,
      recipeId: ingredient.recipeId,
      name: ingredient.name,
      weight: ingredient.weight);
}


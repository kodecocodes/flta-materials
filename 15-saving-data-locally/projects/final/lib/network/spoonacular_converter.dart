import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:recipes/network/query_result.dart';

import '../data/models/ingredient.dart';
import '../data/models/recipe.dart';
import 'model_response.dart';
import 'spoonacular_model.dart';

class SpoonacularConverter implements Converter {

  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  /// Take the JSON data and convert to models
  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      final mapData = json.decode(body) as Map<String, dynamic>;

      // This is the list of recipes
      if (mapData.keys.contains('totalResults')) {
        final spoonacularResults = SpoonacularResults.fromJson(mapData);
        final recipes = spoonacularResultsToRecipe(spoonacularResults);
        final apiQueryResults = QueryResult(
            offset: spoonacularResults.offset,
            number: spoonacularResults.number,
            totalResults: spoonacularResults.totalResults,
            recipes: recipes);
        return response.copyWith<BodyType>(
          body: Success(apiQueryResults) as BodyType,
        );
      } else {
        // This is the recipe details
        final spoonacularResults = SpoonacularRecipe.fromJson(mapData);
        final recipe = spoonacularRecipeToRecipe(spoonacularResults);
        return response.copyWith<BodyType>(
          body: Success(recipe) as BodyType,
        );
      }
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(
        body: Error(e as Exception) as BodyType,
      );
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }

  /// Methods to convert network recipes into local recipes
  List<Recipe> spoonacularResultsToRecipe(SpoonacularResults result) {
    final recipes = <Recipe>[];
    for (final result in result.results) {
      recipes.add(spoonacularToRecipe(result));
    }
    return recipes;
  }

  Recipe spoonacularToRecipe(SpoonacularResult result) {
    return Recipe(
        id: result.id,
        image: result.image,
        label: result.title,
        ingredients: const <Ingredient>[],
        description: result.title);
  }

  Recipe spoonacularRecipeToRecipe(SpoonacularRecipe spoonacularRecipe) {
    final ingredients = <Ingredient>[];
    for (final ingredient in spoonacularRecipe.extendedIngredients) {
      ingredients.add(Ingredient(
          id: ingredient.id,
          name: ingredient.name,
          amount: ingredient.amount,
          recipeId: spoonacularRecipe.id));
    }
    return Recipe(
      id: spoonacularRecipe.id,
      label: spoonacularRecipe.title,
      image: spoonacularRecipe.image,
      description: spoonacularRecipe.summary,
      ingredients: ingredients,
    );
  }
}

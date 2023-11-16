import 'dart:math';

import '../data/models/recipe.dart';
import '../network/model_response.dart';
import '../network/query_result.dart';
import '../network/service_interface.dart';

class MockService implements ServiceInterface {
  late QueryResult _currentRecipes1;
  late QueryResult _currentRecipes2;
  late Recipe recipeDetails;
  Random nextRecipe = Random();

  static Future<MockService> create() async {
    final mockService = MockService();
    await mockService.loadRecipes();
    return mockService;
  }

  Future loadRecipes() async {
    /*
    // Recipe List 1
    var jsonString = await rootBundle.loadString('assets/recipes1.json');
    var spoonacularResults =
        SpoonacularResults.fromJson(jsonDecode(jsonString));
    var recipes = spoonacularResultsToRecipe(spoonacularResults);
    var apiQueryResults = QueryResult(
        offset: spoonacularResults.offset,
        number: spoonacularResults.number,
        totalResults: spoonacularResults.totalResults,
        recipes: recipes);
    _currentRecipes1 = apiQueryResults;

    // Recipe List 2
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    spoonacularResults = SpoonacularResults.fromJson(jsonDecode(jsonString));
    recipes = spoonacularResultsToRecipe(spoonacularResults);
    apiQueryResults = QueryResult(
        offset: spoonacularResults.offset,
        number: spoonacularResults.number,
        totalResults: spoonacularResults.totalResults,
        recipes: recipes);
    _currentRecipes2 = apiQueryResults;

    // Recipe Details
    jsonString = await rootBundle.loadString('assets/recipe_details.json');
    final spoonacularRecipe =
        SpoonacularRecipe.fromJson(jsonDecode(jsonString));
    spoonacularRecipe.id = recipes[0].id!;
    recipeDetails = spoonacularRecipeToRecipe(spoonacularRecipe);
     */
  }

  @override
  Future<RecipeResponse> queryRecipes(
    String query,
    int offset,
    int number,
  ) {
    switch (nextRecipe.nextInt(2)) {
      case 0:
        return Future.value(
            Success<QueryResult>(_currentRecipes1),
        );
      case 1:
        return Future.value(
            Success<QueryResult>(_currentRecipes2),
        );
      default:
        return Future.value(
            Success<QueryResult>(_currentRecipes1),
        );
    }
  }

  @override
  Future<RecipeDetailsResponse> queryRecipe(String id) {
    return Future.value(
        Success<Recipe>(recipeDetails),
    );
  }
}

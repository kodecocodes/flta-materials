import 'package:chopper/chopper.dart';

import '../data/models/recipe.dart';
import 'model_response.dart';
import 'spoonacular_service.dart';


abstract class ServiceInterface {
  /// Query recipes with the given query string
  /// offset is the starting point
  /// number is the number of items
  Future<RecipeResponse> queryRecipes(
    String query,
    int offset,
    int number,
  );

  /// Get the details of a specific recipe
  Future<Response<Result<Recipe>>> queryRecipe(
    @Path('id') String id,
  );
}

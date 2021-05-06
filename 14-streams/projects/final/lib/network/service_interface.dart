import 'package:chopper/chopper.dart';

import 'model_response.dart';
import 'recipe_model.dart';

abstract class ServiceInterface {
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      String query, int from, int to);
}
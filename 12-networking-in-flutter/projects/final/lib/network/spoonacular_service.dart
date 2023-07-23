import 'package:chopper/chopper.dart';

import 'model_response.dart';
import 'query_result.dart';
import 'service_interface.dart';
import 'spoonacular_converter.dart';
import '../data/models/models.dart';

part 'spoonacular_service.chopper.dart';

const String apiKey = '<Add Your Key Here>';
const String apiUrl = 'https://api.spoonacular.com/';


@ChopperApi()
abstract class SpoonacularService extends ChopperService
    implements ServiceInterface {

  /// Get a list of recipes that match the query string
  @override
  @Get(path: 'recipes/complexSearch')
  Future<RecipeResponse> queryRecipes(
    @Query('query') String query,
    @Query('offset') int offset,
    @Query('number') int number,
  );

  /// Get the details of a specific recipe
  @override
  @Get(path: 'recipes/{id}/information?includeNutrition=false')
  Future<Response<Result<Recipe>>> queryRecipe(
    @Path('id') String id,
  );

  /// Create a new Chopper Client for our recipe service
  static SpoonacularService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: SpoonacularConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$SpoonacularService(),
      ],
    );
    return _$SpoonacularService(client);
  }
}

/// Add the ApiKey to the list of parameters
Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['apiKey'] = apiKey;

  return req.copyWith(parameters: params);
}

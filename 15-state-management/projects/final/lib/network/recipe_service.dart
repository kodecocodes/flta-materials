
import 'package:recipes/network/recipe_model.dart';
import 'package:chopper/chopper.dart';
import 'package:recipes/network/model_converter.dart';
import 'package:recipes/network/model_response.dart';

part 'recipe_service.chopper.dart';

@ChopperApi()
abstract class RecipeService extends ChopperService {

  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(@Query('q') String query, @Query('from') int from, @Query('to') int to);

  static RecipeService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.edamam.com',
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
      services: [
        _$RecipeService(),
      ],
    );
    return _$RecipeService(client);
  }

}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['app_id'] = '00691437';
  params['app_key'] = 'c517bfd8ff8dba49d18ae70ad84b7d23';

  return req.copyWith(parameters: params);
}

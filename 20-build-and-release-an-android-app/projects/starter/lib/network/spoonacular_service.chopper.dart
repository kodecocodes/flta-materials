// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$SpoonacularService extends SpoonacularService {
  _$SpoonacularService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SpoonacularService;

  @override
  Future<Response<Result<QueryResult>>> queryRecipes(
    String query,
    int offset,
    int number,
  ) {
    final Uri $url = Uri.parse('recipes/complexSearch');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'offset': offset,
      'number': number,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Result<QueryResult>, QueryResult>($request);
  }

  @override
  Future<Response<Result<Recipe>>> queryRecipe(String id) {
    final Uri $url =
        Uri.parse('recipes/${id}/information?includeNutrition=false');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Result<Recipe>, Recipe>($request);
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../data/models/recipe.dart';
import '../network/model_response.dart';
import '../network/query_result.dart';
import '../network/spoonacular_service.dart';

class MockService {
  late QueryResult _currentRecipes1;
  late QueryResult _currentRecipes2;
  Random nextRecipe = Random();

  void create() {
    loadRecipes();
  }

  void loadRecipes() async {
    var jsonString = await rootBundle.loadString('assets/recipes1.json');
    _currentRecipes1 = QueryResult.fromJson(jsonDecode(jsonString));
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    _currentRecipes2 = QueryResult.fromJson(jsonDecode(jsonString));
  }

  Future<RecipeResponse> queryRecipes(
    String query,
    int offset,
    int number,
  ) {
    switch (nextRecipe.nextInt(2)) {
      case 0:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<QueryResult>(_currentRecipes1),
          ),
        );
      case 1:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<QueryResult>(_currentRecipes2),
          ),
        );
      default:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<QueryResult>(_currentRecipes1),
          ),
        );
    }
  }

  Future<Response<Result<Recipe>>> queryRecipe(String id) {
    return Future.value(
      Response(
        http.Response(
          'Dummy',
          200,
          request: null,
        ),
        Success<Recipe>(_currentRecipes1.recipes.first),
      ),
    );
  }
}

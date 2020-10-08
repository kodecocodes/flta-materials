
import 'package:http/http.dart';

const String apiKey = 'c517bfd8ff8dba49d18ae70ad84b7d23';
const String apiId = '00691437';
const String APIURL = 'https://api.edamam.com/search';


class RecipeService {
  Future<dynamic> getRecipes(String query, int from, int to) async {
    var recipeData = await getData('$APIURL?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    return recipeData;
  }

  Future getData(String url) async {
    print('Calling uri: $url');
    Response response = await get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

}
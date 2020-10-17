import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fooderlich/models/models.dart';

class MockFooderlichService {
  Future<List<ExploreRecipe>> getTodayRecipes() async {
    String dataString = await _loadAsset('assets/sample_data/sample_explore_recipes.json');
    Map<String, dynamic> json = jsonDecode(dataString);

    if (json['recipes'] != null) {
      var recipes = new List<ExploreRecipe>();
      json['recipes'].forEach((v) {
        recipes.add(new ExploreRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  Future<List<Post>> getFriendFeed() async {
    String dataString = await _loadAsset('assets/sample_data/sample_friends_feed.json');
    Map<String, dynamic> json = jsonDecode(dataString);

    if (json['feed'] != null) {
      var posts = new List<Post>();
      json['feed'].forEach((v) {
        posts.add(new Post.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  Future<List<SimpleRecipe>> getRecipes() async {
    String dataString = await _loadAsset('assets/sample_data/sample_recipes.json');
    Map<String, dynamic> json = jsonDecode(dataString);

    if (json['recipes'] != null) {
      var recipes = new List<SimpleRecipe>();
      json['recipes'].forEach((v) {
        recipes.add(new SimpleRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}

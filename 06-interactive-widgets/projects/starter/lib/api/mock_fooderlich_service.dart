import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/models.dart';

// Mock recipe service that grabs sample json data to mock recipe request/response
class MockFooderlichService {
  // Batch request that gets both today recipes and friend's feed
  Future<ExploreData> getExploreData() async {
    var todayRecipes = await _getTodayRecipes();
    var friendPosts = await _getFriendFeed();

    return ExploreData(todayRecipes, friendPosts);
  }

  // Get sample explore recipes json to display in ui
  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    // Simulate api request wait time
    await Future.delayed(Duration(milliseconds: 300));
    // Load json from file system
    String dataString = await _loadAsset(
      'assets/sample_data/sample_explore_recipes.json',
    );
    // Decode to json
    Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each recipe and convert json to ExploreRecipe object.
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

  // Get the sample friend json posts to display in ui
  Future<List<Post>> _getFriendFeed() async {
    // Simulate api request wait time
    await Future.delayed(Duration(milliseconds: 300));
    // Load json from file system
    String dataString =
        await _loadAsset('assets/sample_data/sample_friends_feed.json');
    // Decode to json
    Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each post and convert json to Post object.
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

  // Get the sample recipe json to display in ui
  Future<List<SimpleRecipe>> getRecipes() async {
    // Simulate api request wait time
    await Future.delayed(Duration(milliseconds: 300));
    // Load json from file system
    String dataString =
        await _loadAsset('assets/sample_data/sample_recipes.json');
    // Decode to json
    Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each recipe and convert json to SimpleRecipe object.
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

  // Loads sample json data from file system
  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}

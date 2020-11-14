/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
    await Future.delayed(Duration(milliseconds: 1000));
    // Load json from file system
    String dataString = await _loadAsset('assets/sample_data/sample_explore_recipes.json');
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
    await Future.delayed(Duration(milliseconds: 1000));
    // Load json from file system
    String dataString = await _loadAsset('assets/sample_data/sample_friends_feed.json');
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
    await Future.delayed(Duration(milliseconds: 1000));
    // Load json from file system
    String dataString = await _loadAsset('assets/sample_data/sample_recipes.json');
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

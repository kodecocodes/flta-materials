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

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class APIRecipeQuery {

  factory APIRecipeQuery.fromJson(Map<String, dynamic> json) => _$APIRecipeQueryFromJson(json);
  Map<String, dynamic> toJson() => _$APIRecipeQueryToJson(this);
  @JsonKey(name: 'q')
  String query;
  int from;
  int to;
  bool more;
  int count;
  List<APIHits> hits;

  APIRecipeQuery({
    @required this.query,
    @required this.from,
    @required this.to,
    @required this.more,
    @required this.count,
    @required this.hits,
  });
}

@JsonSerializable()
class APIHits {
  APIRecipe recipe;

  APIHits({
    @required this.recipe,
  });

  factory APIHits.fromJson(Map<String, dynamic> json) => _$APIHitsFromJson(json);
  Map<String, dynamic> toJson() => _$APIHitsToJson(this);
}

@JsonSerializable()
class APIRecipe {
  String label;
  String image;
  String url;
  List<APIIngredients> ingredients;
  double calories;
  double totalWeight;
  double totalTime;

  APIRecipe({
    @required this.label,
    @required this.image,
    @required this.url,
    @required this.ingredients,
    @required this.calories,
    @required this.totalWeight,
    @required this.totalTime,
  });
  factory APIRecipe.fromJson(Map<String, dynamic> json) => _$APIRecipeFromJson(json);
  Map<String, dynamic> toJson() => _$APIRecipeToJson(this);
}

String getCalories(double calories) {
  if (calories == null) {
    return "0 KCAL";
  }
  return calories.floor().toString() + ' KCAL';
}

String getWeight(double weight) {
  if (weight == null) {
    return '0g';
  }
  return weight.floor().toString() + 'g';
}

@JsonSerializable()
class APIIngredients {
  @JsonKey(name: 'text')
  String name;
  double weight;

  APIIngredients({
    @required this.name,
    @required this.weight,
  });
  factory APIIngredients.fromJson(Map<String, dynamic> json) => _$APIIngredientsFromJson(json);
  Map<String, dynamic> toJson() => _$APIIngredientsToJson(this);
}

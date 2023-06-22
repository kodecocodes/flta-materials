import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ingredient.dart';

part 'recipe.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Recipe extends Equatable {
  int? id;
  final String? label;
  final String? image;
  final String? description;
  bool bookmarked = false;

  List<Ingredient> ingredients;

  Recipe({
    this.id,
    this.label,
    this.image,
    this.description,
    this.bookmarked = false,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [
        label,
        image,
        description,
        bookmarked,
        ingredients,
      ];

  // Create a Recipe from JSON data
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  // Convert our Recipe to JSON to make it easier
  // when we store it in the database
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ingredient.dart';

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

}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';

part 'ingredient.g.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient(
      {int? id,
        int? recipeId,
        String? name,
        double? amount,
        double? weight}) = _Ingredient;

  // Create a Ingredient from JSON data
  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

}

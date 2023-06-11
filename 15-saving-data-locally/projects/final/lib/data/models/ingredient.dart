import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Ingredient extends Equatable {
  int? id;
  int? recipeId;
  final String? name;
  final double? amount;
  final double? weight;

  Ingredient({
    this.id,
    this.recipeId,
    this.name,
    this.amount,
    this.weight,
  });

  @override
  List<Object?> get props => [
        recipeId,
        name,
        amount,
        weight,
      ];

  // Create a Ingredient from JSON data
  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);


  // Convert our Ingredient to JSON to make it
  // easier when we store it in the database
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

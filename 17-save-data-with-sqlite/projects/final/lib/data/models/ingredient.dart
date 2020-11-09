import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  int id;
  int recipeId;
  final String name;
  final double weight;

  Ingredient({this.id, this.recipeId, this.name, this.weight});

  @override
  List<Object> get props => [recipeId, name, weight];

  // Create a Recipe from JSON data
  factory Ingredient.fromJson(Map<String, dynamic> json) => new Ingredient(
    id: json["_id"],
    recipeId: json["recipeId"],
    name: json["name"],
    weight: json["weight"],
  );

  // Convert our Note to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() => {
    "_id": id,
    "recipeId": recipeId,
    "name": name,
    "weight": weight,
  };
}
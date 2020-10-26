import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final int id;
  int recipeId;
  final String name;
  final double weight;

  Ingredient({this.id, this.recipeId, this.name, this.weight});

  @override
  List<Object> get props => [recipeId, name, weight];
}

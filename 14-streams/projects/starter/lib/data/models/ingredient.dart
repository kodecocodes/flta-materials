import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Ingredient extends Equatable {
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  Ingredient({this.id, this.recipeId, this.name, this.weight});

  @override
  List<Object?> get props => [recipeId, name, weight];
}

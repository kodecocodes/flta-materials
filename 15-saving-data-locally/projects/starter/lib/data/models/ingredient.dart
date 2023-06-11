import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

 }

import 'package:equatable/equatable.dart';

import 'ingredient.dart';

class Recipe extends Equatable {
  final int id;
  final String label;
  final String image;
  final String url;
  List<Ingredient> ingredients;

  Recipe({this.id, this.label, this.image, this.url});

  @override
  List<Object> get props => [label, image, url];
}

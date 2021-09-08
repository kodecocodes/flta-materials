part of 'explore_recipe.dart';

class Ingredients {
  String imageUrl;
  String title;
  String source;

  Ingredients({this.imageUrl, this.title, this.source});

  Ingredients.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    source = json['source'];
  }
}

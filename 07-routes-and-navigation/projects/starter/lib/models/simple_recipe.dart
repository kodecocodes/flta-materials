class SimpleRecipe {
  String id;
  String dishImage;
  String title;
  String duration;
  String source;
  List<String> information;

  SimpleRecipe(
    this.id,
    this.dishImage,
    this.title,
    this.duration,
    this.source,
    this.information,
  );

  SimpleRecipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dishImage = json['dishImage'];
    title = json['title'];
    duration = json['duration'];
    source = json['source'];
    information = json['information'].cast<String>();
  }
}

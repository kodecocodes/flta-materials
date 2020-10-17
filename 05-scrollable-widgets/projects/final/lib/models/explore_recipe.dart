part 'ingredient.dart';
part 'instruction.dart';


class RecipeCardType {
  static final String card1 = "card1";
  static final String card2 = "card2";
  static final String card3 = "card3";
}

class ExploreRecipe {
  String cardType;
  String title;
  String subtitle;
  String backgroundImage;
  String backgroundImageSource;
  String message;
  String chef;
  String role;
  String chefImage;
  int durationInMinutes;
  String dietType;
  int calories;
  List<String> tags;
  String description;
  String source;
  List<Ingredients> ingredients;
  List<Instruction> instructions;

  ExploreRecipe(
      {this.cardType,
      this.title,
      this.subtitle,
      this.backgroundImage,
      this.backgroundImageSource,
      this.message,
      this.chef,
      this.role,
      this.chefImage,
      this.durationInMinutes,
      this.dietType,
      this.calories,
      this.tags,
      this.description,
      this.source,
      this.ingredients,
      this.instructions});

  ExploreRecipe.fromJson(Map<String, dynamic> json) {
    cardType = json['cardType'];
    title = json['title'];
    subtitle = json['subtitle'];
    backgroundImage = json['backgroundImage'];
    backgroundImageSource = json['backgroundImageSource'];
    message = json['message'];
    chef = json['chef'];
    role = json['role'];
    chefImage = json['chefImage'];
    durationInMinutes = json['durationInMinutes'];
    dietType = json['dietType'];
    calories = json['calories'];
    tags = json['tags'].cast<String>();
    description = json['description'];
    source = json['source'];
    if (json['ingredients'] != null) {
      ingredients = new List<Ingredients>();
      json['ingredients'].forEach((v) {
        ingredients.add(new Ingredients.fromJson(v));
      });
    }
    if (json['instructions'] != null) {
      instructions = new List<Instruction>();
      json['instructions'].forEach((v) {
        instructions.add(new Instruction.fromJson(v));
      });
    }
  }
}


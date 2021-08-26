part 'ingredient.dart';
part 'instruction.dart';

class RecipeCardType {
  static const card1 = 'card1';
  static const card2 = 'card2';
  static const card3 = 'card3';
}

class ExploreRecipe {
  String id;
  String cardType;
  String title;
  String subtitle;
  String backgroundImage;
  String backgroundImageSource;
  String message;
  String authorName;
  String role;
  String profileImage;
  int durationInMinutes;
  String dietType;
  int calories;
  List<String> tags;
  String description;
  String source;
  List<Ingredients> ingredients;
  List<Instruction> instructions;

  ExploreRecipe(
      {required this.id,
      required this.cardType,
      required this.title,
      required this.subtitle,
      required this.backgroundImage,
      required this.backgroundImageSource,
      required this.message,
      required this.authorName,
      required this.role,
      required this.profileImage,
      required this.durationInMinutes,
      required this.dietType,
      required this.calories,
      required this.tags,
      required this.description,
      required this.source,
      required this.ingredients,
      required this.instructions});

  factory ExploreRecipe.fromJson(Map<String, dynamic> json) {
    final ingredients = <Ingredients>[];
    final instructions = <Instruction>[];

    if (json['ingredients'] != null) {
      json['ingredients'].forEach((v) {
        ingredients.add(Ingredients.fromJson(v));
      });
    }


    if (json['instructions'] != null) {
      json['instructions'].forEach((v) {
        instructions.add(Instruction.fromJson(v));
      });
    }

    return ExploreRecipe(
        id: json['id'] ?? '',
        cardType: json['cardType'] ?? '',
        title: json['title'] ?? '',
        subtitle: json['subtitle'] ?? '',
        backgroundImage: json['backgroundImage'] ?? '',
        backgroundImageSource: json['backgroundImageSource'] ?? '',
        message: json['message'] ?? '',
        authorName: json['authorName'] ?? '',
        role: json['role'] ?? '',
        profileImage: json['profileImage'] ?? '',
        durationInMinutes: json['durationInMinutes'] ?? 0,
        dietType: json['dietType'] ?? '',
        calories: json['calories'] ?? 0,
        tags: json['tags'].cast<String>() ?? [],
        description: json['description'] ?? '',
        source: json['source'] ?? '',
        ingredients: ingredients,
        instructions: instructions);
  }
}

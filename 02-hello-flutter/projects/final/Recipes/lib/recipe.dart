class Ingredient {
  double quantity;
  String measure;
  String name;

  Ingredient(this.quantity, this.measure, this.name) {}
}

class Recipe {
  String label;
  String imageUrl;

  int servings;
  List<Ingredient> ingredients;

  Recipe(this.label, this.imageUrl, this.servings, this.ingredients) {}
}

/*
  static List<Recipe> samples = [
    Recipe("Spaghetti and Meatballs", "assets/2126711929_ef763de2b3_w.jpg", 4, [Ingredient(1, "box", "Spaghetti"), Ingredient(4, "", "Frozen Meatballs"), Ingredient(0.5, "jar", "sauce")]), //"Joe's of Westlake - Dinner" by BrownGuacamole is licensed under CC BY-ND 2.0
    Recipe("Tomato Soup", "assets/27729023535_a57606c1be.jpg", 4, [Ingredient(1, "can", "Tomato Soup")]), //"Roasted Tomato Paleo Soup" by paleogrubs is licensed under CC BY 2.0
    Recipe("Grilled Cheese", "assets/3187380632_5056654a19_b.jpg", 1, [Ingredient(2, "slices", "Cheese"), Ingredient(2, "slices", "Bread")]), //"IMG_0562" by joelogon is licensed under CC BY-SA 2.0
    Recipe("Chocolate Chip Cookies", "assets/15992102771_b92f4cc00a_b.jpg", 24, [Ingredient(4, "cups", "flour"), Ingredient(2, "cups", "sugar"), Ingredient(0.5, "cups", "chocolate chips")]) //"Chocolate chip cookies" by Helena Jacoba is licensed under CC BY 2.0
  ];

 */
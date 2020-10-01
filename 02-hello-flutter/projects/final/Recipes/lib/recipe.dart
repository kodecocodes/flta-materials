class Recipe {
  String label;
  String imageUrl;

  Recipe(this.label, this.imageUrl) {}

  static List<Recipe> samples = [
    Recipe("Spaghetti and Meatballs", "assets/2126711929_ef763de2b3_w.jpg"),
    Recipe("Tomato Soup", "assets/27729023535_a57606c1be.jpg"),
    Recipe("Grilled Cheese", "assets/3187380632_5056654a19_b.jpg"),
    Recipe("Chocolate Chip Cookies", "assets/15992102771_b92f4cc00a_b.jpg"),
    Recipe("Taco Salad", "assets/15992102771_b92f4cc00a_b.jpg"),
    Recipe("Hawaiian Pizza", "assets/15992102771_b92f4cc00a_b.jpg"),
  ];
}
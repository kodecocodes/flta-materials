class FoodCategory {
  String name;
  int numberOfRestaurants;
  String imageUrl;

  FoodCategory(
    this.name,
    this.numberOfRestaurants,
    this.imageUrl,
  );
}

List<FoodCategory> categories = [
  FoodCategory('Dessert', 16, 'assets/categories/dessert.png'),
  FoodCategory('Vegetarian', 20, 'assets/categories/vegetarian.png'),
  FoodCategory('Burger', 21, 'assets/categories/burger.png'),
  FoodCategory('Asian', 16, 'assets/categories/asian.png'),
  FoodCategory('Italian', 18, 'assets/categories/italian.png'),
  FoodCategory('Mexican', 15, 'assets/categories/mexican.png'),
  FoodCategory('Seafood', 14, 'assets/categories/seafood.png'),
  FoodCategory('Pizza', 19, 'assets/categories/pizza.png'),
  FoodCategory('Sushi', 15, 'assets/categories/sushi.png'),
  FoodCategory('Coffee', 22, 'assets/categories/coffee.png'),
  FoodCategory('Fast Food', 23, 'assets/categories/fast_food.png'),
  FoodCategory('Salad', 18, 'assets/categories/salad.png'),
];

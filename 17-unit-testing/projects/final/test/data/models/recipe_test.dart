import 'package:recipes/data/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Recipe', () {
    test('can instantiate', () {
      // Arrange
      late Recipe recipe;

      // Act
      recipe = const Recipe();

      // Assert
      expect(recipe, isNotNull);
    });
    test('default string properties should be null', () {
      // Arrange
      late Recipe recipe;

      // Act
      recipe = const Recipe();

      // Assert
      expect(recipe.id, isNull);
      expect(recipe.label, isNull);
      expect(recipe.image, isNull);
      expect(recipe.description, isNull);
      expect(recipe.bookmarked, isNotNull);
      expect(recipe.ingredients, isNotNull);
    });
    test('default `bookmarked` should be false', () {
      // Arrange
      late Recipe recipe;

      // Act
      recipe = const Recipe();

      // Assert
      expect(recipe.ingredients, isNotNull);
      expect(recipe.bookmarked, isFalse);
    });
    test('default `ingredients` should be an empty list', () {
      // Arrange
      late Recipe recipe;

      // Act
      recipe = const Recipe();

      // Assert
      expect(recipe.ingredients, isNotNull);
      expect(recipe.ingredients, isEmpty);
    });
    test('can receive parameters', () {
      // Arrange
      late Recipe recipe;
      const id = 123;
      const label = 'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs';
      const image = 'https://spoonacular.com/recipeImages/716429-556x370.jpg';
      const description =
          'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire. One portion of this dish contains approximately <b>19g of protein </b>,  <b>20g of fat </b>, and a total of  <b>584 calories </b>. For  <b>\$1.63 per serving </b>, this recipe  <b>covers 23% </b> of your daily requirements of vitamins and minerals. This recipe serves 2. It is brought to you by fullbellysisters.blogspot.com. 209 people were glad they tried this recipe. A mixture of scallions, salt and pepper, white wine, and a handful of other ingredients are all it takes to make this recipe so scrumptious. From preparation to the plate, this recipe takes approximately  <b>45 minutes </b>. All things considered, we decided this recipe  <b>deserves a spoonacular score of 83% </b>. This score is awesome. If you like this recipe, take a look at these similar recipes: <a href="https://spoonacular.com/recipes/cauliflower-gratin-with-garlic-breadcrumbs-318375">Cauliflower Gratin with Garlic Breadcrumbs</a>, < href="https://spoonacular.com/recipes/pasta-with-cauliflower-sausage-breadcrumbs-30437">Pasta With Cauliflower, Sausage, & Breadcrumbs</a>, and <a href="https://spoonacular.com/recipes/pasta-with-roasted-cauliflower-parsley-and-breadcrumbs-30738">Pasta With Roasted Cauliflower, Parsley, And Breadcrumbs</a>.';
      const bookmarked = true;
      const ingredients = [
        Ingredient(
          id: 1123,
          recipeId: 123,
          name: 'Pasta',
          amount: 1.0,
        ),
        Ingredient(
          id: 1124,
          recipeId: 123,
          name: 'Garlic',
          amount: 1.0,
        ),
        Ingredient(
          id: 1125,
          recipeId: 123,
          name: 'Breadcrumbs',
          amount: 5.0,
        ),
      ];

      // Act
      recipe = const Recipe(
        id: id,
        label: label,
        image: image,
        description: description,
        bookmarked: bookmarked,
        ingredients: ingredients,
      );

      // Assert
      expect(recipe.id, equals(id));
      expect(recipe.label, equals(label));
      expect(recipe.image, equals(image));
      expect(recipe.description, equals(description));
      expect(recipe.bookmarked, equals(bookmarked));
      expect(recipe.ingredients, equals(ingredients));
    });
    test('can instantiate from JSON', () {
      // Arrange
      late Recipe recipe;
      final jsonMap = <String, dynamic>{
        'id': 123,
        'label': 'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs',
        'image': 'https://spoonacular.com/recipeImages/716429-556x370.jpg',
        'description':
            'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire. One portion of this dish contains approximately <b>19g of protein </b>,  <b>20g of fat </b>, and a total of  <b>584 calories </b>. For  <b>\$1.63 per serving </b>, this recipe  <b>covers 23% </b> of your daily requirements of vitamins and minerals. This recipe serves 2. It is brought to you by fullbellysisters.blogspot.com. 209 people were glad they tried this recipe. A mixture of scallions, salt and pepper, white wine, and a handful of other ingredients are all it takes to make this recipe so scrumptious. From preparation to the plate, this recipe takes approximately  <b>45 minutes </b>. All things considered, we decided this recipe  <b>deserves a spoonacular score of 83% </b>. This score is awesome. If you like this recipe, take a look at these similar recipes: <a href="https://spoonacular.com/recipes/cauliflower-gratin-with-garlic-breadcrumbs-318375">Cauliflower Gratin with Garlic Breadcrumbs</a>, < href="https://spoonacular.com/recipes/pasta-with-cauliflower-sausage-breadcrumbs-30437">Pasta With Cauliflower, Sausage, & Breadcrumbs</a>, and <a href="https://spoonacular.com/recipes/pasta-with-roasted-cauliflower-parsley-and-breadcrumbs-30738">Pasta With Roasted Cauliflower, Parsley, And Breadcrumbs</a>.',
        'bookmarked': true,
        'ingredients': [
          <String, dynamic>{
            'id': 1123,
            'recipeId': 123,
            'name': 'Pasta',
            'weight': 250.0,
            'amount': 1,
          },
          <String, dynamic>{
            'id': 1124,
            'recipeId': 123,
            'name': 'Garlic',
            'weight': 5.0,
            'amount': 1,
          },
          <String, dynamic>{
            'id': 1125,
            'recipeId': 123,
            'name': 'Breadcrumbs',
            'weight': 75.0,
            'amount': 5,
          }
        ],
      };
      const id = 123;
      const label = 'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs';
      const image = 'https://spoonacular.com/recipeImages/716429-556x370.jpg';
      const description =
          'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire. One portion of this dish contains approximately <b>19g of protein </b>,  <b>20g of fat </b>, and a total of  <b>584 calories </b>. For  <b>\$1.63 per serving </b>, this recipe  <b>covers 23% </b> of your daily requirements of vitamins and minerals. This recipe serves 2. It is brought to you by fullbellysisters.blogspot.com. 209 people were glad they tried this recipe. A mixture of scallions, salt and pepper, white wine, and a handful of other ingredients are all it takes to make this recipe so scrumptious. From preparation to the plate, this recipe takes approximately  <b>45 minutes </b>. All things considered, we decided this recipe  <b>deserves a spoonacular score of 83% </b>. This score is awesome. If you like this recipe, take a look at these similar recipes: <a href="https://spoonacular.com/recipes/cauliflower-gratin-with-garlic-breadcrumbs-318375">Cauliflower Gratin with Garlic Breadcrumbs</a>, < href="https://spoonacular.com/recipes/pasta-with-cauliflower-sausage-breadcrumbs-30437">Pasta With Cauliflower, Sausage, & Breadcrumbs</a>, and <a href="https://spoonacular.com/recipes/pasta-with-roasted-cauliflower-parsley-and-breadcrumbs-30738">Pasta With Roasted Cauliflower, Parsley, And Breadcrumbs</a>.';
      const bookmarked = true;
      const ingredients = [
        Ingredient(
          id: 1123,
          recipeId: 123,
          name: 'Pasta',
          amount: 1.0,
        ),
        Ingredient(
          id: 1124,
          recipeId: 123,
          name: 'Garlic',
          amount: 1.0,
        ),
        Ingredient(
          id: 1125,
          recipeId: 123,
          name: 'Breadcrumbs',
          amount: 5.0,
        ),
      ];

      // Act
      recipe = Recipe.fromJson(jsonMap);

      // Assert
      expect(recipe.id, equals(id));
      expect(recipe.label, equals(label));
      expect(recipe.image, equals(image));
      expect(recipe.description, equals(description));
      expect(recipe.bookmarked, equals(bookmarked));
      expect(recipe.ingredients, equals(ingredients));
    });
  });
}

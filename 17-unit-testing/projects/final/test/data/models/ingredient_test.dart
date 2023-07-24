import 'package:recipes/data/models/ingredient.dart';
import 'package:test/test.dart';

void main() {
  group('Ingredient', () {
    test('can instantiate', () {
      // Arrange
      late Ingredient ingredient;

      // Act
      ingredient = const Ingredient();

      // Assert
      expect(ingredient, isNotNull);
    });
    test('default properties should be null', () {
      // Arrange
      late Ingredient ingredient;

      // Act
      ingredient = const Ingredient();

      // Assert
      expect(ingredient.id, isNull);
      expect(ingredient.recipeId, isNull);
      expect(ingredient.name, isNull);
      expect(ingredient.amount, isNull);
      expect(ingredient.weight, isNull);
    });
    test('can receive parameters', () {
      // Arrange
      late Ingredient ingredient;
      const id = 123;
      const recipeId = 54321;
      const name = 'Parmesan Cheese';
      const amount = 1.0;
      const weight = 50.0;

      // Act
      ingredient = const Ingredient(
        id: id,
        recipeId: recipeId,
        name: name,
        amount: amount,
        weight: weight,
      );

      // Assert
      expect(ingredient.id, equals(id));
      expect(ingredient.recipeId, equals(recipeId));
      expect(ingredient.name, equals(name));
      expect(ingredient.amount, equals(amount));
      expect(ingredient.weight, equals(weight));
    });
    test('can instantiate from JSON', () {
      // Arrange
      late Ingredient ingredient;
      final jsonMap = <String, dynamic>{
        'id': 123,
        'recipeId': 54321,
        'name': 'Parmesan Cheese',
        'weight': 50.0,
        'amount': 1,
      };
      const id = 123;
      const recipeId = 54321;
      const name = 'Parmesan Cheese';
      const amount = 1.0;
      const weight = 50.0;

      // Act
      ingredient = Ingredient.fromJson(jsonMap);

      // Assert
      expect(ingredient.id, equals(id));
      expect(ingredient.recipeId, equals(recipeId));
      expect(ingredient.name, equals(name));
      expect(ingredient.amount, equals(amount));
      expect(ingredient.weight, equals(weight));
    });
  });
}

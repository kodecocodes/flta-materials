import 'package:flutter/foundation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes/data/database/db_repository.dart';
import 'package:recipes/data/models/models.dart';
import 'package:test/test.dart';

import 'db_repository_test.mocks.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<DBRepository>()])
void main() {
  final randomIngredients = [
    const Ingredient(
      id: 1123,
      recipeId: 123,
      name: 'Pasta',
      amount: 1.0,
      weight: 250.0,
    ),
    const Ingredient(
      id: 1124,
      recipeId: 123,
      name: 'Garlic',
      amount: 1.0,
      weight: 5.0,
    ),
    const Ingredient(
      id: 1125,
      recipeId: 123,
      name: 'Breadcrumbs',
      amount: 5.0,
      weight: 75.0,
    ),
  ];

  final randomRecipes = [
    Recipe(
      id: 123,
      label: 'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs',
      image: 'https://spoonacular.com/recipeImages/716429-556x370.jpg',
      description:
          'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire. One portion of this dish contains approximately <b>19g of protein </b>,  <b>20g of fat </b>, and a total of  <b>584 calories </b>. For  <b>\$1.63 per serving </b>, this recipe  <b>covers 23% </b> of your daily requirements of vitamins and minerals. This recipe serves 2. It is brought to you by fullbellysisters.blogspot.com. 209 people were glad they tried this recipe. A mixture of scallions, salt and pepper, white wine, and a handful of other ingredients are all it takes to make this recipe so scrumptious. From preparation to the plate, this recipe takes approximately  <b>45 minutes </b>. All things considered, we decided this recipe  <b>deserves a spoonacular score of 83% </b>. This score is awesome. If you like this recipe, take a look at these similar recipes: <a href="https://spoonacular.com/recipes/cauliflower-gratin-with-garlic-breadcrumbs-318375">Cauliflower Gratin with Garlic Breadcrumbs</a>, < href="https://spoonacular.com/recipes/pasta-with-cauliflower-sausage-breadcrumbs-30437">Pasta With Cauliflower, Sausage, & Breadcrumbs</a>, and <a href="https://spoonacular.com/recipes/pasta-with-roasted-cauliflower-parsley-and-breadcrumbs-30738">Pasta With Roasted Cauliflower, Parsley, And Breadcrumbs</a>.',
      bookmarked: true,
      ingredients: randomIngredients,
    ),
  ];

  group('DBRepository', () {
    test('can instantiate', () {
      // Arrange
      late DBRepository dbRepository;

      // Act
      dbRepository = DBRepository();

      // Assert
      expect(dbRepository, isNotNull);
    });
    test('can get initialized', () {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.init()).thenAnswer((_) async => {});

      // Act
      mockRep.init();

      // Assert
      verify(mockRep.init()).called(1);
    });
    test('can close', () {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.close()).thenAnswer((_) => {});

      // Act
      mockRep.close();

      // Assert
      verify(mockRep.close()).called(1);
    });
    test('can findAllRecipes', () async {
      // Arrange
      final mockRep = MockDBRepository();

      when(mockRep.findAllRecipes()).thenAnswer((_) async => randomRecipes);

      // Act
      final result = await mockRep.findAllRecipes();

      // Assert
      verify(mockRep.findAllRecipes()).called(1);
      expect(listEquals(result, randomRecipes), isTrue);
    });
    test('can watchAllRecipes', () {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.watchAllRecipes()).thenAnswer((_) => Stream.fromIterable([
            [],
            randomRecipes,
          ]));
      // Act
      final result = mockRep.watchAllRecipes();

      // Assert
      expect(
          result,
          emitsInOrder([
            [],
            randomRecipes,
          ]));
    });
    test('can watchAllIngredients', () {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.watchAllIngredients())
          .thenAnswer((_) => Stream.fromIterable([
                randomIngredients.sublist(2),
                randomIngredients.sublist(1),
                randomIngredients,
              ]));
      // Act
      final result = mockRep.watchAllIngredients();

      // Assert
      expect(
          result,
          emitsInOrder([
            randomIngredients.sublist(2),
            randomIngredients.sublist(1),
            randomIngredients,
          ]));
    });
    test('can findRecipeById', () async {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.findRecipeById(any)).thenAnswer(
        (_) async => randomRecipes.first,
      );

      // Act
      final result = await mockRep.findRecipeById(5);

      // Assert
      verify(mockRep.findRecipeById(any)).called(1);
      expect(result, randomRecipes.first);
    });
    test('can findAllIngredients', () async {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.findAllIngredients()).thenAnswer(
        (_) async => randomIngredients,
      );

      // Act
      final result = await mockRep.findAllIngredients();

      // Assert
      verify(mockRep.findAllIngredients()).called(1);
      expect(listEquals(result, randomIngredients), isTrue);
    });
    test('can findRecipeIngredients', () async {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.findRecipeIngredients(any)).thenAnswer(
        (_) async => randomIngredients,
      );

      // Act
      final result = await mockRep.findRecipeIngredients(5);

      // Assert
      verify(mockRep.findRecipeIngredients(any)).called(1);
      expect(listEquals(result, randomIngredients), isTrue);
    });
    test('can insertRecipe', () async {
      // Arrange
      final mockRep = MockDBRepository();
      const randomIdx = 3;
      when(mockRep.insertRecipe(any)).thenAnswer(
        (_) async => randomIdx,
      );

      // Act
      final result = await mockRep.insertRecipe(randomRecipes.first);

      // Assert
      verify(mockRep.insertRecipe(any)).called(1);
      expect(result, equals(randomIdx));
    });
    test('can insertIngredients', () async {
      // Arrange
      final mockRep = MockDBRepository();
      final randomIndexes = randomIngredients.indexed
          .map((indexedIngredient) => indexedIngredient.$1)
          .toList();
      when(mockRep.insertIngredients(any)).thenAnswer(
        (_) async => randomIndexes,
      );

      // Act
      final result = await mockRep.insertIngredients(randomIngredients);

      // Assert
      verify(mockRep.insertIngredients(any)).called(1);
      expect(listEquals(result, randomIndexes), isTrue);
    });
    test('can deleteRecipe', () async {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.deleteRecipe(any)).thenAnswer(
        (_) async => {},
      );

      // Act
      await mockRep.deleteRecipe(randomRecipes.first);

      // Assert
      verify(mockRep.deleteRecipe(any)).called(1);
    });
    test('can deleteIngredient', () async {
      // Arrange
      final mockRep = MockDBRepository();
      const mockIngredient = Ingredient(
        id: 1125,
        recipeId: 123,
        name: 'Breadcrumbs',
        amount: 5.0,
        weight: 75.0,
      );
      when(mockRep.deleteIngredient(any)).thenAnswer((_) async => {});

      // Act
      await mockRep.deleteIngredient(mockIngredient);

      // Assert
      verify(mockRep.deleteIngredient(any)).called(1);
    });
    test('can deleteIngredients', () async {
      // Arrange
      final mockRep = MockDBRepository();
      when(mockRep.deleteIngredients(any)).thenAnswer((_) async => {});

      // Act
      await mockRep.deleteIngredients(randomIngredients);

      // Assert
      verify(mockRep.deleteIngredients(any)).called(1);
    });
    test('can deleteRecipeIngredients', () async {
      // Arrange
      final mockRep = MockDBRepository();

      when(mockRep.deleteRecipeIngredients(any)).thenAnswer((_) async => {});

      // Act
      await mockRep.deleteRecipeIngredients(5);

      // Assert
      verify(mockRep.deleteRecipeIngredients(any)).called(1);
    });
  });
}

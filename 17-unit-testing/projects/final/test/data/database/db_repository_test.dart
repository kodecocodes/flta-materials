import 'package:flutter/foundation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes/data/database/db_repository.dart';
import 'package:recipes/data/database/recipe_db.dart';
import 'package:recipes/data/models/models.dart';
import 'package:test/test.dart';

import 'db_repository_test.mocks.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([
  MockSpec<RecipeDatabase>(),
  MockSpec<RecipeDao>(),
  MockSpec<IngredientDao>(),
])
void main() {
  final mockDb = MockRecipeDatabase();
  final mockIngredientDao = MockIngredientDao();
  final mockRecipeDao = MockRecipeDao();

  when(mockDb.ingredientDao).thenReturn(mockIngredientDao);
  when(mockDb.recipeDao).thenReturn(mockRecipeDao);

  final randomIngredients = [
    const Ingredient(
      id: 1123,
      recipeId: 123,
      name: 'Pasta',
      amount: 1.0,
    ),
    const Ingredient(
      id: 1124,
      recipeId: 123,
      name: 'Garlic',
      amount: 1.0,
    ),
    const Ingredient(
      id: 1125,
      recipeId: 123,
      name: 'Breadcrumbs',
      amount: 5.0,
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
      dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );

      // Assert
      expect(dbRepository, isNotNull);
    });
    test('can get initialized without crashing', () async {
      // Arrange
      final dbRepository = DBRepository();

      // Act
      await dbRepository.init();

      // Assert
      // Does not crash
    });
    test('can close', () async {
      // Arrange
      when(mockDb.close()).thenAnswer((_) async => {});
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();

      // Act
      dbRepository.close();

      // Assert
      verify(mockDb.close()).called(1);
    });
    test('can findAllRecipes', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.findRecipeIngredients(any)).thenAnswer(
        (_) async => randomIngredients
            .map(
              (e) => DbIngredientData(
                id: e.id!,
                recipeId: e.recipeId!,
                name: e.name!,
                amount: e.amount!,
              ),
            )
            .toList(),
      );
      when(mockRecipeDao.findAllRecipes()).thenAnswer(
        (_) async => randomRecipes
            .map(
              (e) => DbRecipeData(
                id: e.id!,
                label: e.label!,
                image: e.image!,
                description: e.description!,
                bookmarked: e.bookmarked,
              ),
            )
            .toList(),
      );

      // Act
      final result = await dbRepository.findAllRecipes();

      // Assert
      verify(mockRecipeDao.findAllRecipes()).called(1);
      expect(listEquals(result, randomRecipes), isTrue);
    });
    test('can watchAllRecipes', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockRecipeDao.watchAllRecipes())
          .thenAnswer((_) => Stream.fromIterable([
                randomRecipes,
              ]));
      // Act
      final result = dbRepository.watchAllRecipes();

      // Assert
      expect(
          result,
          emitsInOrder([
            randomRecipes,
          ]));
    });
    test('can watchAllIngredients', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.watchAllIngredients()).thenAnswer(
        (_) => Stream.fromIterable(
          [
            randomIngredients
                .map(
                  (e) => DbIngredientData(
                    id: e.id!,
                    recipeId: e.recipeId!,
                    name: e.name!,
                    amount: e.amount!,
                  ),
                )
                .toList(),
          ],
        ),
      );
      // Act
      final result = dbRepository.watchAllIngredients();

      // Assert
      expect(
          result,
          emitsInOrder([
            randomIngredients,
          ]));
    });
    test('can findRecipeById', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.findRecipeIngredients(any)).thenAnswer(
        (_) async => randomIngredients
            .map(
              (e) => DbIngredientData(
                id: e.id!,
                recipeId: e.recipeId!,
                name: e.name!,
                amount: e.amount!,
              ),
            )
            .toList(),
      );
      when(mockRecipeDao.findRecipeById(any)).thenAnswer(
        (_) async => randomRecipes
            .map(
              (e) => DbRecipeData(
                id: e.id!,
                label: e.label!,
                image: e.image!,
                description: e.description!,
                bookmarked: e.bookmarked,
              ),
            )
            .toList(),
      );

      // Act
      final result = await dbRepository.findRecipeById(5);

      // Assert
      verify(mockIngredientDao.findRecipeIngredients(any)).called(1);
      verify(mockRecipeDao.findRecipeById(any)).called(1);
      expect(result, randomRecipes.first);
    });
    test('can findAllIngredients', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.findAllIngredients()).thenAnswer(
        (_) async => randomIngredients
            .map((e) => DbIngredientData(
                  id: e.id!,
                  recipeId: e.recipeId!,
                  name: e.name!,
                  amount: e.amount!,
                ))
            .toList(),
      );

      // Act
      final result = await dbRepository.findAllIngredients();

      // Assert
      verify(mockIngredientDao.findAllIngredients()).called(1);
      expect(listEquals(result, randomIngredients), isTrue);
    });
    test('can findRecipeIngredients', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.findRecipeIngredients(any)).thenAnswer(
        (_) async => randomIngredients
            .map((e) => DbIngredientData(
                  id: e.id!,
                  recipeId: e.recipeId!,
                  name: e.name!,
                  amount: e.amount!,
                ))
            .toList(),
      );

      // Act
      final result = await dbRepository.findRecipeIngredients(5);

      // Assert
      verify(mockIngredientDao.findRecipeIngredients(any)).called(1);
      expect(listEquals(result, randomIngredients), isTrue);
    });
    test('can insertRecipe', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      const randomIdx = 123;
      when(mockRecipeDao.insertRecipe(any)).thenAnswer(
        (_) async => randomIdx,
      );

      // Act
      final result = await dbRepository.insertRecipe(randomRecipes.first);

      // Assert
      verify(mockRecipeDao.insertRecipe(any)).called(1);
      expect(result, equals(randomIdx));
    });
    test('can insertIngredients', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.insertIngredient(any)).thenAnswer((inv) async =>
          randomIngredients
              .where((ing) =>
                  ing.name ==
                  (inv.positionalArguments.first as DbIngredientCompanion)
                      .name
                      .value)
              .first
              .id!);

      // Act
      final result = await dbRepository.insertIngredients(randomIngredients);

      // Assert
      final randomIdentifiers = randomIngredients
          .map((indexedIngredient) => indexedIngredient.id)
          .toList();
      verify(mockIngredientDao.insertIngredient(any))
          .called(randomIngredients.length);
      expect(listEquals(result, randomIdentifiers), isTrue);
    });
    test('can deleteRecipe', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.findRecipeIngredients(any)).thenAnswer(
        (_) async => randomIngredients
            .map((e) => DbIngredientData(
                  id: e.id!,
                  recipeId: e.recipeId!,
                  name: e.name!,
                  amount: e.amount!,
                ))
            .toList(),
      );
      when(mockRecipeDao.deleteRecipe(any)).thenAnswer(
        (_) async => {},
      );
      final recipe = randomRecipes.first;

      // Act
      await dbRepository.deleteRecipe(recipe);

      // Assert
      verify(mockIngredientDao.deleteIngredient(any))
          .called(recipe.ingredients.length);
      verify(mockRecipeDao.deleteRecipe(any)).called(1);
    });
    test('can deleteIngredient', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      const mockIngredient = Ingredient(
        id: 1125,
        recipeId: 123,
        name: 'Breadcrumbs',
        amount: 5.0,
      );
      when(mockIngredientDao.deleteIngredient(any)).thenAnswer((_) async => {});

      // Act
      await dbRepository.deleteIngredient(mockIngredient);

      // Assert
      verify(mockIngredientDao.deleteIngredient(any)).called(1);
    });
    test('can deleteIngredients', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();
      when(mockIngredientDao.deleteIngredient(any)).thenAnswer((_) async => {});

      // Act
      await dbRepository.deleteIngredients(randomIngredients);

      // Assert
      verify(mockIngredientDao.deleteIngredient(any))
          .called(randomIngredients.length);
    });
    test('can deleteRecipeIngredients', () async {
      // Arrange
      final dbRepository = DBRepository(
        recipeDatabase: mockDb,
      );
      await dbRepository.init();

      when(mockIngredientDao.findRecipeIngredients(any)).thenAnswer(
        (_) async => randomIngredients
            .map((e) => DbIngredientData(
                  id: e.id!,
                  recipeId: e.recipeId!,
                  name: e.name!,
                  amount: e.amount!,
                ))
            .toList(),
      );
      when(mockIngredientDao.deleteIngredient(any)).thenAnswer((_) async => {});

      // Act
      await dbRepository.deleteRecipeIngredients(123);

      // Assert
      verify(mockIngredientDao.findRecipeIngredients(any)).called(1);
      verify(mockIngredientDao.deleteIngredient(any))
          .called(randomIngredients.length);
    });
  });
}

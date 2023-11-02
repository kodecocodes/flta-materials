import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes/data/database/db_repository.dart';
import 'package:recipes/data/database/recipe_db.dart';
import 'package:recipes/data/models/models.dart';
import 'package:test/test.dart';

import 'db_repository_test.mocks.dart';

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
      expect(dbRepository.recipeDatabase, isNotNull);
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
      expect(result, equals(randomIngredients));
    });
  });
}

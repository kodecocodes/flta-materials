
import 'models/models.dart';

abstract class Repository {
  Stream<List<Recipe>> watchAllRecipes();

  Stream<List<Ingredient>> watchAllIngredients();

  Future<Recipe> findRecipeById(int id);

  Future<List<Ingredient>> findAllIngredients();

  Future<List<Ingredient>> findRecipeIngredients(int id);

  Future<String> insertRecipe(Recipe recipe);

  Future<List<String>> insertIngredients(List<Ingredient> ingredients);

  Future<void> deleteRecipe(Recipe recipe);

  Future<void> deleteIngredient(Ingredient ingredient);

  Future<void> deleteIngredients(List<Ingredient> ingredients);

  Future init();
  void close();

}
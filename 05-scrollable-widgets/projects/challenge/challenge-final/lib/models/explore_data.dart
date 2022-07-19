import 'models.dart';

class ExploreData {
  final List<ExploreRecipe> todayRecipes;
  final List<Post> friendPosts;

  ExploreData(
    this.todayRecipes,
    this.friendPosts,
  );
}

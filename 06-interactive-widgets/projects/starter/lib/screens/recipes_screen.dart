import 'package:flutter/material.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class RecipesScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: exploreService.getRecipes(),
        builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return RecipesGridView(recipes: snapshot.data ?? []);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/models/recipe.dart';
import '../../providers.dart';
import '../recipes/recipe_details.dart';
import '../widgets/bookmark_card.dart';

class Bookmarks extends ConsumerStatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _BookmarkState();
}

class _BookmarkState extends ConsumerState<Bookmarks> {
  List<Recipe> recipes = [];
  late Stream<List<Recipe>> recipeStream;

  @override
  void initState() {
    super.initState();
    final repository = ref.read(repositoryProvider.notifier);
    recipeStream = repository.watchAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBookmarks(context);
  }

  Widget _buildBookmarks(BuildContext context) {
    return StreamBuilder<List<Recipe>>(
      stream: recipeStream,
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          recipes = snapshot.data ?? [];
        }
        return SliverLayoutBuilder(
          builder: (BuildContext context, SliverConstraints constraints) {
            return SliverList.builder(
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return SizedBox(
                  height: 100,
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          label: 'Delete',
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          icon: Icons.delete,
                          onPressed: (context) {
                            deleteRecipe(recipe);
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          label: 'Delete',
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          icon: Icons.delete,
                          onPressed: (context) {
                            deleteRecipe(recipe);
                          },
                        ),
                      ],
                    ),
                    child: BookmarkCard(
                      recipe: recipe,
                      onPressed: (recipe) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RecipeDetails(
                                recipe: recipe.copyWith(bookmarked: true));
                          },
                        ));
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void deleteRecipe(Recipe recipe) {
    ref.read(repositoryProvider.notifier).deleteRecipe(recipe);
  }
}

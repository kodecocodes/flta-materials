import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../data/models/recipe.dart';
import '../../providers.dart';
import '../recipes/recipe_details.dart';

class Bookmarks extends ConsumerStatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _BookmarkState();
}

class _BookmarkState extends ConsumerState<Bookmarks> {
  List<Recipe> recipes = [];
  // TODO: Add Recipe Stream

  // TODO: Add initState

  @override
  Widget build(BuildContext context) {
    return _buildBookmarks(context);
  }

  Widget _buildBookmarks(BuildContext context) {
    // TODO: Replace with Stream
    final repository = ref.watch(repositoryProvider);
    recipes = repository.currentRecipes;
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
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetails(
                          recipe: recipe.copyWith(bookmarked: true),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: recipe.image ?? '',
                            height: 120,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(recipe.label ?? ''),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    // TODO: Add closing brackets
  }

 
  void deleteRecipe(Recipe recipe) {
    ref.read(repositoryProvider.notifier).deleteRecipe(recipe);
  }
}

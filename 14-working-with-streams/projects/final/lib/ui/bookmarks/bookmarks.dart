import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../data/repositories/repository.dart';
import '../../providers.dart';
import '../../data/models/recipe.dart';
import '../recipes/recipe_details.dart';

class Bookmarks extends ConsumerStatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _BookmarkState();
}

class _BookmarkState extends ConsumerState<Bookmarks> {
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return _buildBookmarks(context);
  }

  Widget _buildBookmarks(BuildContext context) {
    final repository = ref.watch(repositoryProvider);
    return StreamBuilder<List<Recipe>>(
      stream: repository.watchAllRecipes(),
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final recipes = snapshot.data ?? [];
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
                              deleteRecipe(
                                repository,
                                recipe,
                              );
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
                              deleteRecipe(
                                repository,
                                recipe,
                              );
                            },
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RecipeDetails(
                                  recipe: recipe.copyWith(bookmarked: true));
                            },
                          ));
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
        } else {
          return
            SliverFillRemaining(
              child: Center(
                child: Container(),
              ),
            );
        }
      },
    );
  }

  void deleteRecipe(Repository repository, Recipe recipe) async {
    repository.deleteRecipe(recipe);
    setState(() {});
  }
}

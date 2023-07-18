import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../data/models/recipe.dart';

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
    // TODO: Add Repository
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
                        // TODO Add Delete
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
                        // TODO Add Delete
                      },
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    // TODO: Add Push to Recipe Details Page
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
			  // TODO Replace with Cached Image
                          leading: Image.asset(
                            'assets/images/pizza_w700.png',
                            height: 200,
                            width: 200,
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
    // TODO: Add else here
  }

  // TODO: Add Delete Recipe
}

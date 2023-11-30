import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/recipe.dart';

typedef BookmarkPressed = void Function(Recipe recipe);

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    super.key,
    required this.recipe,
    required this.onPressed,
  });

  final Recipe recipe;
  final BookmarkPressed onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => onPressed(recipe),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Hero(
                tag: 'recipe-${recipe.id}',
                child: CachedNetworkImage(
                  imageUrl: recipe.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  recipe.label ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

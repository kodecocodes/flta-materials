import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/models/recipe.dart';
import 'theme/colors.dart';
import 'widgets/common.dart';

Widget recipeCard(Recipe recipe) {
  return Card(
    color: Colors.white,
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
      side: const BorderSide(
        color: borderColor,
        width: 1.0,
      ),
    ),
    child: Container(
      decoration: const BoxDecoration(color: cardBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 0.0),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    recipe.label ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/arrow_circle_right.svg',
                  semanticsLabel: 'Details',
                ),
                const SizedBox(
                  width: 20.0,
                ),
              ],
            ),
          ),
          sizedH8,
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0),
            ),
            child: Hero(
              tag: 'recipe-${recipe.id}',
              child: CachedNetworkImage(
                imageUrl: recipe.image ?? '',
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

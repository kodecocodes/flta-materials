import 'package:flutter/material.dart';

import 'circle_image.dart';
import 'fooderlich_theme.dart';

class AuthorCard extends StatelessWidget {
  // 1
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  // 2
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        // TODO 3: add alignment
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1
          Row(children: [
            CircleImage(
              imageProvider: imageProvider,
              imageRadius: 28,
            ),
            // 2
            const SizedBox(width: 8),
            // 3
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authorName,
                  style: FooderlichTheme.lightTextTheme.headline2,
                ),
                Text(
                  title,
                  style: FooderlichTheme.lightTextTheme.headline3,
                )
              ],
            ),
          ]),
          // TODO 2: add IconButton
          IconButton(
            // 4
            icon: const Icon(Icons.favorite_border),
            iconSize: 30,
            color: Colors.grey[400],
            // 5
            onPressed: () {
              const snackBar = SnackBar(content: Text('Favorite Pressed'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'author_card.dart';
import 'fooderlich_theme.dart';

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mag5.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(const Radius.circular(10.0))),
        child: Column(
          children: [
            AuthorCard(
                authorName: "Mike Katz",
                title: "Smoothie Connoisseur",
                imageProvider: AssetImage("assets/author_katz.jpeg")),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      "Recipe",
                      style: FooderlichTheme.lightTextTheme.headline1,
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "Smoothies",
                        style: FooderlichTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

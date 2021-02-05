import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/mag2.png"), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(const Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            // TODO 5: Add dark overlay BoxDecoration
            Container(
              decoration: BoxDecoration(
                // 1
                color: Colors.black.withOpacity(0.6),
                // 2
                borderRadius: BorderRadius.all(const Radius.circular(10.0)),
              ),
            ),
            // TODO 6: Add Container, Column, Icon and Text
            Container(
              // 3
              padding: EdgeInsets.all(16),
              // 4
              child: Column(
                // 5
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 6
                  Icon(Icons.book, color: Colors.white, size: 40),
                  // 7
                  SizedBox(height: 8),
                  // 8
                  Text("Recipe Trends",
                      style: FooderlichTheme.darkTextTheme.headline2),
                  // 9
                  SizedBox(height: 30),
                ],
              ),
            ),
            // TODO 7: Add Center widget with Chip widget children
            // 10
            Center(
              // 11
              child: Wrap(
                // 12
                alignment: WrapAlignment.start,
                // 13
                spacing: 12,
                // 14
                children: [
                  Chip(
                    label: Text("Healthy",
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      print("delete");
                    },
                  ),
                  Chip(
                    label: Text("Vegan",
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      print("delete");
                    },
                  ),
                  Chip(
                    label: Text("Carrots",
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
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

import 'package:flutter/material.dart';
import '../models/explore_recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final ExploreRecipe recipe;

  const RecipeDetailScreen({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(padding: EdgeInsets.zero, children: [
            Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(recipe.backgroundImage, fit: BoxFit.cover)),
          ]),
          Positioned(
            top: 40,
            child: MaterialButton(
              elevation: 10.0,
              color: Colors.white,
              child: Center(child: Icon(Icons.arrow_back)),
              shape: CircleBorder(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

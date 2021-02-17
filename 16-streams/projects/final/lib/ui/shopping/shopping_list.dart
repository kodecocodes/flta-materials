import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/ingredient.dart';
import '../../data/repository.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    return StreamBuilder(
      stream: repository.watchAllIngredients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final List<Ingredient> ingredients = snapshot.data;
          if (ingredients == null) {
            return Container();
          }
          return ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: false,
                  title: Text(ingredients[index].name),
                  onChanged: (newValue) {},
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}

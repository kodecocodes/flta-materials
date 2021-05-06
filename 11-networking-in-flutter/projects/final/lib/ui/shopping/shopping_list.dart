import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  ShoppingList({Key key}) : super(key: key);
  // TODO 1
  final ingredients = <String>[];

  @override
  Widget build(BuildContext context) {
    // TODO 2
    return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            value: false,
            // TODO 3
            title: Text(ingredients[index]),
            onChanged: (newValue) {},
          );
        });
    // TODO 4
  }
}

import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final checkBoxValues = <int, bool>{};
  static const ingredients = <String>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            value: checkBoxValues.containsKey(index) && checkBoxValues[index]!,
            title: Text(ingredients[index]),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  checkBoxValues[index] = newValue;
                });
              }
            },
          );
        });
  }
}

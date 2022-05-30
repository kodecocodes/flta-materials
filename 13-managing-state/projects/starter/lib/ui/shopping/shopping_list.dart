import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final checkBoxValues = Map<int, bool>();
  // TODO: Remove ingredients declaration
  static const ingredients = <String>[];

  @override
  Widget build(BuildContext context) {
    // TODO: Add Consumer widget
    return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            value: checkBoxValues.containsKey(index) && checkBoxValues[index]!,
            // TODO: Update title to include name
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
    // TODO: Add closing brace and parenthesis
  }
}

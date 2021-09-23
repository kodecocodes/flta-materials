import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  // 1
  final _groceryItems = <GroceryItem>[];

  // 2
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  // 3
  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  // 4
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  // 5
  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  // 6
  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}

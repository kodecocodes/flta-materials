import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  String getItemId(int index) {
    final groceryItem = _groceryItems[index];
    return groceryItem.id;
  }

  GroceryItem? getGroceryItem(String id) {
    final index = _groceryItems.indexWhere((element) => element.id == id);
    if (index == -1) return null;
    return groceryItems[index];
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item) {
    final index = _groceryItems.indexWhere((element) => element.id == item.id);
    _groceryItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;

  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);
  int get selectedIndex => _selectedIndex;
  GroceryItem? get selectedGroceryItem =>
      selectedIndex != -1 ? _groceryItems[selectedIndex] : null;
  bool get isCreatingNewItem => _createNewItem;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void groceryItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedGroceryItem(String id) {
    final index = groceryItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}

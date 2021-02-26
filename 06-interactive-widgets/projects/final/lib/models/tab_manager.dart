import 'package:flutter/material.dart';

// 1
class TabManager extends ChangeNotifier {
  // 2
  int selectedTab = 0;

  // 3
  void goToTab(index) {
    // 4
    selectedTab = index;
    // 5
    notifyListeners();
  }

  // 6
  void goToRecipes() {
    selectedTab = 1;
    // 7
    notifyListeners();
  }
}
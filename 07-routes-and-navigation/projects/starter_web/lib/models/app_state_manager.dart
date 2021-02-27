import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_item.dart';
import 'package:fooderlich/navigation/fooderlich_route_path.dart';

class AppStateManager extends ChangeNotifier {
  int selectedTab = 0;
  bool _loggedIn = false;
  bool _initialized = false;
  bool _onboardingComplete = false;

  GroceryItem selectedGroceryItem;
  int groceryItemIndex;

  FooderlichRoutePath get routePath => _routePath;
  FooderlichRoutePath _routePath;
  set routePath(FooderlichRoutePath value) {
    if (value != _routePath) {
      _routePath = value;
      notifyListeners();
      if (value is SplashPath) {
        Timer(const Duration(milliseconds: 2000), () {
          initializeApp();
        });
      }
    }
  }

  Map<String, dynamic> get browserState => _browserState;
  Map<String, dynamic> _browserState;
  set browserState(Map<String, dynamic> value) {
    if (value != _browserState) {
      _browserState = value;
      notifyListeners();
    }
  }

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;

  void goToTab(index) {
    selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    selectedTab = 1;
    notifyListeners();
  }

  void groceryItemTapped(GroceryItem item, int index) {
    selectedGroceryItem = item;
    groceryItemIndex = index;
    notifyListeners();
  }

  void popItem() {
    selectedGroceryItem = null;
    groceryItemIndex = null;
    notifyListeners();
  }

  void initializeApp() {
    _initialized = true;
    routePath = const LoginPath();
    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    routePath = const HomePath(0);
    notifyListeners();
  }

  void login(String username, String password) {
    _loggedIn = true;
    routePath = const OnboardingPath();
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _initialized = false;
    _onboardingComplete = false;
    routePath = const SplashPath();
    notifyListeners();
  }
}

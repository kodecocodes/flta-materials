import 'dart:async';
import 'package:flutter/material.dart';
import 'user_cache.dart';

// 1
class FooderlichTab {
  static int explore = 0;
  static int recipes = 1;
  static int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explore;
  final userCache = MobileUserCache();

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void login(String username, String password) async {
    _loggedIn = true;
    await userCache.cacheUser();
    notifyListeners();
  }

  void onboarded(bool onboard) {
    _loggedIn = true;
    _onboardingComplete = onboard;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() async {
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;
    await userCache.invalidate();

    initializeApp();
    notifyListeners();
  }
}

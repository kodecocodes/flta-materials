import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/models/pages.dart';
import '../models/grocery_manager.dart';
import '../screens/grocery_item_screen.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';
import '../home.dart';
import '../models/app_state_manager.dart';
import 'package:provider/provider.dart';

import 'fooderlich_route_path.dart';
import 'package:uni_links/uni_links.dart';

class FooderlichRouterDelegate extends RouterDelegate<RouterConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterConfiguration> {
  FooderlichRouterDelegate(this.appStateManager)
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  final AppStateManager appStateManager;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // App state to Navigation state, triggered by notifyListeners()
  @override
  RouterConfiguration get currentConfiguration {
    return RouterConfiguration(
        appStateManager.routePath, appStateManager.browserState);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routePath = appStateManager.routePath;
    return Navigator(
        pages: [
          SplashScreen.page(),
          if (routePath is LoginPath)
            LoginScreen.page(routePath.username),
          if (routePath is OnboardingPath)
            OnboardingScreen.page(),
          if (routePath is HomePath) Home.page(),
          if (appStateManager.selectedGroceryItem != null)
            GroceryItemScreen.page(
                item: appStateManager.selectedGroceryItem,
                onUpdate: (item) {
                  Provider.of<GroceryManager>(context, listen: false)
                      .updateItem(item, appStateManager.groceryItemIndex);
                  Provider.of<AppStateManager>(context, listen: false)
                      .popItem();
                })
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          // if (route.settings.key.value == FooderlichPages.onboardingPath) {

          // }

          Provider.of<AppStateManager>(context, listen: false).popItem();
          // notifyListeners();

          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(RouterConfiguration configuration) {
    assert(configuration != null);
    appStateManager.routePath = configuration.path;
    appStateManager.browserState = configuration.browserState;
    return SynchronousFuture<void>(null);
  }
}

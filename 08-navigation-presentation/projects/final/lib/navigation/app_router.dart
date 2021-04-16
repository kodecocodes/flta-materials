import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../models/models.dart';
import 'app_link.dart';

// xcrun simctl openurl booted open://fooderlich/onboarding
// xcrun simctl openurl booted open://fooderlich/home?tab=2
// xcrun simctl openurl booted open://fooderlich/profile
//

/*
adb shell am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "open://fooderlich/home?tab=2"
*/

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter({this.appStateManager, this.groceryManager, this.profileManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        if (appStateManager.isLoggedIn) ...[
          if (!appStateManager.isOnboardingComplete) OnboardingScreen.page(),
          if (appStateManager.isOnboardingComplete) ...[
            Home.page(appStateManager.getSelectedTab),
            if (groceryManager.isCreatingNewItem)
              GroceryItemScreen.page(onCreate: (item) {
                groceryManager.addItem(item);
              }),
            if (groceryManager.selectedIndex != null)
              GroceryItemScreen.page(
                  item: groceryManager.selectedGroceryItem,
                  index: groceryManager.selectedIndex,
                  onUpdate: (item, index) {
                    groceryManager.updateItem(item, index);
                  }),
            if (profileManager.didSelectUser)
              ProfileScreen.page(profileManager.getUser),
            if (profileManager.didTapOnRaywenderlich) WebviewScreen.page()
          ]
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(null);
    }

    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnUser(false);
    }

    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }
    return true;
  }

  @override
  // Return an AppLink, representing the current app state
  AppLink get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    print('getCurrentPath');
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
    } else {
      return AppLink(
          location: AppLink.kHomePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    print('setNewRoutePath: ${newLink.toLocation()}');

    if (newLink.location == AppLink.kProfilePath) {
      profileManager.tapOnUser(true);
      return;
    }

    if (newLink.currentTab != null) {
      // appStateManager.onboarded(true);
      appStateManager.goToTab(newLink.currentTab);
      profileManager.tapOnUser(false);
      return;
    }
  }
}

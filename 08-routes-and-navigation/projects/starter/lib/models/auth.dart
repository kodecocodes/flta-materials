import 'package:flutter/widgets.dart';

import 'app_cache.dart';

/// A mock authentication service.
class YummyAuth extends ChangeNotifier {
  bool _loggedIn = false;

  // Stores user state properties on platform specific file system.
  final _appCache = AppCache();
  
  Future<bool> get loggedIn => _appCache.isUserLoggedIn();

  /// Signs out the current user.
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _loggedIn = false;
    await _appCache.invalidate();
    notifyListeners();
  }

  /// Signs in a user.
  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _loggedIn = true;
    await _appCache.cacheUser();
    notifyListeners();
    return _loggedIn;
  }
}

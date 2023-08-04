import 'package:flutter/widgets.dart';

/// A mock authentication service.
class YummyAuth extends ChangeNotifier {
  bool _loggedIn = false;

  /// Whether user has signed in.
  bool get loggedIn => _loggedIn;

  /// Signs out the current user.
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _loggedIn = false;
    notifyListeners();
  }

  /// Signs in a user.
  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _loggedIn = true;
    notifyListeners();
    return _loggedIn;
  }
}

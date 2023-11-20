import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const klogin = 'yummy_login';

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(klogin, false);
  }

  Future<void> cacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(klogin, true);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(klogin) ?? false;
  }
}

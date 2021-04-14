import 'package:shared_preferences/shared_preferences.dart';

class MobileUserCache {
  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('user', false);
  }

  Future<void> cacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('user', true);
  }

  Future<bool> didCacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('user');
  }
}

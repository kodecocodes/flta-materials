import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repository.dart';
import 'network/service_interface.dart';
import 'network/spoonacular_service.dart';

late SharedPreferences globalSharedPreferences;
final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  return globalSharedPreferences;
});

late Repository globalRepository;
final repositoryProvider = Provider<Repository>((ref) {
  return globalRepository;
});

final serviceProvider =
    Provider<ServiceInterface>((ref) => SpoonacularService.create());

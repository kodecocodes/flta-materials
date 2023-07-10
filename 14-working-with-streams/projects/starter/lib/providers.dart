import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/memory_repository.dart';
import 'network/spoonacular_service.dart';

late SharedPreferences globalSharedPreferences;
final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  return globalSharedPreferences;
});

late MemoryRepository globalRepository;
final repositoryProvider = Provider<MemoryRepository>((ref) {
  return globalRepository;
});

// TODO Replace with ServiceInterface
final serviceProvider =
    Provider<SpoonacularService>((ref) => SpoonacularService.create());


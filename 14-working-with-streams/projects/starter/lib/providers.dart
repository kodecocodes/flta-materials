import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/memory_repository.dart';
import 'network/spoonacular_service.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final repositoryProvider = Provider<MemoryRepository>((ref) {
  throw UnimplementedError();
});

// TODO Replace with ServiceInterface
final serviceProvider =
    Provider<SpoonacularService>((ref) => SpoonacularService.create());


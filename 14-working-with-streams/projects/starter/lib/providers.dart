import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/models/current_recipe_data.dart';
import 'data/repositories/memory_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/service_interface.dart';
import 'ui/main_screen_state.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final bottomNavigationProvider =
    StateNotifierProvider<MainScreenStateProvider, MainScreenState>((ref) {
  return MainScreenStateProvider();
});


final repositoryProvider =
    NotifierProvider<MemoryRepository, CurrentRecipeData>(() {
  return MemoryRepository();
});

final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});

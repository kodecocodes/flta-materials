import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/repositories/memory_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/service_interface.dart';
import 'ui/main_screen_state.dart';

final bottomNavigationProvider =
StateNotifierProvider<MainScreenStateProvider, MainScreenState>((ref) {
  return MainScreenStateProvider();
});

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final repositoryProvider = Provider<MemoryRepository>((ref) {
  return MemoryRepository();
});


final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});


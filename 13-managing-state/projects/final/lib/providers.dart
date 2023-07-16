import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/data/repositories/memory_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/repository.dart';
import 'network/service_interface.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final repositoryProvider = ChangeNotifierProvider<MemoryRepository>((ref) {
  return MemoryRepository();
});


final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/repositories/memory_repository.dart';

import 'network/service_interface.dart';

// TODO Add Shared Pref Provider

final repositoryProvider = ChangeNotifierProvider<MemoryRepository>((ref) {
  return MemoryRepository();
});


final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});


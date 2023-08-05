import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repositories/repository.dart';
import 'network/service_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final repositoryProvider = Provider<Repository>((ref) {
  throw UnimplementedError();
});


final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});


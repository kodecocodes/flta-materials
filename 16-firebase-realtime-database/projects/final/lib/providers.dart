import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/message_dao.dart';
import 'models/user_dao.dart';

// 1
final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});

// 1
final messageDaoProvider = Provider<MessageDao>((ref) {
  return MessageDao();
});

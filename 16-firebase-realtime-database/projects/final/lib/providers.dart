import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/message_dao.dart';
import 'data/user_dao.dart';

final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});
final messageDaoProvider = Provider<MessageDao>((ref) {
  return MessageDao();
});

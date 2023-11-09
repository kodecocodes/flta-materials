import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/message.dart';
import 'models/message_dao.dart';
import 'models/user_dao.dart';


final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});

final messageDaoProvider = Provider<MessageDao>((ref) {
  return MessageDao(ref.watch(userDaoProvider));
});

final messageListProvider = StreamProvider<List<Message>>((ref) {
  final messageDao = ref.watch(messageDaoProvider);
  return messageDao.getMessageStream();
});

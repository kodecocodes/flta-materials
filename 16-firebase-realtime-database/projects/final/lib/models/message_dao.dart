import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/message.dart';
import 'user_dao.dart';

class MessageDao {
  MessageDao(this.userDao);

  final UserDao userDao;

  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('messages');

  void sendMessage(String text) {
    // 2
    final message = Message(
      date: DateTime.now(),
      email: userDao.email()!,
      text: text,
    );
    collection.add(message.toJson()); // 1
  }

  Stream<List<Message>> getMessageStream() {
    return collection
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return [...snapshot.docs.map(Message.fromSnapshot)];
    });
  }
}

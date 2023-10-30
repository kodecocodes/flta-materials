import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/message.dart';

class MessageDao {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('messages');

  void saveMessage(Message message) {
    // 2
    collection.add(message.toJson()); // 1
  }

  Stream<QuerySnapshot> getMessageStream() {
    return collection.snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    required this.date,
    required this.email,
    required this.text,
    this.reference,
  });

  final DateTime date;
  final String email;
  final String text;

  DocumentReference? reference;

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
        date: (json['date'] as Timestamp).toDate(),
        email: json['email'] as String,
        text: json['text'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date,
        'email': email,
        'text': text,
      };

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJson(
      snapshot.data() as Map<String, dynamic>,
    );
    message.reference = snapshot.reference;
    return message;
  }
}

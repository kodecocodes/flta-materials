class Message {
  final String text;
  final DateTime date;
  final String? email;

  Message(this.text, this.date, this.email);

  Message.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        text = json['text'] as String,
        email = json['email'] as String?;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'text': text,
        'email': email,
      };
}

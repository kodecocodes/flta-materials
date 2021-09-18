import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final DateTime date;
  final String? email;

  const MessageWidget(
    this.message,
    this.date,
    this.email, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 1,
        top: 5,
        right: 1,
        bottom: 2,
      ),
      child: Column(
        children: [
          if (email != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  email!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[350]!,
                  blurRadius: 2.0,
                  offset: const Offset(0, 1.0),
                )
              ],
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: MaterialButton(
              disabledTextColor: Colors.black87,
              padding: const EdgeInsets.only(left: 18),
              onPressed: null,
              child: Wrap(
                children: <Widget>[
                  Row(
                    children: [
                      Text(message),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                DateFormat('yyyy-MM-dd, kk:mma').format(date).toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

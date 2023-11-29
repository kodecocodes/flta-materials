import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers.dart';
import 'message.dart';

class MessageWidget extends ConsumerWidget {
  const MessageWidget(
    this.message, {
    super.key,
  });

  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userDao = ref.watch(userDaoProvider);
    final myMessage = message.email == userDao.email();

    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: myMessage ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment:
            myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // Display email of others not ones sent from device
              !myMessage
                  ? Text(
                      message.email,
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                      ),
                    )
                  : const Text(''),
              // Display date and time message was sent
              Text(
                '  ${DateFormat.yMd().format(message.date)} '
                '${DateFormat.Hm().format(message.date)}',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          // Speech bubble
          Material(
            color: theme.colorScheme.surface,
            // Uncomment to Change speech bubble color
            // surfaceTintColor: theme.colorScheme.surfaceTint,
            // shadowColor: theme.colorScheme.surfaceTint,
            elevation: 1.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    message.text,
                    style: theme.textTheme.bodyLarge!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

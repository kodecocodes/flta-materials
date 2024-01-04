import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageWidget extends ConsumerWidget {
  // TODO: Replace MessageWidget
  const MessageWidget(
  {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // TODO: Add userDao and myMessage

    return FractionallySizedBox(
      widthFactor: 0.7,
      // TODO: Add alignment
      child: Column(
        // TODO: Add crossAxisAlignment
        children: [
          // TODO: Add Row for message
          // Speech bubble
          Material(
            color: theme.colorScheme.surface,
            // Uncomment to Change speech bubble color
            // surfaceTintColor: theme.colorScheme.surfaceTint,
            // shadowColor: theme.colorScheme.surfaceTint,
            elevation: 1.0,
            borderRadius: BorderRadius.circular(10.0),
            // TODO: Remove const
            child: const Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TODO: Replace Text
                  Text('message will go here'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

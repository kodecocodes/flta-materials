import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'message.dart';
import 'message_widget.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({
    super.key,
  });

  @override
  ConsumerState createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // always dispose of controllers you create
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final messageDao = ref.read(messageDaoProvider);
      messageDao.sendMessage(_messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          // 1
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final data = ref.watch(messageListProvider);
              return data.when(
                loading: () => const Center(
                  child: LinearProgressIndicator(),
                ),
                data: (List<Message> messages) => ListView(
                  controller: _scrollController,
                  reverse: true,
                  // 2
                  children: [
                    for (final message in messages) //
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 4.0),
                        child: MessageWidget(message),
                      ),
                  ],
                ),
                error: (error, stackTrace) {
                  return Center(child: Text('$error'));
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _messageController,
                    autocorrect: true,
                    enableSuggestions: true,
                    onSubmitted: (_) => _sendMessage(),
                    decoration:
                        const InputDecoration(hintText: 'Enter new message'),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _messageController,
                builder: (BuildContext context, TextEditingValue value,
                    Widget? child) {
                  return IconButton(
                    onPressed:
                        value.text.trim().isNotEmpty ? _sendMessage : null,
                    icon: const Icon(Icons.send),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

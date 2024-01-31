import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  // TODO: Replace _sendMessage
  void _sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          // TODO: Add Message List
          const Expanded(
            child: SizedBox(height: 80),
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
      ),
    );
  }
}

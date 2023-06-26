import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => MessageListState();
}

class MessageListState extends ConsumerState<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // TODO: Add Email String

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    // TODO: Add MessageDao

    // TODO: Add UserDao

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kodeco Chat'),
        // TODO: Replace with actions
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO: Add Message DAO to _getMessageList
            _getMessageList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _messageController,
                      onSubmitted: (input) {
                        // TODO: Add Message DAO 1
                        _sendMessage();
                      },
                      decoration:
                          const InputDecoration(hintText: 'Enter new message'),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _canSendMessage()
                        ? Icons.arrow_circle_left_outlined
                        : Icons.arrow_circle_right_outlined,
                  ),
                  onPressed: () {
                    // TODO: Add Message DAO 2
                    _sendMessage();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Replace _sendMessage
  void _sendMessage() {}

  // TODO: Replace _getMessageList
  Widget _getMessageList() {
    return const SizedBox.shrink();
  }

  // TODO: Add _buildList

  // TODO: Add _buildListItem

  bool _canSendMessage() => _messageController.text.isNotEmpty;

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // TODO: Add Email String

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());
    // TODO: Add MessageDao

    // TODO: Add UserDao

    return Scaffold(
      appBar: AppBar(
        title: const Text('RayChat'),
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
                    icon: Icon(_canSendMessage()
                        ? CupertinoIcons.arrow_right_circle_fill
                        : CupertinoIcons.arrow_right_circle),
                    onPressed: () {
                      // TODO: Add Message DAO 2
                      _sendMessage();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Replace _sendMessage
  void _sendMessage() {
  }

  // TODO: Replace _getMessageList
  Widget _getMessageList() {
    return const SizedBox.shrink();
  }

  // TODO: Add _buildList

  // TODO: Add _buildListItem

  bool _canSendMessage() => _messageController.text.length > 0;

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

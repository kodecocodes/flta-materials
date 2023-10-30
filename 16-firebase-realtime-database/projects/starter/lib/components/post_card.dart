import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCard extends ConsumerStatefulWidget {
  const PostCard({
    super.key,
  });

  @override
  ConsumerState createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // TODO: Add Email String

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // TODO: Add MessageDao

    // TODO: Add UserDao

    return Padding(
      padding: const EdgeInsets.all(5.0),
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
    );
  }

  // TODO: Replace _sendMessage
  void _sendMessage() {}

  // TODO: Replace _getMessageList
  Widget _getMessageList() {
    return const Expanded(
      child: SizedBox.shrink(),
    );
  }

  // TODO: Add _buildListItem

  // TODO: Add _buildList

  bool _canSendMessage() => _messageController.text.isNotEmpty;

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

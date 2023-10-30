import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message_dao.dart';
import '../providers.dart';
import 'message.dart';
import 'message_widget.dart';

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

  String? email;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    final messageDao = ref.watch(messageDaoProvider);

    final userDao = ref.watch(userDaoProvider);
    email = userDao.email();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          _getMessageList(messageDao),
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
                      _sendMessage(messageDao);
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
                  _sendMessage(messageDao);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage(MessageDao messageDao) {
    if (_canSendMessage()) {
      final message = Message(
        text: _messageController.text,
        date: DateTime.now(),
        email: email,
      );
      messageDao.saveMessage(message);
      _messageController.clear();
      setState(() {});
    }
  }

  Widget _getMessageList(MessageDao messageDao) {
    return Expanded(
      // 1
      child: StreamBuilder<QuerySnapshot>(
        // 2
        stream: messageDao.getMessageStream(),
        // 3
        builder: (context, snapshot) {
          // 4
          if (!snapshot.hasData) {
            return const Center(child: LinearProgressIndicator());
          }

          // 5
          return _buildList(context, snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // 1
    final message = Message.fromSnapshot(snapshot);
    // 2
    return MessageWidget(
      message.text,
      message.date,
      message.email,
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    // 1
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0),
      // 2
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  bool _canSendMessage() => _messageController.text.isNotEmpty;

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

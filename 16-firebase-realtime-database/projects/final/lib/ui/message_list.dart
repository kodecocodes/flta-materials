import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/message.dart';
import '../data/message_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers.dart';
import 'message_widget.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => MessageListState();
}

class MessageListState extends ConsumerState<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? email;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    final messageDao = ref.watch(messageDaoProvider);
    final userDao = ref.watch(userDaoProvider);

    email = userDao.email();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kodeco Chat'),
        actions: [
          IconButton(
            onPressed: () {
              userDao.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
      child: StreamBuilder<QuerySnapshot>(
        stream: messageDao.getMessageStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: LinearProgressIndicator());
          }

          return _buildList(context, snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final message = Message.fromSnapshot(snapshot);

    return MessageWidget(
      message.text,
      message.date,
      message.email,
    );
  }

  bool _canSendMessage() => _messageController.text.isNotEmpty;

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

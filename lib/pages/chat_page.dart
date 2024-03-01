import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:group_9_birumanchu/main.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String userid;
  final String userName;
  const ChatPage({Key? key, required this.userid, required this.userName})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  String randomId = Uuid().v4();
  final _user = types.User(id: uid);

  void initState() {
    _getMessages();
    super.initState();
  }

  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.userid)
        .collection('contents')
        .get();

    final message = getData.docs
        .map((d) => types.TextMessage(
              author:
                  types.User(id: d.data()['uid'], firstName: d.data()['name']),
              createdAt: d.data()['createdAt'],
              id: d.data()['id'],
              text: d.data()['text'],
              previewData: null,
            ))
        .toList();

    setState(() {
      _messages = [...message];
    });
  }

  void _addMessage(types.TextMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.userid)
        .collection('contents')
        .add({
      'uid': uid,
      'name': displayName,
      'createdAt': message.createdAt,
      'id': message.id,
      'text': message.text,
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = message.copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomId,
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userName}'),
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          inputBackgroundColor: Colors.blue,
          sendButtonIcon: Icon(Icons.send),
          sendingIcon: Icon(Icons.update_outlined),
        ),
        showUserNames: true,
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}

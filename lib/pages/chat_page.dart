import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(this.name, {Key? key}) : super(key: key);

  final String name;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  String randomId = Uuid().v4();
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c', firstName: '名前');

  void initState() {
    _getMessages();
    super.initState();
  }

  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .get();

    final message = getData.docs
        .map((d) => types.TextMessage(
              author: types.User(id: d.data()['uid'], firstName: d.data()['name']),
              createdAt: d.data()['createdAt'],
              id: d.data()['id'],
              text: d.data()['text'],
              previewData: null, // ここでpreviewDataを追加し、nullで初期化します
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
        .doc(widget.name)
        .collection('contents')
        .add({
      'uid': message.author.id,
      'name': message.author.firstName,
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
        title: Text('チャット'),
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

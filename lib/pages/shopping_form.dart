import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/chat_page.dart';
import 'package:group_9_birumanchu/pages/room_list_page.dart';
import 'package:uuid/uuid.dart';

class FormPage extends StatefulWidget {
  final String userid;
  final String userName;
  const FormPage({Key? key, required this.userid, required this.userName})
      : super(key: key); // コンストラクターでuidを受け取るように修正

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _shopcontroller = TextEditingController();
  final TextEditingController _shoppinglistcontroller = TextEditingController();
  final TextEditingController _destinationcontroller = TextEditingController();
  final _user = types.User(id: uid);

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('エラー'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  void _addMessage(types.TextMessage message) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("依頼form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _shopcontroller,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: "店名",
                        contentPadding: EdgeInsets.all(10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _shoppinglistcontroller,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: "買うものリスト",
                        contentPadding: EdgeInsets.all(10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _destinationcontroller,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: "配送先",
                        contentPadding: EdgeInsets.all(10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final formId = Uuid().v4();
                      if (_shopcontroller.text.isEmpty ||
                          _shoppinglistcontroller.text.isEmpty ||
                          _destinationcontroller.text.isEmpty) {
                        _showErrorDialog('すべての項目を入力してください。');
                      } else {
                        final document = <String, dynamic>{
                          'shopname': _shopcontroller.text,
                          'shoppinglist': _shoppinglistcontroller.text,
                          'destination': _destinationcontroller.text,
                        };
                        FirebaseFirestore.instance
                            .collection('form')
                            .doc(widget.userid)
                            .set(document);
                        _shopcontroller.clear();
                        _shoppinglistcontroller.clear();
                        _destinationcontroller.clear();

                        final date = DateTime.now().toLocal().toIso8601String();
                        final roomRef = await FirebaseFirestore.instance
                            .collection('chat_room')
                            .doc(widget.userid)
                            .set({
                              'name': widget.userName,
                              'createdAt': date,
                              'createuser': uid,
                              'destinationuser': widget.userid
                            });
                        
                        final postData = await FirebaseFirestore.instance
                            .collection('form')
                            .doc(widget.userid)
                            .get();
                        final shopname = postData['shopname'];
                        final shoppinglist = postData['shoppinglist'];
                        final destination = postData['destination'];
                        // メッセージの内容を作成
                        final message = types.TextMessage(
                          author: _user, // 送信者
                          createdAt: DateTime.now().millisecondsSinceEpoch, // 作成日時
                          id: Uuid().v4(), // メッセージID
                          text: 'お店名: $shopname\n買い物リスト: $shoppinglist\n配送先: $destination', // メッセージのテキスト
                        );

                        // メッセージを送信
                        _addMessage(message);

                        // 2. 作成したチャットルームのIDを指定してチャットページに遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(userid:widget.userid,userName: widget.userName,),
                              ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(111, 17, 242, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "依頼",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

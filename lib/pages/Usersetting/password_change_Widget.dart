//Password and User Information Change FILE
import 'package:flutter/material.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/pages/Usersetting/account_info_page.dart';

bool _isvisible1 = true, _isvisible_2 = true;

String password='';
//Password Change Class
class PasswordChange extends StatefulWidget {
  var pwd;

  PasswordChange({Key? key, required this.pwd});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  late TextEditingController _controller;
  
 late String changepwd, confirmpwd;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('パスワード変更'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                obscureText: _isvisible1,
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isvisible1 ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isvisible1 = !_isvisible1;
                      });
                    },
                  ),
                ),
                onChanged: (value) => changepwd = value,
              ),
              TextFormField(
                obscureText: _isvisible_2,
                decoration: InputDecoration(
                  labelText: 'パスワード確認',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isvisible_2 ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isvisible_2 = !_isvisible_2;
                      });
                    },
                  ),
                ),
                onChanged: (value) => confirmpwd = value,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text("キャンセル"),
                onPressed: () {
                  Navigator.pop(context);
                }),
            ElevatedButton(
                child: Text("保存"),
                onPressed: () {
                  if (changepwd.isNotEmpty &&
                      confirmpwd.isNotEmpty &&
                      changepwd == confirmpwd && changepwd.length>5) {
                        password = changepwd;       //have to update in firestore
                    print(password);
                    Navigator.pop(context);
                    showDialog(context: context, barrierDismissible: false, 
                    builder: (BuildContext context){return ShowMsg(content: 'パスワード',);} );
                  }
                  else{
                    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                                return ShowErrorMsg(content: 'パスワード',);}
                    );
                  }
              }),
          ],
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ShowErrorMsg extends StatelessWidget {
  String content;
 
   ShowErrorMsg({Key?key, required this.content});

    @override
  Widget build(BuildContext context) {
    return AlertDialog(         // To display the title it is optional
              content: Text(content+('変更は失敗しました。')),   // Message which will be pop up on the screen
                                                  // Action widget which will provide the user to acknowledge the choice
                actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
  }
}
// ignore: must_be_immutable
class ShowMsg extends StatelessWidget { 
String content;
   ShowMsg({Key?key, required this.content});

    @override
  Widget build(BuildContext context) {
    return AlertDialog(         // To display the title it is optional
              content: Text(content+('変更しました。')),   // Message which will be pop up on the screen
                                                  // Action widget which will provide the user to acknowledge the choice
                actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
  }
}

  
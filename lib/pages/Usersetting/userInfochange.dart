//Password and User Information Change FILE
import 'package:flutter/material.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/pages/Usersetting/password_change_Widget.dart';

bool _isvisible1 = true, _isvisible_2 = true;
String changeName = '', changeEmail = '', changePh_num = '';


//Password Change Class 
class InformationChange extends StatefulWidget {
  const InformationChange({Key? key}) : super(key: key);

  @override
  State<InformationChange> createState() => _InformationChange();
}

class _InformationChange extends State<InformationChange> {
  late TextEditingController _controller;
  late String name, email, ph_number;
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
      title: const Text('ユーザ情報変更'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: '氏名',
                ),
                onChanged: (value) => changeName = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                ),
                onChanged: (value) => changeEmail = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '電話番号',
                ),
                onChanged: (value) => changePh_num = value,
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
              if(changeEmail.isEmpty && changeName.isEmpty && changePh_num.isEmpty){
                    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                                return ShowErrorMsg(content: 'あなたの情報',);}
                    );
            }
              else {
                if(changeName.isNotEmpty){
                   name = changeName;       //have to update in firestore
                    print(name);
                    Navigator.pop(context);
                    popUp('氏名変更しました。');
                }
                if(changeEmail.isNotEmpty){
                  email = changeEmail;
                  print(email);
                  Navigator.pop(context);
                    popUp('氏名変更しました。');
                }
                if(changePh_num.isNotEmpty){
                  ph_number = changePh_num;
                  print(ph_number);
                  Navigator.pop(context);
                    popUp('氏名変更しました。');
                }
              }
            }),
             ],
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/pages/Usersetting/account_page.dart';

import '../../main.dart';

class PostInputForm extends StatefulWidget {
  const PostInputForm({Key? key}) : super(key: key);

  @override
  State<PostInputForm> createState() => _PostInputForm();
}

class _PostInputForm extends State<PostInputForm> {
  TextEditingController _dateTextController = TextEditingController(),
      _destinationTextController = TextEditingController(),
      _shopListTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('代行可能フォーム'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              formConstantText('日程'),
              reusableTextField('DD/MM/YY', Icons.date_range_outlined, false,
                  _dateTextController),
              SizedBox(
                height: 10,
              ),
              formConstantText('宛先'),
              reusableTextField('都市の名前', Icons.location_city_outlined, false,
                  _destinationTextController),
              SizedBox(
                height: 10,
              ),
              formConstantText('頼めるお店'),
              reusableTextField('店名', Icons.shopping_cart_checkout_outlined,
                  false, _shopListTextController),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
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
                onPressed: () async {
                  try{
                    await createPost();
                  }
                catch(e){
                  popUp("Error ${e.toString()}");
                  print("Error ${e.toString()}");
                }
                },
                ),
          ],
        ),
      ],
    );
  }

  Future<void> createPost() async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(uid).set({
        'user_id': uid,
        'date': _dateTextController.text,
        'destination': _destinationTextController.text,
        'shoplist': _shopListTextController.text,
      });
      popUp("登録完了しました。");
      print("Post created");
      Navigator.pop(context);
    } catch (error) {
      popUp("Error ${error.toString()}");
      print("Error ${error.toString()}");
    }
  }
}

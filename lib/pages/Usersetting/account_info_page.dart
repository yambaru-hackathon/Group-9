// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_9_birumanchu/pages/Login_SignUp/login.dart';
import 'package:group_9_birumanchu/pages/Usersetting/password_change_Widget.dart';
import 'package:group_9_birumanchu/pages/Usersetting/userInfochange.dart';
import 'package:responsive_framework/responsive_framework.dart';

String name = 'Dee',
    email = 'dee224@gmail.com',
    ph_number = '08061558698',
    password = 'dee224gmail';

class Accountinfo extends StatefulWidget {
  const Accountinfo({Key? key}) : super(key: key);

  @override
  State<Accountinfo> createState() => _AccountinfoState();
}

class _AccountinfoState extends State<Accountinfo> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints(
      breakpoints: [
        Breakpoint(start: 0, end: 480, name: MOBILE),
      ],
      child:Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_sharp),
                      onPressed: () {
                        // Navigate back to the first screen by popping the current route
                        // off the stack.
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ユーザ情報',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                            onPressed: () {
                              showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                                return InformationChange();
                              },
                              );

                            },
                          ), 
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            formConstantText(
              content: '氏名',
            ),
            formInputValue(
              content: name,
            ),
            formConstantText(content: 'メールアドレス'),
            formInputValue(
              content: email,
            ),
            formConstantText(content: '電話番号'),
            formInputValue(
              content: ph_number,
            ),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'パスワード',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                       IconButton(
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                            onPressed: () {
                              showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                                return PasswordChange();
                              },
                              );

                            },
                          ), 
                      ],
                    ),
                  ),
                ],
              ),
            ),
            passwordInfo(
              password_content: password,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ElevatedButton(onPressed: (){
                FirebaseAuth.instance.signOut().then((value) => {
                   Fluttertoast.showToast(
                        msg: "登録完了しました。",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 253, 63, 49),
                        textColor: Colors.white,
                        fontSize: 16.0),
                        print("Sign Out"),
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }, child: Text('ログアウト'))],
            )
          ],
        ),
      ),
    ),
    );
  }
}

class passwordInfo extends StatefulWidget {
  String password_content;
  passwordInfo({
    Key? key,
    required this.password_content,
  });

  @override
  State<passwordInfo> createState() => _passwordInfoState();
}

class _passwordInfoState extends State<passwordInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          hide_password(),
        ],
      ),
    );
  }

  hide_password() {
    String passwordStar = '';
    return Text(
      passwordStar.padLeft(widget.password_content.length, '*'),
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
    );
  }
}

class formInputValue extends StatefulWidget {
  var content;

  formInputValue({Key? key, required this.content});

  @override
  State<formInputValue> createState() => _formInputValueState();
}

class _formInputValueState extends State<formInputValue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Row(
        children: [
          Text(
            widget.content,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}

class formConstantText extends StatelessWidget {
  var content;

  formConstantText({Key? key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Row(
        children: [
          Text(
            content,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}

Widget forwardChangeInfo() {
  return InkWell(
    child: const Icon(Icons.arrow_forward_ios_outlined),
    onTap: () {
      //action code when clicked
      print("The icon is clicked");
    },
  );
}

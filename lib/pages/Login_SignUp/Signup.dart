// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
// import 'package:group_9_birumanchu/main.dart';
// import 'package:group_9_birumanchu/pages/Login_SignUp/login.dart';
// import 'package:group_9_birumanchu/utils/color_utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   TextEditingController _passwordTextController = TextEditingController(),
//       _emailTextController = TextEditingController(),
//       _userTextController = TextEditingController(),
//       _phNumberTextController = TextEditingController(),
//       _confirmPwdTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "ユーザ登録",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//           colors: [
//             hexStringToColor("CB2B93"),
//             hexStringToColor("9546C4"),
//             hexStringToColor("5E61F4")
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         )),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).size.height * 0.1, 20, 0),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField(
//                     '氏名入力', Icons.person_outline, false, _userTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField('メールアドレス入力', Icons.mail_outline, false,
//                     _emailTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField('電話番号入力', Icons.phone_android, false,
//                     _phNumberTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField('パスワード入力', Icons.lock_outline, true,
//                     _passwordTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField('パスワード確認', Icons.lock_outline, true,
//                     _confirmPwdTextController),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 signInsignUpButton(context, false, () {
//                   if (passwordConfirm(_passwordTextController.text,
//                       _confirmPwdTextController.text)) {
//                     //create user with Authentication
//                     FirebaseAuth.instance
//                         .createUserWithEmailAndPassword(
//                             email: _emailTextController.text,
//                             password: _passwordTextController.text)
//                         .then((value) {
//                       popUp("登録完了しました。");
//                       print("Account created");
//                       addUserDetails(
//                           _userTextController.text,
//                           _emailTextController.text,
//                           _phNumberTextController.text,
//                           _passwordTextController.text);
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => LoginPage()));
//                     }).onError((error, stackTrace) {
//                       popUp("Error ${error.toString()}");
//                       print("Error ${error.toString()}");
//                     });
//                   } else {
//                     popUp("もう一回確認しください。");
//                   }
//                 })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future addUserDetails(
//       String username, String mail, String phNum, String passwd) async {
//     await FirebaseFirestore.instance.collection("users").add({
//       "name": username,
//       "email": mail,
//       "phoneNumber": phNum,
//       "password": passwd,
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/Login_SignUp/login.dart';
import 'package:group_9_birumanchu/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _passwordTextController = TextEditingController(),
      _emailTextController = TextEditingController(),
      _userTextController = TextEditingController(),
      _phNumberTextController = TextEditingController(),
      _confirmPwdTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "ユーザ登録",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    '氏名入力', Icons.person_outline, false, _userTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('メールアドレス入力', Icons.mail_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('電話番号入力', Icons.phone_android, false,
                    _phNumberTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('パスワード入力', Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('パスワード確認', Icons.lock_outline, true,
                    _confirmPwdTextController),
                const SizedBox(
                  height: 30,
                ),
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
>>>>>>> 4ea4580 (ボタン修正)
=======
>>>>>>> 4ea4580 (ボタン修正)
                signInsignUpButton(context, false, () {
                  if (passwordConfirm(_passwordTextController.text,
                      _confirmPwdTextController.text)) {
                    //create user with Authentication
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      popUp("登録完了しました。");
                      print("Account created");
                      addUserDetails(
                          _userTextController.text,
                          _emailTextController.text,
                          _phNumberTextController.text,
                          _passwordTextController.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }).onError((error, stackTrace) {
                      popUp("Error ${error.toString()}");
                      print("Error ${error.toString()}");
                    });
                  } else {
                    popUp("もう一回確認しください。");
                  }
                })
=======
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 4ea4580 (ボタン修正)
=======
>>>>>>> 4ea4580 (ボタン修正)
=======
>>>>>>> 4ea4580 (ボタン修正)
                signInsignUpButton(context, false, () async {
                  if (_passwordTextController.text == _confirmPwdTextController.text) {
                      // Passwords match, proceed with authentication
                      try {
                        await createAuth();
                      } catch (error) {
                        popUp("Error ${error.toString()}");
                        print("Error ${error.toString()}");
                      }
                    } else {
                      popUp("パスワードをもう一度確認してください。");
                    }
                  },
                )
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> b9de677 (ボタン修正)
>>>>>>> 4ea4580 (ボタン修正)
=======
>>>>>>> b9de677 (ボタン修正)
>>>>>>> 4ea4580 (ボタン修正)
=======
>>>>>>> b9de677 (ボタン修正)
>>>>>>> 4ea4580 (ボタン修正)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createAuth() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      final user = result.user;
      final uuid = user?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uuid).set({
        'uid': uuid,
        'name': _userTextController.text,
        'email': _emailTextController.text,
        "phoneNumber": _phNumberTextController.text,
        "password": _passwordTextController.text,
      });
      popUp("登録完了しました。");
      print("Account created");
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (error) {
      popUp("Error ${error.toString()}");
      print("Error ${error.toString()}");
    }
  }
}

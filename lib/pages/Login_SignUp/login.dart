import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/Login_SignUp/Signup.dart';
import 'package:group_9_birumanchu/pages/Login_SignUp/auth_service.dart';
import 'package:group_9_birumanchu/utils/color_utils.dart';

User? user;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  20, MediaQuery.of(context).size.height * 0.35, 20, 0),
              child: Column(
                children: <Widget>[
                  // logoWidget("images/Logo1.png"),
                  SizedBox(
                    height: 5,
                  ),
                  reusableTextField("メールアドレス入力", Icons.person_outline, false,
                      _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("パスワード入力", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signInsignUpButton(context, true, () async {
                    try{
                      await _signIn();
                    }
                    catch(e){
                      popUp("Error ${e.toString()}");
                          print("Error ${e.toString()}");
                    }
                  }),
                  signUpOption(),
                ],
              ),
            ),
          )),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signup()));
          },
          child: const Text(
            "新しいアカウントを作成",
            style: TextStyle(color: Colors.white70),
          ),
        )
      ],
    );
  }

  Future<void> _signIn() async {
    String email = _emailTextController.text;
    String pass = _passwordTextController.text;

    user = await _auth.signInWithEmailAndPassword(email, pass);
    user = await _auth.getcurrentUser();
    print(user);
    try {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => MyApp())));
      print(user);
    } catch (e) {
      popUp("Error ${e.toString()}");
      print("Error ${e.toString()}");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/Login_SignUp/login.dart';
import 'package:group_9_birumanchu/pages/Usersetting/password_change_Widget.dart';
import 'package:group_9_birumanchu/pages/Usersetting/userInfochange.dart';
import 'package:group_9_birumanchu/service/userDatabase.dart';

 
class Accountinfo extends StatefulWidget {
  const Accountinfo({Key? key}) : super(key: key);

  @override
  State<Accountinfo> createState() => _AccountinfoState();
}

class _AccountinfoState extends State<Accountinfo> {
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
      print(usermodel.name + " "+ usermodel.ph_num + " " + usermodel.email +" "+ usermodel.password);
  }

   
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height * 0.123, 3, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                     /* Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () {
                                  showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                                    return InformationChange();
                                  },
                                  );
            
                                },
                              ), 
                        ],
                      ),*/
                    ],
                  ),
                ),
                formConstantText('氏名'),
                FormOutputValue(usermodel.name),
                 SizedBox(
                    height: 20,
                  ),
                formConstantText('メールアドレス'),
                FormOutputValue(usermodel.email),
                 SizedBox(
                    height: 20,
                  ),
                formConstantText('電話番号'),
                FormOutputValue(usermodel.ph_num),
                 SizedBox(
                    height: 20,
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
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      /*const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                           IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () {
                                  showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                                    return PasswordChange(pwd: password,);
                                  },
                                  );
            
                                },
                              ), 
                          ],
                        ),
                      ),*/
                    ],
                  ),
                ),
                passwordInfo(
                  password_content: usermodel.email,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      FirebaseAuth.instance.signOut().then((value) => {
                        popUp("ログアウトしました。"),                     
                              print("Sign Out"),
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    }, child: Text('ログアウト', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,),)),
                  )],
                ),
              ],
            ),
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

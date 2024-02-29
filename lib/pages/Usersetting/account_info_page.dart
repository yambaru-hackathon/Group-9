import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/Login_SignUp/login.dart';
import 'package:group_9_birumanchu/pages/Usersetting/password_change_Widget.dart';
import 'package:group_9_birumanchu/pages/Usersetting/userInfochange.dart';


class Accountinfo extends StatefulWidget {
  const Accountinfo({Key? key}) : super(key: key);

  @override
  State<Accountinfo> createState() => _AccountinfoState();
}

class _AccountinfoState extends State<Accountinfo> {

var ds; late String name,email,ph_number,password;

  @override
  void initState() {
    print (uid);
    _fetch(uid);
    super.initState();
  }

  _fetch(String id) async{
   await FirebaseFirestore.instance.collection('users').doc(id).get().then((DocumentSnapshot ds) => {
    email = ds.get('email'),
    name = ds.get('name'),
    password = ds.get('password'),
    ph_number = ds.get('phoneNumber')
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height * 0.08, 3, 0),
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
                      Column(
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
                      ),
                    ],
                  ),
                ),
                formConstantText('氏名'),
                FormOutputValue( name),
                 SizedBox(
                    height: 20,
                  ),
                formConstantText('メールアドレス'),
                FormOutputValue(email),
                 SizedBox(
                    height: 20,
                  ),
                formConstantText('電話番号'),
                FormOutputValue(ph_number),
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
                      const Spacer(),
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
                      popUp("ログアウトしました。"),                     
                            print("Sign Out"),
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  }, child: Text('ログアウト', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),))],
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
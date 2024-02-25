// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

String name = 'Dee', email = 'dee224@gmail.com' , ph_number = '08061558698', password = 'dee224gmail';


class Accountinfo extends StatelessWidget {
   const Accountinfo({Key? key}) : super(key: key);
   
     @override
     Widget build(BuildContext context) {
      return Scaffold(
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
                      backward(),
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
                        Text('ユーザ情報', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        forwardChangeInfo(),      //have to change
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                      color: Colors.black,
                      thickness: 2,
              ),
              formConstantText(content: '氏名',),
              formInputValue(content: name,),
              formConstantText(content: 'メールアドレス'),
              formInputValue(content: email,),
              formConstantText(content: '電話番号'),
              formInputValue(content: ph_number,),
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
                    Text('パスワード',style: TextStyle(
                      color: Colors.grey.shade500, fontSize: 20, fontWeight: FontWeight.w300,
                    ),),
                  ],
                ),
                const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0 ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          forwardChangeInfo(),      //have to change
                        ],
                      ),
                    ),
                  ],
                ),
              ), 
              passwordInfo(password_content: password,),

            ],
          ),
        ),
      );
     }
}

class passwordInfo extends StatefulWidget {
  String password_content;
  passwordInfo({
    Key? key,required this.password_content,
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
    String passwordStar='';
    return Text(passwordStar.padLeft(widget.password_content.length,'*'),style:  TextStyle(
      fontWeight: FontWeight.w500, fontSize: 24,
    ),);
  }
}

class formInputValue extends StatefulWidget {
  var content;

  formInputValue({
    Key? key,required this.content
  });

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
          Text(widget.content, style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 24,
          ),)
        ],
      ),
    );
  }
}

class formConstantText extends StatelessWidget {
  var content;

  formConstantText({
    Key? key,required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Row(
        children: [
          Text(content,style: TextStyle(
            color: Colors.grey.shade500, fontSize: 20, fontWeight: FontWeight.w300,
          ),)
        ],
      ),
    );
  }
}

Widget forwardChangeInfo() {
    return InkWell(
      child: const Icon(Icons.arrow_forward_ios_outlined),
       onTap: (){
       //action code when clicked
       print("The icon is clicked");
      },
    );
}
Widget backward() {
    return InkWell(
      child: const Icon(Icons.arrow_back_ios_new_sharp),
       onTap: (){
       //action code when clicked
       print("The icon is backward");
      },
    );
}
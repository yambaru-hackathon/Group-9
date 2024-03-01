import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(
      color: Colors.black,
    ),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        )),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInsignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(isLogin ? 'ログイン' : '同意して新規作成',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
    ),
  );
}
bool passwordConfirm (String pwd, String confirmpwd){
  if(pwd == confirmpwd)
    return true;
  else 
    return false;
}

Future<bool?> popUp (String content){
  return Fluttertoast.showToast(
                        msg: content,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
}

Widget formConstantText(String content){
  return Padding(
      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: Row(
        children: [
          Text(
            content,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
}

Widget FormOutputValue (String output){
  return Padding(
      padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
      child: Row(
        children: [
          Text(
            output,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
}

Widget Button(context, Function onTap) {
  return Padding(
    padding: const EdgeInsets.all(23.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent.shade200, // Background color
      ),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          '変更',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 22, color: Colors.black),
        ),
      ),
      onPressed: () {
        showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
          return onTap();
      }, );/* ボタンがタップされた時の処理 */
      }
    ),
  );
}

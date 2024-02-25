import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("アプリ名"),
        centerTitle: true, // タイトルを中央ぞろえにする
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "ユーザー名",
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "パスワード",
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(111, 17, 242, 1), // 背景色を指定
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // ボタンの角を丸くする
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0), // テキストの余白を設定
                    child: Text(
                      "ログイン",
                      style: TextStyle(
                          fontSize: 16, color: Colors.white), // テキストの大きさと色を調整
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "新しいアカウントを作成", // 新しいアカウント作成のテキスト
                style: TextStyle(color: Colors.blue), // テキストの色を青に設定
              ),
            ],
          ),
        ),
      ),
    );
  }
}

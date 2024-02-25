import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true, // タイトルを中央に配置
        elevation: 0.0, // タイトルの背景を削除
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ユーザー名',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                  color: Theme.of(context).primaryColor, // ボタンの背景色をテーマカラーにする
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // 新規アカウント作成ボタンが押されたときの処理を追加する
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // ボタンの角を丸くする
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0), // ボタンの内側の余白を設定
                    child: Text(
                      '新規アカウント作成',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

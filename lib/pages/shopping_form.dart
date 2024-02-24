import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('form'),
      ),
      body: const Center(
          child: Text('form', style: TextStyle(fontSize: 32.0))),
    );
  }
}
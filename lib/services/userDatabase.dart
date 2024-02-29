import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
class User{
  final String name;
  final String email;
  final String phone;
  final String password;

  User({required this.name, required this.email, required this.phone, required this.password});

 // factory User fromFirestore(Document Snapshot doc)
}
 
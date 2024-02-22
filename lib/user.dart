import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User{
  final String name;
  final String ph_num;
  final String email;
  final String password;

  User({
    required this.name, 
    required this.ph_num, 
    required this.email, 
    required this.password});

  factory User.FromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return User(
      name: data['name'], 
      ph_num: data['ph_num'],
       email: data['email'], 
       password: data['password']);
  }
}
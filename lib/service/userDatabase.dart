import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';

class UserModel{
  final String name;
  final String ph_num;
  final String email;
  final String password;

  UserModel({
    required this.name, 
    required this.ph_num, 
    required this.email, 
    required this.password});

  factory UserModel.FromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      name: data['name'], 
      ph_num: data['ph_num'],
       email: data['email'], 
       password: data['password']);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';

class UserModel{
  final String? id;
  final String name;
  final String email;
  final String ph_Num;
  final String password;

  UserModel({
    this.id,
    required this.name, 
    required this.ph_Num, 
    required this.email, 
    required this.password});

  factory UserModel.FromFirestore(DocumentSnapshot <Map<String, dynamic>> document){
    var data = document.data()!;
    return UserModel(
      id: document.id,
      name: data['name'], 
      ph_Num: data['phoneNumber'],
       email: data['email'], 
       password: data['password']);
  }
}
 
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';

class UserModel{
   String name;
   String ph_num;
   String email;
   String password;

  UserModel({
    required this.name, 
    required this.ph_num, 
    required this.email, 
    required this.password});

  factory UserModel.FromFirestore(DocumentSnapshot<Map<String,dynamic>> snapshot, SnapshotOptions? options,){
    final data = snapshot.data();
    return UserModel(
      name: data?['name'], 
      ph_num: data?['phoneNumber'],
       email: data?['email'], 
       password: data?['password']);
  }

}
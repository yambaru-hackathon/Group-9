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

class Post {
  String user_id;
  String date;
  String destination;
  String shoplist;

  Post({
    required this.user_id,
    required this.date,
    required this.destination,
    required this.shoplist
  }
  );

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      user_id: data?['userid'],
      date : data?['date'],
      destination: data?['destination'],
      shoplist: data?['shoplist'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (date != null) "date": '',
      if (destination != null) "destination": '',
      if (shoplist != null) "capital": '',
    };
  }
}
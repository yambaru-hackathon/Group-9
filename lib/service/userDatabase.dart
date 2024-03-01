import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:group_9_birumanchu/main.dart';

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


fetch(String id){
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print(data);
          usermodel.email = data['email'];
          usermodel.ph_num = data['phoneNumber'];
          usermodel.password = data['password'];
          usermodel.name = data['name'];
        },
        onError: (e) => print("Error getting document: $e"),
      );
   }


  
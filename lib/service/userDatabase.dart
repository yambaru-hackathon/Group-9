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

fetchpost(String id) async{
   final ref = FirebaseFirestore.instance.collection("posts").doc(id).withConverter(
      fromFirestore: Post.fromFirestore,
      toFirestore: (Post post, _) => post.toFirestore(),
    );
    final docSnap = await ref.get();
    user_post = docSnap.data()!; // Convert to City object
}

  
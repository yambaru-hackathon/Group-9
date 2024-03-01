import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user; 
    } catch(e){
      print("Error ${e.toString()}");
    }
    return null;
  }

  Future<User?> getcurrentUser () async{
    final _authCurrentUser = FirebaseAuth.instance.currentUser;
    try{
      return await _authCurrentUser;
    }
    catch(e){
      print("Error ${e.toString()}");
    }
    return null;
  }
  
  Future<dynamic> updatePassword (String newPassword) async {
    return await _auth.currentUser?.updatePassword(newPassword);
  }
  

}
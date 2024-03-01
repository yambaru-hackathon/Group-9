import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/Usersetting/account_page.dart';

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
}


fetchpost(String id) {
  final docRef = FirebaseFirestore.instance.collection('posts').doc(uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print(data);
          user_post.user_id = data['user_id'];
           user_post.date = data['date'];
           user_post.destination = data['destination'];
           user_post.shoplist = data['shoplist'];
          print(user_post.date + user_post.destination + user_post.shoplist);
          light = false;
        },
        onError: (e) => print("Error getting document: $e"),
      );
}

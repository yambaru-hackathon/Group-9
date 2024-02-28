import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:group_9_birumanchu/pages/add_room_page.dart';
import 'package:group_9_birumanchu/pages/chat_page.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('依頼'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddRoomPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat_room')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      return Card(
                        child: ListTile(
                          title: Text(document['name']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // アイテムを削除
                              await FirebaseFirestore.instance
                                  .collection('chat_room')
                                  .doc(document.id)
                                  .delete();
                            },
                          ),
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatPage(document['name']);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Text('読込中……'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

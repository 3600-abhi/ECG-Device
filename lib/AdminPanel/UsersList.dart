import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {


  Stream<QuerySnapshot> collectionsStream = FirebaseFirestore.instance.collection('accounts').snapshots();

  UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Users')),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionsStream,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError) {
            return Center(
              child: Text('Something went wrong !!'),
            );
          }
          else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map data = document.data() as Map;
                return ListTile(
                  title: Text(data['Name']),
                  subtitle: Text('Role : ${data['Role']}  Age : ${data['Age']}'),
                  onTap: () {},
                );
              }).toList()
            );
          }
        },
      ),
    );
  }
}

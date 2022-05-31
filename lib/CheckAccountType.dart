import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecg/AdminPanel/AdminPage.dart';
import 'package:ecg/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CheckAccountType extends StatelessWidget {

  String Name = "";
  String Age = "";
  String Role = "";

   CheckAccountType({Key? key}) : super(key: key);

   Future<String> CheckRole() async {
     String uid = FirebaseAuth.instance.currentUser!.uid;
     print('uid is  = $uid');

     String Role = "";
     Map data = {};

     await FirebaseFirestore.instance
         .collection('accounts')
         .doc(uid)
         .get()
         .then((DocumentSnapshot documentSnapshot) {
       if (documentSnapshot.exists) {
         print(documentSnapshot.data());
         data = documentSnapshot.data() as Map;
         Role = data['Role'] as String;
       } else {
         print('Something went wrong !!');
       }
     });

     Name = data['Name'];
     Age = data['Age'];

     print('role is = $Role');
     return Role;
   }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: CheckRole(),
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
          if(snapshot.data == 'admin') return AdminPage(Name: Name, Age: Age, Role: Role);
          else return HomePage();
        }
      },
    );
  }
}

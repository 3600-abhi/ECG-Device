import 'dart:convert';
import 'package:ecg/screens/homePage.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBUfGdMXN98KmdIAP1a9L85MtryGAVpX3U",
          authDomain: "ecgdevice-2dc8d.firebaseapp.com",
          databaseURL: "https://ecgdevice-2dc8d-default-rtdb.firebaseio.com",
          projectId: "ecgdevice-2dc8d",
          storageBucket: "ecgdevice-2dc8d.appspot.com",
          messagingSenderId: "68402212968",
          appId: "1:68402212968:web:a57ad185917b1f50428bdd",
          measurementId: "G-VVQ95HWC9W"
      ));
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      title: 'ECG',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong!"),
            );
          } else if (snapshot.hasData) {
            return homePage();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}

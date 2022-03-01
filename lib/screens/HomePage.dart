import 'package:ecg/screens/EnterPatientDetails.dart';
import 'package:ecg/screens/EnterPatientID.dart';
import 'package:ecg/screens/ReportsList.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ECG Device')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('ECG Test'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnterPatientDetails()));
              },
            ),

            SizedBox(height: 15),

            ElevatedButton(
              child: Text('Previous ECG Reports'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnterpatientID()));
              },
            ),

            SizedBox(height: 15),
            ElevatedButton(
              child: Text('Sign out'),
              onPressed: () {
                signInAuthUsingEmailAndPassword.signOutAuth().then((value) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login())));
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ecg/ECGGraph.dart';
import 'package:ecg/screens/ReportsList.dart';
import 'package:ecg/screens/ShowReport.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:ecg/services/RTDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';

class EnterpatientID extends StatefulWidget {
  const EnterpatientID({Key? key}) : super(key: key);

  @override
  _EnterpatientIDState createState() => _EnterpatientIDState();
}

class _EnterpatientIDState extends State<EnterpatientID> {
  TextEditingController patientIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ECG Data Variation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Patient ID',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              SizedBox(height: 50),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  minWidth: 150,
                ),
                //padding: EdgeInsets.only(left: 280, right: 280),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: patientIDController,
                  decoration: InputDecoration(
                      hintText: 'Enter Patient ID',
                      labelText: 'Patient ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                child: Text('See Reports List'),
                onPressed: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportsList(
                            patientId: patientIDController.text.toString().trim(),
                          )));



                },
              ),
              SizedBox(height: 10),
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
        ));
  }
}

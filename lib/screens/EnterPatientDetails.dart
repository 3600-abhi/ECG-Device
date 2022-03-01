import 'package:ecg/ECGGraph.dart';
import 'package:ecg/screens/ShowReport.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:ecg/services/RTDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';

class EnterPatientDetails extends StatefulWidget {
  const EnterPatientDetails({Key? key}) : super(key: key);

  @override
  _EnterPatientDetailsState createState() => _EnterPatientDetailsState();
}

class _EnterPatientDetailsState extends State<EnterPatientDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController patientIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('ECG Data Variation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Patient Details',
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
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Enter Patient Name',
                      labelText: 'Patient Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  minWidth: 150,
                ),
                //padding: EdgeInsets.only(left: 280, right: 280),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  decoration: InputDecoration(
                      hintText: 'Enter Patient Age',
                      labelText: 'Patient Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              SizedBox(height: 20),
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
                child: Text('Show Report'),
                onPressed: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowReport(
                                patientName:
                                    nameController.text.toString().trim(),
                                age: ageController.text.toString().trim(),
                                patientId:
                                    patientIDController.text.toString().trim(),
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

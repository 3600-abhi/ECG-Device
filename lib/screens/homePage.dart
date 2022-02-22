import 'package:ecg/ECGGraph.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';


class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
                    color: Colors.teal,
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
                child:
                Text('ECG Representation', style: TextStyle(fontSize: 30)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ECGGraph(
                            patientName: nameController.text.toString().trim(),
                            age: ageController.text.toString().trim(),
                            patientId: patientIDController.text.toString().trim(),
                          )));
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Sign out', style: TextStyle(fontSize: 30)),
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

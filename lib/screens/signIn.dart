import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecg/CheckAccountType.dart';
import 'package:ecg/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';
import '../AdminPanel/AdminPage.dart';
import '../main.dart';
import 'EnterPatientDetails.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',
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
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              SizedBox(height: 25),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  minWidth: 150,
                ),
                //padding: EdgeInsets.only(left: 280, right: 280),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                child: ElevatedButton(
                    child: Text('Login', style: TextStyle(fontSize: 30)),
                    onPressed: () async {
                      signInAuthUsingEmailAndPassword
                          .signInAuth(context, emailController.text.trim(),
                              passwordController.text.trim())
                          .then((value) async {
                        if (value != null) {
                          const snackBar = SnackBar(
                            content: Text('Invalid Email or Password'),
                          );
                          navigatorKey.currentState!
                              .popUntil((route) => route.isFirst);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckAccountType()));
                        }
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

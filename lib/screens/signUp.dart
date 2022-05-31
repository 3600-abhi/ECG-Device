import 'package:ecg/screens/EnterPatientDetails.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';

class signUp extends StatelessWidget {
  signUp({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create operator Account')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Create an user Account',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            SizedBox(height: 50),
            Container(
              constraints: BoxConstraints(
                maxWidth: 400,
                minWidth: 150,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Enter your Full Name',
                    labelText: 'Name',
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
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: ageController,
                decoration: InputDecoration(
                    hintText: 'Enter your Age',
                    labelText: 'Age',
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
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: contactController,
                decoration: InputDecoration(
                    hintText: 'Enter your Contact Number',
                    labelText: 'Contact number',
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
                child: Text('Create Account', style: TextStyle(fontSize: 30)),
                onPressed: () async {
                  signInAuthUsingEmailAndPassword.signUpAuth(
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      nameController.text.trim(),
                      ageController.text.trim(),
                      contactController.text.trim());
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

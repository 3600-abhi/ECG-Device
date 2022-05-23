import 'package:ecg/AdminPanel/AdminLogin.dart';
import 'package:ecg/screens/EnterPatientDetails.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';


class signUp extends StatelessWidget {
  signUp({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign Up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                )),
            SizedBox(height: 50),
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
                child: Text('Sign Up', style: TextStyle(fontSize: 30)),
                onPressed: () {
                  signInAuthUsingEmailAndPassword
                      .signUpAuth(context, emailController.text.trim(),
                      passwordController.text.trim())
                      .then((value) => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EnterPatientDetails())));
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ?", style: TextStyle(fontSize: 25)),
                TextButton(
                  child: Text('SignIn', style: TextStyle(fontSize: 25)),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AdminLogin()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

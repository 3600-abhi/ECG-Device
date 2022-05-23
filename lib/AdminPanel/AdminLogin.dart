import 'package:ecg/screens/HomePage.dart';
import 'package:ecg/screens/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';
import '../main.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login as Admin')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login as Admin',
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
                    child: Text('Sign In', style: TextStyle(fontSize: 30)),
                    onPressed: () {
                      signInAuthUsingEmailAndPassword
                          .signInAuth(context, emailController.text.trim(),
                          passwordController.text.trim())
                          .then((value) {
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
                                  builder: (context) => HomePage()));
                        }
                      });
                    }),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?", style: TextStyle(fontSize: 25)),
                  TextButton(
                    child: Text('SignUp', style: TextStyle(fontSize: 25)),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => signUp()));
                    },
                  )
                ],
              )
            ],

          ),
        ),
      ),
    );
  }
}

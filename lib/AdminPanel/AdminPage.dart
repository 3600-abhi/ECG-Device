import 'package:ecg/AdminPanel/UsersList.dart';
import 'package:ecg/screens/HomePage.dart';
import 'package:ecg/screens/signIn.dart';
import 'package:ecg/screens/signUp.dart';
import 'package:flutter/material.dart';
import 'package:ecg/services/authentication.dart';
import 'package:flutter/services.dart';

class AdminPage extends StatelessWidget {
  String Name;
  String Age;
  String Role;

  AdminPage(
      {Key? key, required this.Name, required this.Age, required this.Role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Admin Page',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Welcome $Name'),
                decoration: BoxDecoration(color: Colors.red.shade200),
              ),


              ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Homepage'),
                  onTap: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    Navigator.pop(context);
                  }),


              ListTile(
                leading: Icon(Icons.supervised_user_circle_sharp),
                title: Text('See all Users'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UsersList()));
                },
              ),


              ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Create user Account'),
                  onTap: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signUp()));
                    Navigator.pop(context);
                  }),


              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign Out'),
                  onTap: () => signInAuthUsingEmailAndPassword
                      .signOutAuth()
                      .then((value) => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login())))),
            ],
          ),
        ),
        body: Center(
          child: Text('$Name',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red)),
        ));
  }
}

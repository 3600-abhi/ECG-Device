import 'package:cloud_firestore/cloud_firestore.dart';

class FS {

  static Future saveUserDetails(String uid, String Name, String Age, String contact) async {
    return await FirebaseFirestore.instance.collection('accounts').doc(uid).set({
      'Name' : Name,
      'Age' : Age,
      'Contact Number' : contact,
      'Role' : 'user'
    });
  }


}
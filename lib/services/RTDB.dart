import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class RTDB {
  static Future<List<List<double>>> fetchData() async {
    print('Hello Abhishek 1');
    Query query = await FirebaseDatabase.instance.ref();
    print('Hello Abhishek 2');
    DataSnapshot event = await query.get();
    print('Hello Abhishek 3');
    Map ECGData = event.value as Map;
    print('Hello Abhishek 4');

    print(ECGData);

    List<List<double>> deviceData = [];
    List<double> temp = [];


    ECGData.values.forEach((map) {
      // print(map);
      map.values.forEach((str) {
        String val = '';
        for(int i = 0 ; i < str.length ; i++) {
          if(str[i] == ',') {
            temp.add(double.parse(val));
            val = '';
          }
          else val += str[i];
        }
      });
      deviceData.add(temp);
      temp = [];
    });

    for(int i = 0 ; i < deviceData.length ; i++) {
      print(deviceData[i][0]);
    }

    List<List<double>> data = [];
    List<double> tempData = [];

    for(int i = 0 ; i < deviceData.length ; i++) {
      if(i == 3 || i == 7 || i == 11) {
        data.add(tempData);
        tempData = [];
      }
      else tempData.addAll(deviceData[i]);
    }

    tempData = [];
    for(int i = 0 ; i < 4 ; i++) tempData.addAll(deviceData[0]);
    data.add(tempData);

    // print('data size is ${data.length}');

    return data;

  }
}





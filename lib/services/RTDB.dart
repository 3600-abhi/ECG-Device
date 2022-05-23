import 'dart:convert';
import 'package:ecg/PatientPreviousDataClass.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class RTDB {

  static Future<List<List<List<double>>>> fetchData() async {
    print('Hello');
    Query query = await FirebaseDatabase.instance.ref();
    DataSnapshot event = await query.get();
    Map ECGData = event.value as Map;

    // print(ECGData);

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


    List<List<List<double>>> data = [];
    List<List<double>> tempData = [];

    print('deviceData length is : ${deviceData.length}');

    for(int i = 0 ; i < deviceData.length ; i++) {
      if(i == 3 || i == 7 || i == 11) {
        tempData.add(deviceData[i]);
        data.add(tempData);
        tempData = [];
      }
      else tempData.add(deviceData[i]);
    }

    tempData = [];
    for(int i = 0 ; i < 4 ; i++) tempData.add(deviceData[0]);
    data.add(tempData);

    for(int i = 0 ; i < data.length ; i++) {
      print('length is : ${data[i].length}');
    }

    return data;
  }


  static Future<List<List<List<double>>>> insertAndShowReport(String patientID,String patientName,String patientAge) async {

    String patientECGData = await rootBundle.loadString('asset/data_ecg.json') ;
    // print(patientECGData);

    final ECGData = jsonDecode(patientECGData);


    DataSnapshot event = await FirebaseDatabase.instance.ref().child(patientID).get();

    // Evaluate date and time
    DateTime currentDateTime = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(currentDateTime);
    String formattedTime = DateFormat.Hms().format(currentDateTime);
    String currentTime = formattedTime;
    String currentDate = formattedDate;

    // Inserting patient details in RTDB
    await FirebaseDatabase.instance
        .ref(patientID)
        .child('Patient Details')
        .update({'Name': patientName, 'Age': patientAge});


    // Inserting patient ECG Data in RTDB
    await FirebaseDatabase.instance
        .ref(patientID)
        .child(currentDate)
        .child(currentTime)
        .set(ECGData);




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


    List<List<List<double>>> data = [];
    List<List<double>> tempData = [];

    print('deviceData length is : ${deviceData.length}');

    for(int i = 0 ; i < deviceData.length ; i++) {
      if(i == 3 || i == 7 || i == 11) {
        tempData.add(deviceData[i]);
        data.add(tempData);
        tempData = [];
      }
      else tempData.add(deviceData[i]);
    }

    tempData = [];
    for(int i = 0 ; i < 4 ; i++) tempData.add(deviceData[0]);
    data.add(tempData);

    for(int i = 0 ; i < data.length ; i++) {
      print('length is : ${data[i].length}');
    }

    return data;

  }


  static Future<PatientPreviousDataClass> PatientPreviousData(String patientID) async {
    print(patientID.length);
    print(patientID);
    print('Hello');

    Query query = await FirebaseDatabase.instance.ref(patientID);
    DataSnapshot event = await query.get();
    Map ECGData = event.value as Map;

    // print(ECGData);


    PatientPreviousDataClass data = PatientPreviousDataClass(Name: '', age: '');

    print('Hello');

    ECGData.keys.forEach((date) {
      print(date);
      if(date == 'Patient Details') {
        print('${ECGData['Patient Details']['Name']}');
        data.Name = ECGData['Patient Details']['Name'];
        data.age = ECGData['Patient Details']['Age'];
      }
      else {
        ECGData[date].keys.forEach((time) {
          print(time);
          data.PatientPreviousDataList.add(DateAndTime(date: date, time: time));
        });
      }
    });

    print('Bro');
    print('Name : ${data.Name}');
    print('Age :${data.age}');
    print('Checking Date : ${data.PatientPreviousDataList[0].date}');
    print('Checking Time : ${data.PatientPreviousDataList[0].time}');

    return data;

  }


  static Future<List<List<List<double>>>> FetchReport(String patientId,String date,String time) async {
    print('Hello');
    DataSnapshot event = await FirebaseDatabase.instance.ref(patientId).child(date).child(time).get();
    Map ECGData = event.value as Map;

    // print(ECGData);

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


    List<List<List<double>>> data = [];
    List<List<double>> tempData = [];

    print('deviceData length is : ${deviceData.length}');

    for(int i = 0 ; i < deviceData.length ; i++) {
      if(i == 3 || i == 7 || i == 11) {
        tempData.add(deviceData[i]);
        data.add(tempData);
        tempData = [];
      }
      else tempData.add(deviceData[i]);
    }

    tempData = [];
    for(int i = 0 ; i < 4 ; i++) tempData.add(deviceData[0]);
    data.add(tempData);

    for(int i = 0 ; i < data.length ; i++) {
      print('length is : ${data[i].length}');
    }

    return data;
  }

  static Future deleteData(String patientId,String date,String time) async {
    await FirebaseDatabase.instance.ref(patientId).child(date).child(time).remove();
  }
}





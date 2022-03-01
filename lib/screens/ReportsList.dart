import 'package:ecg/PatientPreviousDataClass.dart';
import 'package:ecg/screens/ShowPreviousReport.dart';
import 'package:ecg/services/RTDB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReportsList extends StatefulWidget {

  String patientId = '';

   ReportsList({Key? key,required this.patientId}) : super(key: key);

  @override
  _ReportsListState createState() => _ReportsListState(patientId: patientId);
}

class _ReportsListState extends State<ReportsList> {

  String patientId = '';

  _ReportsListState({required this.patientId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Report')),
      body: FutureBuilder<PatientPreviousDataClass>(
        future: RTDB.PatientPreviousData(patientId),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitWave(
                    color: Colors.red,
                  ),
                  SizedBox(height: 15),
                  Text('Reports is loading Please wait...',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ))
                ],
              ),
            );
          }
          else if(snapshot.data == null) {
            return Center(
              child: Text('NULL'),
            );
          }
          else {
            print('Patient Name From Report List : ${snapshot.data!.Name}');
            return ListView.separated(
                separatorBuilder: (context,index) => Divider(color: Colors.black,),
                itemCount: snapshot.data!.PatientPreviousDataList.length,
                itemBuilder: (context,index) {
                  String date = snapshot.data!.PatientPreviousDataList[index].date;
                  String time = snapshot.data!.PatientPreviousDataList[index].time;
                  return ListTile(
                    leading: Text('${index+1}',style: TextStyle(fontSize: 20)),
                    title: Text('ECG Report ${index+1}'),
                    subtitle: Text('Date : $date  Time : $time'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPreviousReport(
                        patientId: patientId,
                        date: date,
                        time: time,
                      )));
                    },
                  );
                },
            );
            // return Center(
            //   child: Text('Hello'),
            // );
          }
        },
      )
    );
  }
}

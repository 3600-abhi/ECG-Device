import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:ecg/services/RTDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:async';
import 'dart:js' as js;
import 'package:numerus/numerus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowReport extends StatefulWidget {
  String patientName = '';
  String age = '';
  String patientId = '';

  ShowReport({Key? key, required this.patientName, required this.age, required this.patientId}) : super(key: key);

  @override
  State<ShowReport> createState() =>
      _ShowReportState(patientName: patientName, age: age, patientId: patientId);
}

class _ShowReportState extends State<ShowReport> {
  _ShowReportState({required this.patientName, required this.age, required this.patientId});

  String patientName = '';
  String age = '';
  String patientId = '';

  ScreenshotController screenshotController = ScreenshotController();

  List<String> label = [
    'aVR',
    'v1',
    'v4',
    'aVL',
    'v2',
    'v5',
    'aVF',
    'v3',
    'v6'
  ];

  Widget partitionLine(int labelIndex) {
    return Container(
      child: Column(
        children: [
          Text('${label[labelIndex]}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Container(
            height: 90,
            child: VerticalDivider(
              color: Colors.black,
              thickness: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget partition(List<double> data, int labelIndex, int idx) {
    return Container(
      height: 150,
      child: Row(
        children: [
          Container(child: Sparkline(data: data, lineColor: Colors.black, lineWidth: 2)),
          labelIndex < label.length && idx != 3 && idx != 7 && idx != 11
              ? partitionLine(labelIndex)
              : Text(''),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int labelIndex = 0;
    int idx = 0;
    int graphNum = 1;

    // Evaluate date and time
    DateTime currentDateTime = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(currentDateTime);
    String formattedTime = DateFormat.Hms().format(currentDateTime);
    String currentTime = formattedTime;
    String currentDate = formattedDate;


    return Scaffold(
      body: FutureBuilder<List<List<List<double>>>>(
        future: RTDB.insertAndShowReport(patientId, patientName, age),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitWave(
                    color: Colors.red,
                  ),
                  SizedBox(height: 15),
                  Text('ECG Report is loading Please wait...',style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ))
                ],
              ),
            );
          } else {
            return ListView(
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [

                        SizedBox(height: 15),

                        Container(
                          // padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Patient Name : ${widget.patientName}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Text('Patient Age : ${widget.age}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Text('Patient ID : ${widget.patientId}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),

                              SizedBox(width: 10),
                              Text('Date : ${currentDate}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),

                              SizedBox(width: 10),
                              Text('Time : ${currentTime}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          height: 900,
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: GridPaper(
                            interval: 40,
                            color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: snapshot.data!.map((data1) {
                                return Container(
                                    padding: EdgeInsets.only(
                                        left: 0.01, right: 0.01),
                                    child: Row(
                                      children: [

                                        SizedBox(width: 10),

                                        Container(
                                          width : 50,
                                          child: Text(
                                              '${(graphNum++).toRomanNumeralString()}    ',
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        Expanded(
                                            child: Container(
                                              height :200,
                                              child: Row(
                                                  children: data1.map((data2) {
                                                    return idx == 3 ||
                                                        idx == 7 ||
                                                        idx == 11
                                                        ? partition(
                                                        data2, labelIndex, idx++)
                                                        : partition(
                                                        data2, labelIndex++, idx++);
                                                  }).toList()),
                                            ))
                                      ],
                                    ));
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    child: Text('Download ECG Report as Image'),
                    onPressed: () async {
                      screenshotController
                          .capture()
                          .then((Uint8List? screenshot) {
                        final _base64 = base64Encode(screenshot!);
                        final anchor = AnchorElement(
                            href:
                            'data:application/octet-stream;base64,$_base64')
                          ..download = "ECG_Report.png"
                          ..target = 'blank';

                        document.body!.append(anchor);
                        anchor.click();
                        anchor.remove();
                      });
                    },
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    child: Text('Download ECG Report as Pdf'),
                    onPressed: () async {
                      screenshotController
                          .capture()
                          .then((Uint8List? screenshot) {
                        //Create a new PDF document
                        PdfDocument document = PdfDocument();
                        final page = document.pages.add();

                        page.graphics.drawString('ECG Report',
                            PdfStandardFont(PdfFontFamily.helvetica, 30));

                        page.graphics.drawImage(PdfBitmap(screenshot!),
                            Rect.fromLTRB(0, 100, 440, 550));

                        //Save the document
                        List<int> bytes = document.save();

                        //Dispose the document
                        document.dispose();

                        js.context['pdfData'] = base64.encode(bytes);
                        js.context['filename'] = 'ECG_Report.pdf';
                        Timer.run(() {
                          js.context.callMethod('download');
                        });
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          }
        },
      ),
    );
  }
}

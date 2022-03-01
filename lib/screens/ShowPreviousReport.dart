import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:ecg/services/RTDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:async';
import 'dart:js' as js;
import 'package:numerus/numerus.dart';

class ShowPreviousReport extends StatefulWidget {

  String patientId = '';
  String date = '';
  String time = '';

  ShowPreviousReport(
      {Key? key,
        required this.patientId,
        required this.date,
        required this.time})
      : super(key: key);

  @override
  State<ShowPreviousReport> createState() =>
      _ShowPreviousReportState(patientId: patientId, date: date, time: time);
}

class _ShowPreviousReportState extends State<ShowPreviousReport> {
  _ShowPreviousReportState(
      {required this.patientId, required this.date, required this.time});

  String patientId = '';
  String date = '';
  String time = '';

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
      height: 140,
      child: Column(
        children: [
          Text('${label[labelIndex]}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          Container(
            height: 70,
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
          Container(height : 80,child: Sparkline(data: data, lineColor: Colors.black, lineWidth: 2)),
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
    return Scaffold(
      body: FutureBuilder<List<List<List<double>>>>(
        future: RTDB.FetchReport(patientId, date, time),
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
                  Text('Report is loading Please wait...',style: TextStyle(
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
                                        Text(
                                            '${(graphNum++).toRomanNumeralString()}    ',
                                            style: TextStyle(
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold)),
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
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
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
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
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

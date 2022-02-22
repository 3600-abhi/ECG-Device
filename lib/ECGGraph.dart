import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:ecg/services/RTDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:async';
import 'dart:js' as js;
import 'package:numerus/numerus.dart';





class ECGGraph extends StatefulWidget {
  String patientName = '';
  String age = '';
  String patientId = '';


  ECGGraph(
      {Key? key,
        required this.patientName,
        required this.age,
        required this.patientId})
      : super(key: key);

  @override
  State<ECGGraph> createState() => _ECGGraphState(patientName: patientName,age: age,patientId: patientId);
}

class _ECGGraphState extends State<ECGGraph> {

  _ECGGraphState({required this.patientName,required this.age,required this.patientId});

  String patientName = '';
  String age = '';
  String patientId = '';




  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    int graphNum = 1;
    return Scaffold(
      body: FutureBuilder<List<List<double>>>(
        future: RTDB.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                'ECG Report is loading Please wait...',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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
                        Container(
                          padding: EdgeInsets.only(top: 0.01, left: 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Patient Name : ${widget.patientName}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text('Patient Age : ${widget.age}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text('Patient ID : ${widget.patientId}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          height: 700,
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: GridPaper(
                            interval: 40,
                            color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: snapshot.data!.map((data) {
                                return Container(
                                    padding: EdgeInsets.only(left: 0.01, right: 0.01),
                                    child: Row(
                                      children: [
                                        Text('${(graphNum++).toRomanNumeralString()}    ',
                                            style: TextStyle(
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Sparkline(
                                              data: data,
                                              lineColor: Colors.black,
                                              lineWidth: 2),
                                        ),
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
                      screenshotController.capture().then((Uint8List? screenshot) {
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



                      screenshotController.capture().then((Uint8List? screenshot) {
                        //Create a new PDF document
                        PdfDocument document = PdfDocument();
                        final page = document.pages.add();

                        page.graphics.drawString('ECG Report', PdfStandardFont(PdfFontFamily.helvetica, 30));

                        page.graphics.drawImage(PdfBitmap(screenshot!), Rect.fromLTRB(0, 100, 440, 550));

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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:real_time_chart/real_time_chart.dart';

class Shelf extends StatefulWidget {
  static String id = 'Shelf_screen';

  Shelf({Key? key, required this.shelfNo, required this.item})
      : super(key: key);
  final dynamic shelfNo;
  final dynamic item;

  @override
  _ShelfState createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> with SingleTickerProviderStateMixin {
  int cnt = 0;
  String docId = 'T0';
  int oldfieldname = 0;
  int fieldname = 50;

  final _firestore = FirebaseFirestore.instance;
  late AnimationController _controller;
  late Animation<double>? _animation; // Make animation nullable
  late Timer _timer;
  Map<String, int> sensorData = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 1, milliseconds: 200), // Animation duration
    );
    _animation = Tween<double>(begin: oldfieldname * 100, end: fieldname * 100)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      docId = 'T${cnt}';
      await processCertainDocument(docId);
    });
  }

  Future<void> processCertainDocument(String documentId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection('Shelf1');
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc(documentId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> documentData =
          documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        oldfieldname = fieldname;
        fieldname = documentData['pred'];
        documentData['values'].forEach((key, value) {
          sensorData[key] = value;
          // print(key);
        });
        cnt += 1;
      });
    } else {
      print('Document with ID $documentId does not exist.');
    }
  }

  int getFieldValue() {
    return fieldname;
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    final stream = getData();
    if (fieldname < 33.33) {
      color = Colors.red;
    } else if (fieldname < 66.67) {
      color = Colors.yellow;
    } else {
      color = Colors.green;
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(102, 255, 255, 1),
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0,
          centerTitle: true,
          // backgroundColor: const Color.fromRGBO(102, 255, 255, 1),
          title: Text(
            'Shelf${widget.shelfNo}: Milk ',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
                wordSpacing: 5,
                color: Colors.black
                // color: Colors.lightBlueAccent,
                ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Health-O-Meter',
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                      // padding: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      child: CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 25.0,
                        percent: fieldname / 100, // Use animated value
                        center: Text(
                          '${fieldname}',
                          style: TextStyle(fontSize: 40.0, color: color),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: color,
                      ),
                    )),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-4: Provides concentration of CNG, CH\u2084',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("1"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-6: Provides concentration of C\u2083H\u2088,C\u2084H\u2081\u2080',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("2"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-7: Provides concentration of CO',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("3"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-5: Provides concentration of H\u2082, LPG, CH\u2084',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("4"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-8: Provides Concentration of H\u2082',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("5"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-135: Provides Concentration of NH\u2083, ',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("6"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sensor MQ-2:',
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                16, 222, 168, 1), // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Optional: for rounded corners
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RealTimeGraph(
                            stream: getSesnsorData("7"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Stream<double> getData() {
    return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return (fieldname * 10.0);
    }).asBroadcastStream();
  }

  Stream<double> getSesnsorData(i) {
    return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return (sensorData[i]! * 1.0);
    }).asBroadcastStream();
  }
}

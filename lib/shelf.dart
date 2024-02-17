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
  int fieldname = 1;

  final _firestore = FirebaseFirestore.instance;
  late AnimationController _controller;
  late Animation<double>? _animation; // Make animation nullable
  late Timer _timer;

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
    // _controller = AnimationController(
    //   vsync: this,
    //   duration:
    //       const Duration(seconds: 1, milliseconds: 200), // Animation duration
    // );
    // _animation = Tween<double>(begin: oldfieldname * 100, end: fieldname * 100)
    //     .animate(_controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    // _controller.forward(); // Start the animation
  }

  Future<void> processCertainDocument(String documentId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference =
        firestore.collection('Prediction');
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc(documentId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> documentData =
          documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        oldfieldname = fieldname;
        fieldname = documentData['pred'];
        // print(fieldname);

        // _animation =
        //     Tween<double>(begin: oldfieldname * 100, end: fieldname * 100)
        //         .animate(_controller)
        //       ..addListener(() {
        //         setState(() {});
        //       });

        // _controller.forward();
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
        extendBody: true,
        appBar: AppBar(
          title: Text('Shelf ${widget.shelfNo} : ${widget.item} '),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 10.0,
                    percent: fieldname / 100, // Use animated value
                    center: Text(
                      '${fieldname}',
                      style: TextStyle(fontSize: 40.0, color: color),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: color,
                  ),
                )),
                // Display a real-time graph of positive data
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RealTimeGraph(
                      stream: stream,
                    ),
                  ),
                ),

                // Display a real-time graph of positive data as points
                const SizedBox(height: 32),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RealTimeGraph(
                      stream: stream,
                      displayMode: ChartDisplay.points,
                    ),
                  ),
                ),

                // Display a real-time graph of positive and negative data
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Supports negative values :',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RealTimeGraph(
                      stream: stream.map((value) => value - 150),
                      supportNegativeValuesDisplay: true,
                      xAxisColor: Colors.black12,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RealTimeGraph(
                      stream: stream.map((value) => value - 150),
                      supportNegativeValuesDisplay: true,
                      displayMode: ChartDisplay.points,
                      xAxisColor: Colors.black12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Stream<double> getData() {
    return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return (fieldname*10.0);
    }).asBroadcastStream();
  }
}

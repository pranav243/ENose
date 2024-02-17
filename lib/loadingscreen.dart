import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'summary.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late List<String> shelves;

  @override
  void initState() {
    shelves = List.generate(10, (index) => 'Shelf${index + 1}');
    initializeData();

    // Call your async function here
  }

  Future<void> initializeData() async {
    List<List<int>> freqList = await getFrequencyData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Summary(freqList: freqList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var spinKit = SpinKitWanderingCubes(color: Colors.black, size: 50.0);
    var spinKit = const SpinKitDualRing(
      color: Color(0xFF09648C),
      size: 150.0,
      lineWidth: 20,
    );

    return Scaffold(
      body: Center(
        child: spinKit,
      ),
    );
  }

  Future<List<List<int>>> getFrequencyData() async {
    List<List<int>> frequencyCounts = [
      [0, 0, 0],
      [],
      [],
      []
    ]; // Initialize counts for each range
    int pred = 0;
    // Iterate through shelves
    for (String shelf in shelves) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection(shelf)
            .doc('Tfinal')
            .get();
        if (snapshot.exists) {
          // setState(() {
          pred = snapshot['pred'] ?? 0.0;
          print(pred);
          if (pred >= 0 && pred <= 30) {
            frequencyCounts[0][0]++;
            frequencyCounts[1].add(pred);
          } else if (pred > 30 && pred <= 70) {
            frequencyCounts[0][1]++;
            frequencyCounts[2].add(pred);
          } else if (pred > 70 && pred <= 100) {
            frequencyCounts[0][2]++;
            frequencyCounts[3].add(pred);
          }
          // });
        } else {
          print('$shelf Document does not exist');
        }
      } catch (e) {
        print('Error getting document: $e');
      }
    }

    return frequencyCounts;
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FrequencyChart extends StatefulWidget {
//   @override
//   _FrequencyChartState createState() => _FrequencyChartState();
// }

// class _FrequencyChartState extends State<FrequencyChart> {
//   late List<String> shelves;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize shelves list with shelf names
//     shelves = List.generate(10, (index) => 'Shelf${index + 1}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Frequency Chart'),
//       ),
      // body: FutureBuilder<List<int>>(
      //   future: getFrequencyData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else {
      //       // Display frequency chart using snapshot.data
      //       return Center(
      //         child: Container(
      //           width: 300,
      //           height: 300,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text('Frequency Chart'),
      //               SizedBox(height: 20),
      //               Text('0-30: ${snapshot.data![0]}'),
      //               Text('30-70: ${snapshot.data![1]}'),
      //               Text('70-100: ${snapshot.data![2]}'),
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
    // );
  // }

//   Future<List<int>> getFrequencyData() async {
//     List<int> frequencyCounts = [0, 0, 0]; // Initialize counts for each range
//     int pred = 0;
//     // Iterate through shelves
//     for (String shelf in shelves) {
//       try {
//         DocumentSnapshot snapshot = await FirebaseFirestore.instance
//             .collection(shelf)
//             .doc('Tfinal')
//             .get();
//         if (snapshot.exists) {
//           // setState(() {
//           pred = snapshot['pred'] ?? 0.0;
//           print(pred);
//           if (pred >= 0 && pred <= 30) {
//             frequencyCounts[0]++;
//           } else if (pred > 30 && pred <= 70) {
//             frequencyCounts[1]++;
//           } else if (pred > 70 && pred <= 100) {
//             frequencyCounts[2]++;
//           }
//           // });
//         } else {
//           print('$shelf Document does not exist');
//         }
//       } catch (e) {
//         print('Error getting document: $e');
//       }
//       // Classify 'pred' value into ranges and update counts
//       // if (pred >= 0 && pred <= 0.3) {
//       //   frequencyCounts[0]++;
//       // } else if (pred > 0.3 && pred <= 0.7) {
//       //   frequencyCounts[1]++;
//       // } else if (pred > 0.7 && pred <= 1) {
//       //   frequencyCounts[2]++;
//       // }
//     }

//     return frequencyCounts;
//   }
// }

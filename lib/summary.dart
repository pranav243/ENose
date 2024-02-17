import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'frequencyChart.dart';

class Summary extends StatefulWidget {
  // static String id = 'summary_screen';

  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FrequencyChart(),
            ),
            ElevatedButton(
              child: Text("Home"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            )
          ],
        ),
      ),
    );
  }
}

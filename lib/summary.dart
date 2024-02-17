import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'frequencyChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'indicator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'widgets.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  // static String id = 'summary_screen';

  const Summary({Key? key, this.freqList}) : super(key: key);
  final dynamic freqList;

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  // late List<String> shelves;
  var showingTooltip = -1;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
    // Initialize shelves list with shelf names
    // shelves = List.generate(10, (index) => 'Shelf${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: const Color.fromRGBO(102, 255, 255, 1),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 6, // Blur radius
                offset: const Offset(0, 3), // Offset
              ),
            ],
          ),
          child: BottomNavBar(0, 1, context),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          centerTitle: true,
          elevation: 0,
          // backgroundColor: Color.fromARGB(133, 125, 252, 247),
          leadingWidth: 0,
          title: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: GradientText(
              "Summary",
              gradientDirection: GradientDirection.ttb,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  wordSpacing: 5
                  // color: Colors.lightBlueAccent,
                  ),
              colors: [Colors.black, Colors.black],
            ),
            // ],
            // ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              // height: ScreenUtil().setHeight(3000),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    const Text(
                      "Shelf Health Distribution",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Indicator(
                            color: Colors.green,
                            text: '>70%',
                            isSquare: false,
                            size: 16,
                            textColor: Colors.black),
                        Indicator(
                            color: Colors.yellow,
                            text: '30-70%',
                            isSquare: false,
                            size: 16,
                            textColor: Colors.black),
                        Indicator(
                            color: Colors.red,
                            text: '<=30%',
                            isSquare: false,
                            size: 16,
                            textColor: Colors.black),
                      ],
                    ),
                    Container(
                      height: ScreenUtil().setHeight(500),
                      child: Expanded(
                        // child: FrequencyChart(),
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 10.0,
                            sections: [
                              PieChartSectionData(
                                  radius: ScreenUtil().setWidth(100),
                                  value: widget.freqList[0][0] * 1.0,
                                  // title: "<=30",
                                  color: Colors.red),
                              PieChartSectionData(
                                  radius: ScreenUtil().setWidth(100),
                                  value: widget.freqList[0][1] * 1.0,

                                  // title: "30-70",
                                  color: Colors.yellow),
                              PieChartSectionData(
                                  radius: ScreenUtil().setWidth(100),
                                  value: widget.freqList[0][2] * 1.0,

                                  // title: ">70",
                                  color: Colors.green)
                            ],
                            centerSpaceRadius: 50.0,
                            // read about it in the PieChartData section
                          ),
                          // swapAnimationDuration:
                          //     const Duration(milliseconds: 150), // Optional
                          // swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                    ),
                    // ),
                    // SizedBox(
                    //   height: ScreenUtil().setHeight(105),
                    // ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Total shelves guarded: ${widget.freqList[0][0] + widget.freqList[0][1] + widget.freqList[0][2]}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            fontSize: ScreenUtil().setSp(15),
                            wordSpacing: 5,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(250),
                      child: Expanded(
                          child: BarChart(
                        BarChartData(barGroups: getBarChart(1)
                            // barGroups: [
                            //   generateGroupData(1, 10),
                            //   generateGroupData(2, 18),
                            //   generateGroupData(3, 4),
                            //   generateGroupData(4, 11),
                            // ],
                            ),
                      )),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(105),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(250),
                      child: Expanded(
                          child: BarChart(
                        BarChartData(
                            // barGroups: [
                            //   generateGroupData(1, 10),
                            //   generateGroupData(2, 18),
                            //   generateGroupData(3, 4),
                            //   generateGroupData(4, 11),
                            // ],
                            barGroups: getBarChart(2)),
                      )),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(105),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(250),
                      child: Expanded(
                          child: BarChart(
                        BarChartData(barGroups: getBarChart(3)
                            // barGroups: [
                            //   generateGroupData(1, 10),
                            //   generateGroupData(2, 18),
                            //   generateGroupData(3, 4),
                            //   generateGroupData(4, 11),
                            // ],
                            ),
                      )),
                    ),
                    // ),
                  ],
                ),
              )),
        ));
  }

  BarChartGroupData generateGroupData(int x, int y,int color) {
    if (color==1){
      return BarChartGroupData(
      x: x,
      // showingTooltipIndicators: showingTooltip == x ? [0] : [],
      // barRods: [
      //   BarChartRodData(toY: y.toDouble())
      // ],
      barRods: [
      BarChartRodData(
        toY: y.toDouble(),
        color: Colors.red // Set the color of the bar
      ),
    ],
    );
    }
    else if (color==2){
      return BarChartGroupData(
      x: x,
      // showingTooltipIndicators: showingTooltip == x ? [0] : [],
      // barRods: [
      //   BarChartRodData(toY: y.toDouble())
      // ],
      barRods: [
      BarChartRodData(
        toY: y.toDouble(),
        color: Colors.yellow // Set the color of the bar
      ),
    ],
    );
    }
    else{
      return BarChartGroupData(
      x: x,
      // showingTooltipIndicators: showingTooltip == x ? [0] : [],
      // barRods: [
      //   BarChartRodData(toY: y.toDouble())
      // ],
      barRods: [
      BarChartRodData(
        toY: y.toDouble(),
        color: Colors.green // Set the color of the bar
      ),
    ],
    );
    }
    
  }

  List<BarChartGroupData> getBarChart(index) {
    List<BarChartGroupData> chart = [];
    int ctr = 1;
    for (int val in widget.freqList[index]) {
      BarChartGroupData x = generateGroupData(ctr, val,index);
      chart.add(x);
      ctr++;
    }
    return chart;
  }
}

// ignore_for_file: deprecated_member_use
import 'shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'summary.dart';
import 'widgets.dart';

class Home extends StatefulWidget {
  static String id = 'home_screen';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const companyName = "Company Name";
  Widget buildButton(number, item) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF408782), // Border color
        ),
        borderRadius: BorderRadius.circular(ScreenUtil().setHeight(16.0)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shelf ${number}",
                  style: const TextStyle(
                    color: Color(0xFF438883),
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(item),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Color(0xFF438883),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Shelf(shelfNo: number, item: item)));
              // Add functionality here
            },
          ),
        ],
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Color.fromRGBO(102, 255, 255, 1),
        // bottomNavigationBar: BottomNavigationBar(
        //     elevation: 1,
        //     selectedItemColor: Color.fromRGBO(102, 255, 255, 1),
        //     items: [
        //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.auto_graph), label: "Summary")
        //     ]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 6, // Blur radius
                offset: Offset(0, 3), // Offset
              ),
            ],
          ),
          child: BottomNavBar(1, 0, context),
        ),
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          centerTitle: true,
          elevation: 0,
          // backgroundColor: Color.fromARGB(133, 125, 252, 247),
          leadingWidth: 0,
          title: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                GradientText(
              "Quality Check",
              gradientDirection: GradientDirection.ttb,
              style: TextStyle(
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
        body: Container(
          // height: ScreenUtil().setHeight(1000),
          // color: Colors.black,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          // padding: EdgeInsets.all(10),
          child: Center(
              // child: SingleChildScrollView(
              child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  // SizedBox(
                  //   width: ScreenUtil().setWidth(50),
                  //   height: ScreenUtil().setHeight(55),
                  //   // child: const Padding(
                  //     // padding: EdgeInsets.all(11.5),
                  //     child: Text("<${companyName}>",style: TextStyle(
                  //       fontFamily: 'Poppins',
                  //       fontWeight: FontWeight.w500,
                  //       height: 36,
                  //       color: Colors.lightBlueAccent,
                  //     // )
                  //     ),
                  //   )),

                  buildButton(1, "Milk"),
                  buildButton(2, "Item2"),
                  buildButton(3, "Item3"),
                  buildButton(4, "Item4"),
                  buildButton(5, "Item5"),
                  buildButton(6, "Item6"),
                  buildButton(7, "Item7"),
                  buildButton(8, "Item8"),
                  buildButton(9, "Item9"),
                  buildButton(10, "Item10"),
                ],
              ))
            ],
            // )
            // ),
          )),
        ));
  }
}

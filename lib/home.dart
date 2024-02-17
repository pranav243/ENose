// ignore_for_file: deprecated_member_use
import 'shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  static String id = 'home_screen';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const companyName = "YOURCOMPANY";
  Widget buildButton(number, item) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().setHeight(16.0)),
        color: Colors.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Shelf ${number}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Text(item),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "QualityCheck x $companyName",
                  style: TextStyle( 
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              // buildScrollBar()
              buildButton(1, "Item1"),
              buildButton(2, "Item1"),
              buildButton(3, "Item1"),
              buildButton(4, "Item1"),
              buildButton(5, "Item1"),
              buildButton(6, "Item1"),
              buildButton(7, "Item1"),
              buildButton(8, "Item1"),
              buildButton(9, "Item1"),
              buildButton(10, "Item1"),
            ],
          )),
        ));
  }
}

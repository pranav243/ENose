import 'package:flutter/material.dart';
import 'package:test/loadingscreen.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'summary.dart';

BottomNavigationBarItem BottomNavBarHome(selected, context) {
  if (selected == 1) {
    return const BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Color.fromRGBO(102, 255, 255, 1)),
        label: "Home");
  } else {
    return BottomNavigationBarItem(
        icon: InkWell(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home())),
            child: Icon(Icons.home, color: Color.fromRGBO(0, 0, 0, 1))),
        label: 'Home');
  }
}

BottomNavigationBarItem BottomNavBarSummary(selected, context) {
  if (selected == 1) {
    return const BottomNavigationBarItem(
        icon: Icon(
          Icons.auto_graph,
          color: Color.fromRGBO(102, 255, 255, 1),
        ),
        label: "Summary");
  } else {
    return BottomNavigationBarItem(
        icon: InkWell(
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoadingScreen())),
            child: Icon(Icons.auto_graph, color: Color.fromRGBO(0, 0, 0, 1))),
        label: 'Summary');
  }
}

BottomNavigationBar BottomNavBar(homeSelected, summarySelected, context) {
  return BottomNavigationBar(
      // selectedItemColor: Color.fromRGBO(102, 255, 255, 1),

      // backgroundColor: const Color.fromRGBO(9, 100, 140, 1),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavBarHome(homeSelected, context),
        BottomNavBarSummary(summarySelected, context),
      ]);
  // );
}

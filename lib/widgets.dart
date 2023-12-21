import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:dbms/authentication/login.dart';
import 'package:dbms/home/addLocationService.dart';
import 'package:dbms/home/addNewDevice.dart';
import 'package:dbms/home/home.dart';
import 'package:dbms/home/visualize.dart';
import 'package:flutter/material.dart';
import 'package:dbms/home/wowpage.dart';

AdaptiveNavBar navbar(context) {
  var width = MediaQuery.of(context).size.width;
  return AdaptiveNavBar(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      screenWidth: width,
      titleSpacing: 0,
      title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          child: Text("SHEMS")),
      navBarItems: [
        NavBarItem(
          text: 'New Location',
          // highlightColor: Colors.white,
          // focusColor: Colors.white,
          // hoverColor: Colors.white,
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LocationService()),
            );
          },
        ),
        NavBarItem(
          text: 'New Device',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewDevice()),
            );
          },
        ),
        NavBarItem(
          text: 'My Usage',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Visualize()),
            );
          },
        ),
        NavBarItem(
          text: 'Metrics',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WowPage()),
            );
          },
        ),
        NavBarItem(
          text: 'Log Out',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ]);
}

Widget loader(context) {
  return Scaffold(
    // backgroundColor: kText,
    body: Center(
      child: Transform.scale(
        scale: 1.0,
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
          strokeWidth: 2,
        ),
      ),
    ),
  );
}

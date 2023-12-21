import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:dbms/authentication/login.dart';
import 'package:dbms/home/addLocationService.dart';
import 'package:dbms/home/addNewDevice.dart';
import 'package:dbms/home/home.dart';
import 'package:dbms/home/visualize.dart';
import 'package:dbms/home/wowpage.dart';
import 'package:dbms/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shems',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF673AB7)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}

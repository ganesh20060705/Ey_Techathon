import 'package:ey_techathon/pages/login.dart';
import 'package:ey_techathon/pages/signup.dart';
import 'package:ey_techathon/pages/sos.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SOSPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
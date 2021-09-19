import 'package:flutter/material.dart';
import 'package:new_app/dashboard.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //falee the show debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashBoardScreen(),
    );
  }
}

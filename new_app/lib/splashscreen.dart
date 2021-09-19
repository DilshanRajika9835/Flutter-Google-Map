import 'dart:async';

import 'package:flutter/material.dart';

import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {});

    Timer(
        Duration(milliseconds: 10000),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashBoardScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 160,
                width: 160,
                child: FlutterLogo(size: 160),
              ),
              Center(
                child: Container(
                  child: Text('Welcome Flutter GMap ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

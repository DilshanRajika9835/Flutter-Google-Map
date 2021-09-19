import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_app/dashboard.dart';

//stl shote key
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    setState(() {});
    _splashloading();
    // Timer(
    //     Duration(milliseconds: 1000),
    //     () => Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) => DashBoardScreen())));
  }

  _splashloading() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/28.png"), fit: BoxFit.cover)),
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
                  child: Text('Welcome Flutter',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

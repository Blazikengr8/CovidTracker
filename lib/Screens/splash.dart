import 'dart:async';
import 'package:covidtracker/Screens/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>FadeIn();
}
class FadeIn extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
               child:
               Container(
                 color: Colors.cyan,
               child:
               SpinKitDoubleBounce(
              color: Colors.white,
              size: 100.0,
            ),
        ),
        ),
      ),
    );
  }
}
import 'package:covidtracker/Screens/home.dart';
import 'package:covidtracker/Screens/list.dart';
import 'package:covidtracker/Screens/search.dart';
import 'package:covidtracker/Screens/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

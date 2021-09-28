import 'dart:convert';
import 'package:covidtracker/Screens/splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final  url='https://corona.lmao.ninja/v2/all';
class AllCountries extends StatelessWidget {

  var response1;
  var cases;
  int timeInMillis;
  var formattedDate;
  String formatTime;
  String formatTime1;
  var deaths;
  var recovered;
  Future<dynamic> UI() async
  {
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      cases = await jsonDecode(data)['cases'];
      print(cases);
       timeInMillis =await jsonDecode(data)['updated'];
      var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
       formattedDate = DateFormat.yMMMMEEEEd().format(date);
       formatTime=TimeOfDay.fromDateTime(date).toString();
       formatTime1=formatTime.substring(10,15);
       deaths= await jsonDecode(data)['deaths'];
      recovered= await jsonDecode(data)['recovered'];

    }
    @override
    Widget build(BuildContext context) {
      // TODO: implement build

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: UI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text("Global",
              style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              constraints: BoxConstraints.expand(),
              child:
              Center(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Corona Virus/COVID 19 Statistics:',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
                    SizedBox(height: 25,),
                    Text('Confirmed Cases:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    Text('$cases',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.blueGrey),),
                    SizedBox(height: 10,),
                    Text('Total Deaths:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    Text('$deaths',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.redAccent),),
                    SizedBox(height: 10,),
                    Text('Total Recovered:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    Text('$recovered',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.greenAccent),),
                    SizedBox(height: 30,),
                    Text('Last Updated:',style: TextStyle(color: Colors.white,fontSize: 15.0),),
                    Text('$formattedDate'+' $formatTime1')
                  ],
                ),
              ),
            ),
          );
        }
        else
         return SplashScreen();
      },
    );
  }
}

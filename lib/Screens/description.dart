
import 'dart:convert';

import 'package:covidtracker/Screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
void main() => runApp(new DescriptionPage(null,null));
class DescriptionPage extends StatelessWidget{
  DescriptionPage(this.url,this.index);
  final String url;
  final int index;
  var response1;
  var cases;
  var deaths;
  var recovered;
  var todaycases;
  var todaydeaths;
  Future<dynamic> UI() async
  {
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      cases = await jsonDecode(data)[index]['cases'];
      deaths= await jsonDecode(data)[index]['deaths'];
      recovered= await jsonDecode(data)[index]['recovered'];
      todaycases=await jsonDecode(data)[index]['todayCases'];
      todaydeaths=await jsonDecode(data)[index]['todayDeaths'];
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
            appBar: AppBar(title: Text("Overview",
              style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
              leading:  FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:Icon(
                Icons.arrow_back,
                size: 30.0,
                color:Colors.cyan,
                ),
              ),

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
                    Row(
                      children:<Widget>[
                        Expanded(
                          flex:1,
                          child:
                        Column(
                         children:<Widget>[
                          Text('Total Cases:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                          Text('$cases',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.blueGrey),),
                          ],
                        ),
                        ),
                        Expanded(
                          flex:1,
                          child:
                          Column(
                            children:<Widget>[
                              Text('Today Cases:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                              Text('$todaycases',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.blueGrey),),
                            ],
                          ),
                        ),
                    ],
                    ),
                    Row(
                      children:<Widget>[
                        Expanded(
                          flex:1,
                          child:
                          Column(
                            children:<Widget>[
                              Text('Total Deaths:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                              Text('$deaths',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.redAccent),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child:
                          Column(
                            children:<Widget>[
                              Text('Today Deaths:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                              Text('$todaydeaths',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.redAccent),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text('Total Recovered:',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    Text('$recovered',style: TextStyle(fontSize: 35.0,fontWeight:FontWeight.bold ,color: Colors.greenAccent),),
                    SizedBox(height: 30,),

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

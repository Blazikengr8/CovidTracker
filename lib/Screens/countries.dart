import 'dart:convert';
import 'package:covidtracker/Screens/description.dart';
import 'package:covidtracker/Screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String url='https://corona.lmao.ninja/v2/countries';
class IndividualList extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {


  return Scaffold(
  appBar: AppBar(
  title: Text("Countries",style: TextStyle(color: Colors.cyan),),
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.cyan),
    actions: <Widget>[
      
    ],
  ),
  body: Container(
  color: Colors.cyan,
  child:
  Column(
  children: <Widget>[
  new Expanded(
  flex: 1,
  child:
  Container(
  color: Colors.cyan,
  child:
  GestureDetector(
  child:
  new FutureBuilder<List<Corona>>(
  future: fatchCorona(
  http.Client()),
  builder: (context,snapshot){
  if(snapshot.hasError)print(snapshot.error);

  return snapshot.hasData
  ? CoronaList(news: snapshot.data)
      : Center(child:SplashScreen());
  },
  ),
  )
  ),
  )
  ],
  ),
  ),
  );
  }
  }
  Future<List<Corona>> fatchCorona(http.Client client) async {


  final response = await client.get(url);
  return compute(parsenews, response.body);
  }
  List<Corona> parsenews(String responsebody) {
  final parsed = json.decode(responsebody);
  return (parsed as List)
      .map<Corona>((json) => new Corona.fromJson(json))
      .toList();
  }

  class Corona {
  var country;
  var cases;
  var flag;


  Corona({this.country, this.cases, this.flag,});

  factory Corona.fromJson(Map<String, dynamic> json) {
  return Corona(
  country: json['country'],
  cases: json['cases'] ,
  flag: json['countryInfo']['flag'] ,
  );
  }
  }

  class CoronaList extends StatelessWidget {
    final List<Corona> news;

    CoronaList({Key key, this.news}) : super(key: key);

    @override


    Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          String image = news[index].flag;

          return new Card(
            color: Colors.cyan[900],
            child: new ListTile(
              leading:
              Image.network(image,width: 60.0,),
              title: Text('${news[index].cases}'+' ${news[index].country}',
                style: TextStyle(color: Colors.white,),),

              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new DescriptionPage(url,index),
                    ));
              },
            ),
          );
        },
      );
    }
  }

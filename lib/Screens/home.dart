
import 'package:covidtracker/Screens/countries.dart';
import 'package:covidtracker/Screens/list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>Home();
}
GlobalKey _bottomNavigationKey = GlobalKey();
final CurvedNavigationBarState navBarState = _bottomNavigationKey.currentState;
class Home extends State<HomeScreen>{
  int _page = 0;
  final _selectedPage=[
    AllCountries(),
    IndividualList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedPage[_page],
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            backgroundColor: Colors.cyan,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.list, size: 30),
            ],
            onTap: (index) {
              setState(() {
                _page=index;
              });

            },
          ),

    );
  }

}
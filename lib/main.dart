import 'package:flutter/material.dart';

import './widgets/app_bar/AppBar.dart';
import './widgets/app_bar/MenuOverlay.dart';
import './widgets/ActivityFeed.dart';
import './constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    ActivityFeed(),
    ActivityFeed(),
    ActivityFeed(),
    ActivityFeed(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: BaseAppBar("INICIO"),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            drawer: MenuOverlay(),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: Colors.black, size: 30),
                      title: Text("")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.public, color: Colors.black, size: 30),
                      title: Text("")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline,
                          color: Colors.black, size: 30),
                      title: Text("")),
                  BottomNavigationBarItem(
                      icon:
                          Icon(Icons.show_chart, color: Colors.black, size: 30),
                      title: Text("")),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
              ),
            )),
      ),
    );
  }
}

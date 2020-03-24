import 'package:flutter/material.dart';

import './widgets/app_bar/AppBar.dart';
import './widgets/app_bar/MenuOverlay.dart';
import './widgets/ActivityFeed.dart';
import './constants.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  final Client client;

  App(this.client);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<dynamic> feed;
  List<Widget> _widgetOptions;
  String _appBarTitle = "INICIO";
  List<String> _feedNames = [
    "INICIO",
    "PUBLICO",
    "USER",
    "ESTADISTICAS"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _appBarTitle = _feedNames[_selectedIndex];
    });
  }

  @override
  void initState() {
    super.initState();

    _widgetOptions = [
      ActivityFeed("home"),
      ActivityFeed("public"),
      ActivityFeed("user"),
      ActivityFeed("statistics"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: BaseAppBar(this._appBarTitle),
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
                    icon: Icon(Icons.show_chart, color: Colors.black, size: 30),
                    title: Text("")),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

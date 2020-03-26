import 'package:cibic_mobile/src/widgets/app_bar/BaseBar.dart';
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
  int selectedIndex = 0;
  int selectedBarIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<dynamic> feed;
  List<Widget> _widgetOptions;
  String appBarTitle = "INICIO";
  List<String> _feedNames = [
    "INICIO",
    "PUBLICO",
    "USARIO",
    "ESTADISTICAS"
  ];

  void onBarButtonTapped(int index) {
    setState(() {
      if (selectedIndex == 4)
      {
        _widgetOptions = _widgetOptions.sublist(0, 4);
      }
      selectedBarIndex = index;
      selectedIndex = index;
      appBarTitle = _feedNames[selectedBarIndex];
    });
  }

  void onActivityTapped() {
    setState(() {
      _widgetOptions = [..._widgetOptions, Container()];
    });
    selectedIndex = 4;
  }

  @override
  void initState() {
    super.initState();

    _widgetOptions = [
      ActivityFeed("home", onActivityTapped),
      Container(),
      ActivityFeed("home", onActivityTapped),
      ActivityFeed("home", onActivityTapped),
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
          appBar: BaseAppBar(this.appBarTitle),
          body: Center(
            child: _widgetOptions.elementAt(selectedIndex),
          ),
          drawer: MenuOverlay(),
          bottomNavigationBar: BaseBar(this.selectedBarIndex, this.onBarButtonTapped),
        ),
      ),
    );
  }
}

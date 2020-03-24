import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants.dart';
import 'app_bar/AppBar.dart';
import 'app_bar/MenuOverlay.dart';

class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: BaseAppBar("COMPOSE"),
          body: Container(
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
              onTap: _onItemTapped,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

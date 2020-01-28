import 'package:flutter/material.dart';

import './bg.dart';


void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("cibic"),
        ),
        body: Center(
          child: Text("cibic"),
        ),)
    );
  }
}
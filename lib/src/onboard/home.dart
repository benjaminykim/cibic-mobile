import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cibic_mobile/src/widgets/profile/SelfProfileScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/MenuOverlay.dart';

class Home extends StatefulWidget {
  final String jwt;
  final String idUser;

  factory Home.fromBase64(String jwt) => Home(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))))['id'],
          );

  Home(this.jwt, this.idUser);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _widgetOptions;
  int selectedBarIndex = 0;
  String appBarTitle = "INICIO";
  List<String> _feedNames = ["INICIO", "PÚBLICO", "USUARIO", "ESTADÍSTICAS"];

  void onBarButtonTapped(int index) {
    setState(() {
      selectedBarIndex = index;
      appBarTitle = _feedNames[selectedBarIndex];
    });
  }

  @override
  void initState() {
    super.initState();

    _widgetOptions = [
      ActivityFeed("default"),
      ActivityFeed("public"),
      SelfProfileScreen(),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: BaseAppBar(this.appBarTitle, widget.jwt),
          body: Center(
            child: _widgetOptions.elementAt(selectedBarIndex),
          ),
          drawer: MenuOverlay(widget.jwt, this.onBarButtonTapped),
          bottomNavigationBar:
              BaseBar(this.selectedBarIndex, this.onBarButtonTapped),
        ),
    );
  }
}

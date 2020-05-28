import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/widgets/profile/SelfProfileScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/MenuOverlay.dart';

class Home extends StatefulWidget {
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
      ActivityFeed(FEED_HOME),
      ActivityFeed(FEED_PUBLIC),
      SelfProfileScreen(),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: BaseAppBar(this.appBarTitle),
        body: Center(
          child: _widgetOptions.elementAt(selectedBarIndex),
        ),
        drawer: MenuOverlay("", this.onBarButtonTapped),
        bottomNavigationBar:
            BaseBar(this.selectedBarIndex, this.onBarButtonTapped),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './widgets/app_bar/AppBar.dart';
import './widgets/app_bar/MenuOverlay.dart';
import './widgets/ActivityFeed.dart';
import './constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: BaseAppBar(),
          body: TabBarView(
            children: [
              ActivityFeed(),
              Icon(Icons.people_outline),
              Icon(Icons.person_outline),
              Icon(Icons.poll),
            ],
          ),
          drawer: MenuOverlay(),
        ),
      ),
    );
  }
}

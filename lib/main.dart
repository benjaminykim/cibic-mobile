import 'package:flutter/material.dart';

import './widgets/BaseAppBar.dart';
import './widgets/BaseMenuOverlay.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: BaseAppBar(),
          body: TabBarView(
            children: [
              Icon(Icons.public),
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

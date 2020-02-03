import 'package:flutter/material.dart';

import './activity_card/ActivityCard.dart';

class ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff2f2f2),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            ActivityCard(),
            ActivityCard(),
            ActivityCard(),
            ActivityCard(),
            ActivityCard(),
          ],
        ),
      ),
    );
  }
}
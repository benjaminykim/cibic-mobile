import 'package:flutter/material.dart';

import './activity_card/ActivityCard.dart';
import '../example_injection.dart';

class ActivityFeed extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff2f2f2),
        child: ListView(
          children: FEED_DATA.map((card) {return ActivityCard(card);}).toList(),
      ),
    );
  }
}

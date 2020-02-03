import 'package:flutter/material.dart';

import './activity_card/ActivityCard.dart';

class ActivityFeed extends StatelessWidget {
  final data = {
    'userName': 'Sharon Gomez',
    'cp': '1.1',
    'cabildoName': 'chile-cannabis',
    'title': 'Legalize Cannabis',
    'label': 'Proposal',
    'text': 'Cannabis should be legalized because it offers very few negative effects to society, and it is an essential medicine for a lot of people',
    'pingNum': '22.1',
    'commentNumm': '1.1',
    'dateTime': '5 hours ago',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff2f2f2),
        child: ListView(
          children: <Widget>[
            ActivityCard(data),
            ActivityCard(data),
            ActivityCard(data),
            ActivityCard(data),
            ActivityCard(data),
            ActivityCard(data),
          ],
      ),
    );
  }
}

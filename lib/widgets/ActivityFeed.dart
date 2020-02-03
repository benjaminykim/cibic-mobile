import 'package:flutter/material.dart';

import './activity_card/ActivityCard.dart';

class ActivityFeed extends StatelessWidget {
  final data_0 = {
    'userName': 'Sharon Gomez',
    'cp': '1.1k',
    'cabildoName': 'chile-cannabis',
    'title': 'Legalize Cannabis',
    'label': 'Proposal',
    'text': 'Cannabis should be legalized because it offers very few negative effects to society, and it is an essential medicine for a lot of people',
    'pingNum': '22.1k',
    'commentNum': '1.1k',
    'dateTime': '5 hours',
  };

  final data_1 = {
    'userName': 'Alonso Escalante',
    'cp': '5.2k',
    'cabildoName': 'Freedom Chile',
    'title': 'Remove the President',
    'label': 'Discuss',
    'text': 'The president should be removed from office as he is unfit to lead the country. He does not represent the ideas of Chile',
    'pingNum': '15.2k',
    'commentNum': '800',
    'dateTime': '1 day',
  };

  final data_2 = {
    'userName': 'Julia Maria',
    'cp': '208',
    'cabildoName': 'santiago-macul',
    'title': 'Should people have guns?',
    'label': 'Poll',
    'text': '',
    'pingNum': '590',
    'commentNum': '49',
    'dateTime': '5 days',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff2f2f2),
        child: ListView(
          children: <Widget>[
            ActivityCard(data_0),
            ActivityCard(data_1),
            ActivityCard(data_2)
          ],
      ),
    );
  }
}

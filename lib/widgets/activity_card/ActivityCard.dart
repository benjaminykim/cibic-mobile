import 'package:flutter/material.dart';

import '../../constants.dart';
import './UserMetaData.dart';
import './CardMetaData.dart';
import './CardViewScroll.dart';

class ActivityCard extends StatelessWidget {
  final Map<String, String> data;

  ActivityCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Column(
        children: <Widget>[
          UserMetaData(data['userName'], data['cp'], data['cabildoName']),
          CardViewScroll(data),
          CardMetaData(data['pingNum'], data['commentNum'], data['dateTime']),
          Divider(
            color: CARD_DIVIDER,
            thickness: 3,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants.dart';
import './activity_components/UserMetaData.dart';
import './activity_components/CardMetaData.dart';
import './card_view/CardViewScroll.dart';

class ActivityCard extends StatelessWidget {
  final Map<String, Object> data;

  ActivityCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData(data['userName'], data['cp'], data['cabildoName']),
          CardViewScroll(data),
          CardMetaData(data['pingNum'], data['commentNum'], data['dateTime']),
          // divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: CARD_DIVIDER,
              thickness: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

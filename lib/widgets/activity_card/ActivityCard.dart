import 'package:flutter/material.dart';

import '../../constants.dart';
import './UserMetaData.dart';
import './CardMetaData.dart';
import './CardView.dart';

class ActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      child: Column(
        children: <Widget>[
          UserMetaData(),
          CardView(),
          CardMetaData(),
          Divider(
            color: CARD_DIVIDER,
            thickness: 3,
          ),
        ],
      ),
    );
  }
}

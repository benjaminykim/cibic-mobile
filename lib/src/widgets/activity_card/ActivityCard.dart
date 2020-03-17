import 'package:flutter/material.dart';

import '../../constants.dart';
import './activity_components/UserMetaData.dart';
import './activity_components/CardMetaData.dart';
import './card_view/CardViewScroll.dart';
import '../../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;

  ActivityCard(this.activity);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData(activity.idUser, "10.1 k", activity.idCabildo),
          CardViewScroll(activity.title, activity.activityType, activity.text, activity.score, activity.comments),
          CardMetaData(activity.pingNumber, activity.commentNumber, activity.publishDate),
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

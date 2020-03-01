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
          UserMetaData(activity.id_user, activity.user_cp, activity.id_cabildo),
          CardViewScroll(activity.title, activity.type, activity.text, activity.score, activity.comments),
          CardMetaData(activity.ping_number, activity.comment_number, activity.publish_date),
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

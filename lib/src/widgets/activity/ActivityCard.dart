import 'package:flutter/material.dart';

import '../ActivityScreen.dart';
import './activity_components/UserMetaData.dart';
import './activity_components/CardMetaData.dart';
import './activity_components/card_view/CardViewScroll.dart';
import '../../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final Function(ActivityScreen, BuildContext) onActivityTapped;

  ActivityCard(this.activity, this.onActivityTapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onActivityTapped(ActivityScreen(activity), context),
      child: Container(
        child: Column(
          children: <Widget>[
            UserMetaData(activity.idUser, "10.1k", activity.idCabildo),
            CardViewScroll(activity.title, activity.activityType, activity.text,
                activity.score, activity.comments),
            CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './ActivityScreen.dart';
import './components/card/UserMetaData.dart';
import './components/card/CardMetaData.dart';
import './components/card/CardScroll.dart';
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
            CardScroll(activity.title, activity.activityType, activity.text,
                activity.score, activity.comments),
            CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
          ],
        ),
      ),
    );
  }
}

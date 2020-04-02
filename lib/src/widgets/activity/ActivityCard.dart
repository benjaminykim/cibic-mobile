import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScroll.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';

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
            UserMetaData(activity.idUser['username'], activity.idUser['citizenPoints'], activity.idCabildo['name']),
            CardScroll(activity.title, activity.activityType, activity.text, activity.score, activity.comments),
            CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
          ],
        ),
      ),
    );
  }
}

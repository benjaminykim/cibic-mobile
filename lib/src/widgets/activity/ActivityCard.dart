import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScroll.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final Function(ActivityScreen, BuildContext) onActivityTapped;
  final bool scrollEnabled;

  ActivityCard(this.activity, this.onActivityTapped, this.scrollEnabled);

  @override
  Widget build(BuildContext context) {
    if (!this.scrollEnabled)
      this.activity.comments = null;

    return GestureDetector(
      onTap: () => this.onActivityTapped(ActivityScreen(activity), context),
      child: Container(
        child: Column(
          children: <Widget>[
            UserMetaData(activity.idUser, "10.1k", activity.idCabildo),
            CardScroll(activity.title, activity.activityType, activity.text, activity.score, activity.comments),
            CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
          ],
        ),
      ),
    );
  }
}

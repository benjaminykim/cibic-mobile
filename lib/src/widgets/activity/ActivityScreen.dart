import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardView.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/CommentFeed.dart';

class ActivityScreen extends StatelessWidget {
  final ActivityModel activity;

  ActivityScreen(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: APP_BACKGROUND,
        child: ListView(
          children: <Widget>[
            UserMetaData(activity.idUser['username'], activity.idUser['citizenPoints'], activity.idCabildo['name']),
            CardView(activity.title, activity.activityType, activity.text,
                CARD_SCREEN, activity.score, null),
            CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
            CommentFeed(activity.comments),
          ],
        ),
      ),
    );
  }
}

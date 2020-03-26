import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/CommentListView.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScroll.dart';

class ActivityScreen extends StatelessWidget {
  final ActivityModel activity;

  ActivityScreen(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        color: APP_BACKGROUND,
        child: ListView(
          children: <Widget>[
            UserMetaData(activity.idUser, "10.1k", activity.idCabildo),
            CardScroll(activity.title, activity.activityType, activity.text,
                activity.score, null),
            CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
            CommentListView(activity.comments),
          ],
        ),
      ),
    );
  }
}

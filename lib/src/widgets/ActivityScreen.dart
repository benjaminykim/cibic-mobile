import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/activity_components/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/activity_components/CommentListView.dart';
import 'package:cibic_mobile/src/widgets/activity/activity_components/UserMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/activity_components/card_view/CardViewScroll.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  final ActivityModel activity;

  ActivityScreen(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            UserMetaData(activity.idUser, "10.1k", activity.idCabildo),
            CardViewScroll(activity.title, activity.activityType, activity.text,
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

import 'package:cibic_mobile/src/widgets/activity/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/card/CardView.dart';
import 'package:cibic_mobile/src/widgets/activity/card/UserMetaData.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/CommentFeed.dart';

class ActivityScreen extends StatelessWidget {
  final ActivityModel activity;
  final String jwt;
  final Function onReact;

  ActivityScreen(this.activity, this.jwt, this.onReact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: APP_BACKGROUND,
        child: ListView(
          children: <Widget>[
            UserMetaData.fromActivity(activity),
            CardView(activity, CARD_SCREEN, onReact),
            CardMetaData(activity.ping, activity.commentNumber,
                activity.publishDate),
            CommentFeed(activity.comments, jwt, activity.id),
          ],
        ),
      ),
    );
  }
}

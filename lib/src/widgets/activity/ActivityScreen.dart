import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardView.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/CommentFeed.dart';

class ActivityScreen extends StatelessWidget {
  final ActivityModel activity;
  final String jwt;

  ActivityScreen(this.activity, this.jwt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: APP_BACKGROUND,
        child: ListView(
          children: <Widget>[
            UserMetaData.fromActivity(activity, jwt),
            CardView(activity, jwt, CARD_SCREEN),
            CardMetaData(activity.ping, activity.commentNumber,
                activity.publishDate),
            CommentFeed(activity.comments, jwt),
          ],
        ),
      ),
    );
  }
}

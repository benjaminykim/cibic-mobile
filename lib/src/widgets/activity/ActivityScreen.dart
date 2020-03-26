import 'package:cibic_mobile/src/widgets/activity/ActivityCard.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/CommentListView.dart';

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
            ActivityCard(this.activity, null, false),
            CommentListView(activity.comments),
          ],
        ),
      ),
    );
  }
}

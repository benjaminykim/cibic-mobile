import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScroll.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final String jwt;

  ActivityCard(this.activity, this.jwt) {
    if (this.activity.idCabildo == null) {
      this.activity.idCabildo = {
        'name': 'todo',
        '_id': 'todo',
      };
    }
  }

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  @override
  Widget build(BuildContext context) {
    print("ActivityCard-> build -> idUser: " + activity.idUser['_id']);
    print("ActivityCard-> build -> idCabildo: " + activity.idCabildo['_id']);
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData.fromActivity(activity, jwt),
          CardScroll(activity, jwt),
          /*
          GestureDetector(
              onTap: () =>
                  this.onActivityTapped(ActivityScreen(activity, jwt), context),
              child: CardScroll(activity, jwt)),
              */
          GestureDetector(
            onTap: () =>
                this.onActivityTapped(ActivityScreen(activity, jwt), context),
            child: CardMetaData(
                activity.ping, activity.commentNumber, activity.publishDate),
          ),
        ],
      ),
    );
  }
}

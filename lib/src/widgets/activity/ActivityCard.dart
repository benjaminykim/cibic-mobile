import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScroll.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final String jwt;

  ActivityCard(this.activity, this.jwt);

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  @override
  Widget build(BuildContext context) {
    print("ActivityCard-> build -> idUser: " + activity.idUser['_id']);
    print("ActivityCard-> build -> idCabildo: " + activity.idCabildo['_id']);
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData(
            activity.idUser['username'],
            activity.idUser['citizenPoints'],
            activity.idCabildo['name'],
            activity.idUser['_id'],
            activity.idCabildo['_id'],
            jwt
          ),
          GestureDetector(
              onTap: () =>
                  this.onActivityTapped(ActivityScreen(activity, jwt), context),
              child: CardScroll(activity.title, activity.activityType,
                  activity.text, activity.score, activity.comments)),
          GestureDetector(
            onTap: () =>
                this.onActivityTapped(ActivityScreen(activity, jwt), context),
            child: CardMetaData(activity.pingNumber, activity.commentNumber,
                activity.publishDate),
          ),
        ],
      ),
    );
  }
}

import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScroll.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';

class ActivityView extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;

  ActivityView(this.activity, this.jwt) {
    if (this.activity.idCabildo == null) {
      this.activity.idCabildo = {
        'name': 'todo',
        '_id': 'todo',
      };
    }
  }

  @override
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  int userReaction = 2;

  @override
  initState() {
    super.initState();
    String idUser = extractID(this.widget.jwt);
    for (int i = 0; i < this.widget.activity.reactions.length; i++) {
      if (idUser == this.widget.activity.reactions[i].idUser) {
        this.userReaction = this.widget.activity.reactions[i].value;
        break;
      }
    }
  }

  void onReact(int reactValue) {
    setState(() {
      this.userReaction = reactValue;
    });
  }

  void onActivityTapped(BuildContext context) async {
    ActivityScreen activityScreen = ActivityScreen(
        this.widget.activity, this.widget.jwt, this.userReaction, onReact);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData.fromActivity(this.widget.activity, this.widget.jwt),
          GestureDetector(
              onTap: () => this.onActivityTapped(context),
              child: CardScroll(this.widget.activity, this.widget.jwt,
                  this.userReaction, onReact)),
          GestureDetector(
            onTap: () => this.onActivityTapped(context),
            child: CardMetaData(
                this.widget.activity.ping,
                this.widget.activity.commentNumber,
                this.widget.activity.publishDate),
          ),
        ],
      ),
    );
  }
}

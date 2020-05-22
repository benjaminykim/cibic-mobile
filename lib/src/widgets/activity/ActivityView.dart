import 'package:cibic_mobile/src/widgets/activity/card/CardScroll.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/card/UserMetaData.dart';

class ActivityView extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;
  final Function reactToActivity;

  ActivityView(this.activity, this.jwt, this.reactToActivity) {
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
  void openActivityScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityScreen(this.widget.activity,
                this.widget.jwt, this.widget.reactToActivity)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData.fromActivity(this.widget.activity),
          GestureDetector(
              onTap: () => this.openActivityScreen(context),
              child: CardScroll(
                  this.widget.activity, this.widget.reactToActivity)),
          GestureDetector(
            onTap: () => this.openActivityScreen(context),
            child: CardMetaData.fromActivity(this.widget.activity),
          ),
        ],
      ),
    );
  }
}

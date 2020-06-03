import 'package:cibic_mobile/src/widgets/activity/card/CardScroll.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/card/UserMetaData.dart';

class ActivityView extends StatefulWidget {
  final ActivityModel activity;
  final Function onReact;
  final Function onSave;
  final int mode;

  ActivityView(this.activity, this.onReact, this.onSave, this.mode) {
    if (this.activity.cabildo == null) {
      this.activity.cabildo = {
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
            builder: (context) => ActivityScreen(widget.activity.id,
                widget.onReact, widget.onSave, widget.mode)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserMetaData.fromActivity(widget.activity),
          GestureDetector(
              onTap: () => this.openActivityScreen(context),
              child: CardScroll(
                  widget.activity, widget.onReact, widget.onSave, widget.mode)),
          GestureDetector(
            onTap: () => this.openActivityScreen(context),
            child: CardMetaData.fromActivity(widget.activity),
          ),
        ],
      ),
    );
  }
}

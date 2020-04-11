import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src//widgets/utils/Label.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/Contents.dart';

class CardView extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;
  final int mode;

  CardView(this.activity, this.jwt, this.mode);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: labelColorPicker[this.widget.activity.activityType],
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Stack(
        children: <Widget>[
          // LABEL
          Label(this.widget.activity.activityType),
          // TITLE
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(30, 10, 85, 0),
            child: Text(
              this.widget.activity.title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          ),
          // CONTENTS
          Container(
              alignment: Alignment.bottomCenter,
              child: Contents(widget.activity, widget.jwt, widget.mode)),
        ],
      ),
    );
  }
}

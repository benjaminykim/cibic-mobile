import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/components/Label.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/Contents.dart';

class CardView extends StatefulWidget {
  final String title;
  final String type;
  final String text;
  final int mode;
  final int score;
  final CommentModel comment;

  CardView(this.title, this.type, this.text, this.mode, this.score, this.comment);

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
                color: labelColorPicker[this.widget.type],
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Stack(
        children: <Widget>[
          // LABEL
          Label(this.widget.type),
          // TITLE
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(30, 10, 85, 0),
            child: Text(
              this.widget.title,
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
            child: Contents(widget.title, widget.type, widget.text,
                widget.mode, widget.comment),
          ),
        ],
      ),
    );
  }
}

import 'package:cibic_mobile/src/widgets/activity_card/activity_components/Label.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import './CardContents.dart';
import '../activity_components/Title.dart';
import '../../../models/comment_model.dart';

class CardView extends StatefulWidget {
  final String title;
  final String type;
  final String text;
  final int mode;
  final int score;
  final CommentModel comment;
  final Function moveLeft;
  final Function moveRight;

  CardView(this.title, this.type, this.text, this.mode, this.score,
      this.comment, this.moveLeft, this.moveRight);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // LABEL
          Label(this.widget.type),
          // TITLE
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(30, 0, 85, 0),
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
            child: CardContents(widget.title, widget.type, widget.text,
                widget.mode, widget.comment),
          ),
        ],
      ),
    );
  }
}

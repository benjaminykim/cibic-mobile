import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../IconTag.dart';
import './ReactionSlider.dart';
import '../../../models/comment_model.dart';

class CardContents extends StatefulWidget {
  final String title;
  final int type;
  final String text;
  final int mode;
  final CommentModel comment;

  CardContents(this.title, this.type, this.text, this.mode, this.comment);

  @override
  _CardContentsState createState() => _CardContentsState();
}

class _CardContentsState extends State<CardContents> {
  generateCardBody() {
    if (widget.type == ACTIVITY_POLL && widget.mode == CARD_DEFAULT) {
      //default poll card
      return (Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Icon(Icons.thumb_down, size: 50),
          ),
          Icon(Icons.thumb_up, size: 50)
        ],
      ));
    } else if (widget.mode == CARD_COMMENT || widget.mode == CARD_LAST) {
      // default comment card
      return (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTag(
                  Icon(Icons.person, size: 15), widget.comment.id_user),
              IconTag(
                  Icon(Icons.offline_bolt, size: 15), widget.comment.user_cp),
            ],
          ),
          Text(
            widget.comment.text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Center(
            child: Text(
              widget.comment.score,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          )
        ],
      ));
    } else {
      // DISCUSSION OR PROPOSAL CONTENTS
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ReactionSlider(),
            alignment: Alignment.bottomCenter,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20 - 56,
      child: generateCardBody(),
    );
  }
}

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/components/reaction_slider/ReactionSlider.dart';
import 'package:cibic_mobile/src/widgets/utils/IconTag.dart';

class Contents extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;
  final int mode;

  Contents(this.activity, this.jwt, this.mode);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  int commentIndex = -1;

  @override
  initState() {
    super.initState();
    if (widget.mode >= CARD_COMMENT_0 && widget.mode <= CARD_COMMENT_2) {
      this.commentIndex = widget.mode - CARD_COMMENT_0;
    }

  }

  generateCardBody() {
    if (widget.activity.activityType == ACTIVITY_POLL && widget.mode == CARD_DEFAULT) {
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
    } else if (widget.mode == CARD_COMMENT_0 || widget.mode == CARD_COMMENT_1 || widget.mode == CARD_COMMENT_2 || widget.mode == CARD_LAST) {
      // default comment card
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconTag(
                    Icon(Icons.person, size: 17), widget.activity.comments[this.commentIndex].idUser['username']),
                IconTag(
                    Icon(Icons.offline_bolt, size: 17), "102"),
              ],
            ),
            Text(
              widget.activity.comments[this.commentIndex].content,
              maxLines: 15,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  widget.activity.comments[this.commentIndex].score.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        )),
      );
    } else if (widget.mode == CARD_SCREEN) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top:10),
            child: Text(
              widget.activity.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: ReactionSlider(widget.activity, widget.jwt),
            alignment: Alignment.bottomCenter,
          ),
        ],
      );
    } else {
      // DISCUSSION OR PROPOSAL CONTENTS
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top:10),
            child: Text(
              widget.activity.text,
              maxLines: 15,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: ReactionSlider(widget.activity, widget.jwt),
            alignment: Alignment.bottomCenter,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
      width: MediaQuery.of(context).size.width - 20 - 56,
      child: generateCardBody(),
    );
  }
}

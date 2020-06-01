import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/card/IconTag.dart';
import 'package:cibic_mobile/src/widgets/activity/card/ReactionSlider.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';

class CardView extends StatelessWidget {
  final ActivityModel activity;
  final int type;
  final Function onReact;
  final Function onSave;
  final int mode;

  CardView(this.activity, this.type, this.onReact, this.onSave, this.mode);

  Container generateLabel() {
    return Container(
      alignment: Alignment.topLeft,
      width: 60,
      height: 15,
      margin: const EdgeInsets.fromLTRB(30, 5, 0, 0),
      child: Center(
        child: Text(
          labelTextPicker[this.activity.activityType],
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
            color: labelColorPicker[this.activity.activityType], width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget generatePoll() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            padding: const EdgeInsets.only(top: 26),
            child: Icon(Icons.thumb_down, size: 50),
          ),
          Container(
            margin: EdgeInsets.only(right: 30),
            padding: const EdgeInsets.only(top: 10),
            child: Icon(Icons.cancel, size: 30),
          ),
          Container(
            child: Icon(Icons.thumb_up, size: 50),
          )
        ],
      ),
    );
  }

  Widget generateComment() {
    int commentIndex = 0;
    if (this.type >= CARD_COMMENT_0 && this.type <= CARD_COMMENT_2) {
      commentIndex = this.type - CARD_COMMENT_0;
    }
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTag(Icon(Icons.person, size: 17),
                  this.activity.comments[commentIndex].user['firstName']),
              IconTag(
                  Icon(Icons.offline_bolt, size: 17),
                  this
                      .activity
                      .comments[commentIndex]
                      .user['citizenPoints']
                      .toString()),
            ],
          ),
          Text(
            this.activity.comments[commentIndex].content,
            maxLines: 4,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text(
                this.activity.comments[commentIndex].score.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget generateScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Text(
            this.activity.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ReactionSlider(
            this.activity, this.onReact),
      ],
    );
  }

  Widget generateDiscussion() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          alignment: Alignment.topLeft,
          child: Text(
            this.activity.text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ReactionSlider(
            this.activity, this.onReact),
      ],
    );
  }

  Widget generateContent() {
    if (this.activity.activityType == ACTIVITY_POLL &&
        this.type == CARD_DEFAULT) {
      return generatePoll();
    } else if (this.type == CARD_COMMENT_0 ||
        this.type == CARD_COMMENT_1 ||
        this.type == CARD_COMMENT_2 ||
        this.type == CARD_LAST) {
      return generateComment();
    } else if (this.type == CARD_SCREEN) {
      return generateScreen();
    } else {
      return generateDiscussion();
    }
  }

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
                color: labelColorPicker[this.activity.activityType],
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // OPTIONS
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.more_horiz),
                iconSize: 22,
                elevation: 16,
                onChanged: (String value) {},
                items: <String>[(this.mode == FEED_SAVED) ? 'Eliminar Publicación' : 'Guardar Publicación']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    onTap: () {
                      this.onSave(this.activity.id);
                    },
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          // TITLE
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Text(
              this.activity.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          ),
          // LABEL
          generateLabel(),
          // CONTENTS
          generateContent(),
        ],
      ),
    );
  }
}

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/resources/cibic_icons.dart';
import 'package:cibic_mobile/src/widgets/activity/card/IconTag.dart';
import 'package:cibic_mobile/src/widgets/activity/card/ReactionSlider.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';

enum ActivityOption { save, unsave }

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
      margin: const EdgeInsets.fromLTRB(30, 5, 0, 0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 15,
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
                  color: labelColorPicker[this.activity.activityType],
                  width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          ...generateTags(),
        ],
      ),
    );
  }

  List<Widget> generateTags() {
    if (activity.tags == null || activity.tags.length == 0) {
      return [];
    }
    List<Widget> tags = [];
    for (int i = 0; i < activity.tags.length; i++) {
      if (activity.tags[i]['label'] == "" ) {
        return tags;
      }
      tags.add(GestureDetector(
        onTap: () {
          print("${activity.tags[i]['label']}");
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            "#" + activity.tags[i]['label'],
            style: TextStyle(
              color: COLOR_DEEP_BLUE,
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
          ),
        ),
      ));
    }
    return tags;
  }

  Widget generatePoll() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(top: 16),
                child: Icon(Cibic.dislike, color: Colors.black, size: 50),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 90,
                alignment: Alignment.centerLeft,
                child: Icon(Cibic.abstain),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(Cibic.like, size: 50),
              ),
            )
          ],
        ),
      ]),
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
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          alignment: Alignment.topLeft,
          child: Text(
            this.activity.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ReactionSlider(this.activity, this.onReact),
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
        ReactionSlider(this.activity, this.onReact),
      ],
    );
  }

  Widget generateContent() {
    if (this.activity.activityType == ACTIVITY_POLL) {
      if (this.type == CARD_SCREEN) {
        return generatePoll();
      } else {
        return generatePoll();
      }
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
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      this.activity.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                // OPTIONS
                PopupMenuButton<ActivityOption>(
                  onSelected: (ActivityOption result) {
                    if (result == ActivityOption.save) {
                      this.onSave(this.activity.id);
                    }
                  },
                  icon: Icon(Icons.more_horiz, size: 22),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<ActivityOption>>[
                      const PopupMenuItem<ActivityOption>(
                        value: ActivityOption.save,
                        child: Text('Guardar Publicación'),
                      ),
                    ];
                  },
                ),
              ],
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

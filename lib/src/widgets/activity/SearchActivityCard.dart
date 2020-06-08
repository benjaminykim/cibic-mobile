import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/card/ReactionSlider.dart';
import 'package:flutter/material.dart';

class SearchActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final int type;
  final Function onReact;
  final Function onSave;
  final int mode;

  SearchActivityCard(
      this.activity, this.type, this.onReact, this.onSave, this.mode);

  void openActivityScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityScreen(
                this.activity.id, this.onReact, this.onSave, this.mode)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.openActivityScreen(context),
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
            color: CARD_BACKGROUND,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
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
                  items: <String>['Guardar Publicación']
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
      ),
    );
  }

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
      if (activity.tags[i]['label'] == null ||
          activity.tags[i]['label'] == "") {
        continue;
      } else {
        tags.add(GestureDetector(
          onTap: () {
            // TODO TAG TOUCH
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
    }
    return tags;
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
            maxLines: 15,
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
      return generatePoll();
    } else {
      return generateDiscussion();
    }
  }
}

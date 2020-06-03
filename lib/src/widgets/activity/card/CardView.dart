import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/cibic_icons.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:cibic_mobile/src/widgets/activity/card/IconTag.dart';
import 'package:cibic_mobile/src/widgets/activity/card/ReactionSlider.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum ActivityOption { save, unsave }

class CardView extends StatefulWidget {
  final ActivityModel activity;
  final int type;
  final Function onReact;
  final Function onSave;
  final int mode;

  CardView(this.activity, this.type, this.onReact, this.onSave, this.mode);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  Color upVoteColor;
  Color downVoteColor;
  Color abstainColor;

  @override
  initState() {
    super.initState();
    this.upVoteColor = Colors.black;
    this.downVoteColor = Colors.black;
    this.abstainColor = Colors.black;
  }

  Container generateLabel() {
    return Container(
      width: 60,
      height: 15,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Center(
        child: Text(
          labelTextPicker[this.widget.activity.activityType],
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
            color: labelColorPicker[this.widget.activity.activityType],
            width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget generateTags() {
    if (widget.activity.tags == null || widget.activity.tags.length == 0) {
      return Container();
    }
    List<Widget> tags = [];
    for (int i = 0; i < widget.activity.tags.length; i++) {
      if (widget.activity.tags[i]['label'] == "") {
        return Container();
      }
      tags.add(GestureDetector(
        onTap: () {
          // TODO TAG TOUCH
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Text(
            "#" + widget.activity.tags[i]['label'],
            style: TextStyle(
              color: COLOR_DEEP_BLUE,
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
          ),
        ),
      ));
    }
    return Row(children: tags);
  }

  Widget generatePoll() {
    return StoreConnector<AppState, _PollViewModel>(
      converter: (Store<AppState> store) {
        String jwt = store.state.user['jwt'];
        int id = extractID(jwt);
        Function onPollVote = (ActivityModel activity, int reactValue) {
          store.dispatch(PostPollAttempt(activity, reactValue, widget.mode));
        };
        if (widget.activity.votes != null) {
          for (int i = 0; i < widget.activity.votes.length; i++) {
            if (widget.activity.votes[i]['userId'] == id) {
              switch (widget.activity.votes[i]['value']) {
                case -1:
                  this.downVoteColor = COLOR_SOFT_BLUE;
                  this.abstainColor = Colors.black;
                  this.upVoteColor = Colors.black;
                  break;
                case 0:
                  this.downVoteColor = Colors.black;
                  this.abstainColor = COLOR_SOFT_BLUE;
                  this.upVoteColor = Colors.black;
                  break;
                case 1:
                  this.downVoteColor = Colors.black;
                  this.abstainColor = Colors.black;
                  this.upVoteColor = COLOR_SOFT_BLUE;
                  break;
              }
              break;
            }
          }
        }
        return _PollViewModel(jwt, onPollVote);
      },
      builder: (BuildContext context, _PollViewModel vm) {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    vm.onPollVote(widget.activity, -1);
                    setState(() {
                      this.downVoteColor = COLOR_SOFT_BLUE;
                      this.abstainColor = Colors.black;
                      this.upVoteColor = Colors.black;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Icon(Cibic.dislike,
                        color: this.downVoteColor, size: 50),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    vm.onPollVote(widget.activity, 0);
                    setState(() {
                      this.downVoteColor = Colors.black;
                      this.abstainColor = COLOR_SOFT_BLUE;
                      this.upVoteColor = Colors.black;
                    });
                  },
                  child: Container(
                    width: 90,
                    height: 30,
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: Icon(Cibic.abstain, color: this.abstainColor),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    vm.onPollVote(widget.activity, 1);
                    setState(() {
                      this.downVoteColor = Colors.black;
                      this.abstainColor = Colors.black;
                      this.upVoteColor = COLOR_SOFT_BLUE;
                    });
                  },
                  child: Container(
                    child: Icon(Cibic.like, color: this.upVoteColor, size: 50),
                  ),
                )
              ],
            ),
          ]),
        );
      },
    );
  }

  Widget generateComment() {
    int commentIndex = 0;
    if (this.widget.type >= CARD_COMMENT_0 &&
        this.widget.type <= CARD_COMMENT_2) {
      commentIndex = this.widget.type - CARD_COMMENT_0;
    }
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTag(
                  Icon(Icons.person, size: 17),
                  this
                      .widget
                      .activity
                      .comments[commentIndex]
                      .user['firstName']),
              IconTag(
                  Icon(Icons.offline_bolt, size: 17),
                  this
                      .widget
                      .activity
                      .comments[commentIndex]
                      .user['citizenPoints']
                      .toString()),
            ],
          ),
          Text(
            this.widget.activity.comments[commentIndex].content,
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
                this.widget.activity.comments[commentIndex].score.toString(),
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
            this.widget.activity.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ReactionSlider(this.widget.activity, this.widget.onReact),
      ],
    );
  }

  Widget generateDiscussion() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
          alignment: Alignment.topLeft,
          child: Text(
            this.widget.activity.text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ReactionSlider(this.widget.activity, this.widget.onReact),
      ],
    );
  }

  Widget generateContent() {
    if (this.widget.activity.activityType == ACTIVITY_POLL) {
      if (this.widget.type == CARD_SCREEN) {
        return generatePoll();
      } else {
        return generatePoll();
      }
    } else if (this.widget.type == CARD_COMMENT_0 ||
        this.widget.type == CARD_COMMENT_1 ||
        this.widget.type == CARD_COMMENT_2 ||
        this.widget.type == CARD_LAST) {
      return generateComment();
    } else if (this.widget.type == CARD_SCREEN) {
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
                color: labelColorPicker[this.widget.activity.activityType],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          this.widget.activity.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      generateLabel(),
                      generateTags(),
                    ],
                  ),
                ),
                // OPTIONS
                PopupMenuButton<ActivityOption>(
                  onSelected: (ActivityOption result) {
                    if (result == ActivityOption.save) {
                      this.widget.onSave(this.widget.activity.id);
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
          // CONTENTS
          generateContent(),
        ],
      ),
    );
  }
}

class _PollViewModel {
  String jwt;
  Function onPollVote;
  _PollViewModel(this.jwt, this.onPollVote);
}

import 'package:flutter/material.dart';

import '../../../constants.dart';
import './CardSideLeft.dart';
import './CardSideRight.dart';
import './CardContents.dart';

class CardView extends StatelessWidget {
  final String title;
  final int type;
  final String text;
  final int mode;
  final String score;
  final Map<String, String> comment;
  final Function moveLeft;
  final Function moveRight;
  final Map<int, Color> labelColorPicker = {
    ACTIVITY_PROPOSAL: LABEL_PROPOSAL_COLOR,
    ACTIVITY_DISCUSS: LABEL_DISCUSS_COLOR,
    ACTIVITY_POLL: LABEL_POLL_COLOR,
  };
  final Map<int, String> labelTextPicker = {
    ACTIVITY_PROPOSAL: 'Proposal',
    ACTIVITY_DISCUSS: 'Discuss',
    ACTIVITY_POLL: 'Poll',
  };

  CardView(this.title, this.type, this.text, this.mode, this.score,
      this.comment, this.moveLeft, this.moveRight);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: CARD_BACKGROUND,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        children: <Widget>[
          // Label
          Container(
            alignment: Alignment.topRight,
            width: 80,
            height: 20,
//            margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Center(
              child: Text(
                labelTextPicker[type],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: labelColorPicker[type]),
                borderRadius: BorderRadius.circular(20)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: CardSideLeft(type, mode, score, moveLeft),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: CardSideRight(type, mode, moveRight),
          ),
          Container(
            height: 100,
            alignment: Alignment.bottomCenter,
            child: CardContents(title, type, text, mode, comment),
          )
          // React System
        ],
      ),
    );
  }
}

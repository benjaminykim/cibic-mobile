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

  CardView(this.title, this.type, this.text, this.mode, this.score, this.comment, this.moveLeft, this.moveRight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 162,
        decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //left
            CardSideLeft(type, mode, score, moveLeft),
            //center
            CardContents(title, type, text, mode, comment),
            // right
            CardSideRight(type, mode, moveRight),
          ],
        ),
      ),
    );
  }
}

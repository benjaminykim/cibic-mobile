import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';

class Left extends StatelessWidget {
  final String type;
  final int mode;
  final String score;
  final Function moveLeft;

  Left(this.type, this.mode, this.score, this.moveLeft);

  @override
  Widget build(BuildContext context) {
    if (mode == CARD_DEFAULT) {
      if (type == ACTIVITY_POLL) {
        return SizedBox(width: 28);
      }
      return Container(
      width: 28,
      child: Text(
        score,
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    );
    } else {
      return GestureDetector(
        onTap: () {
          moveLeft();
        },
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 28,
        ),
      );
    }
  }
}
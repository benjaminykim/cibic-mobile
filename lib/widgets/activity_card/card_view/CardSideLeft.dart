import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../VotingView.dart';

class CardSideLeft extends StatelessWidget {
  final int type;
  final int mode;
  final String score;
  final Function moveLeft;

  CardSideLeft(this.type, this.mode, this.score, this.moveLeft);

  @override
  Widget build(BuildContext context) {
    if (mode == CARD_DEFAULT) {
      if (type == ACTIVITY_POLL) {
        return SizedBox(width: 28);
      }
      return VotingView(score);
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

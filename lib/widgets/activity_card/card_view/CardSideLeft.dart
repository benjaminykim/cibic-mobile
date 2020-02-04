import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../VotingView.dart';

class CardSideLeft extends StatelessWidget {
  final int type;
  final int mode;
  final String score;

  CardSideLeft(this.type, this.mode, this.score);
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
          print("<");
        },
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 28,
        ),
      );
    }
  }
}

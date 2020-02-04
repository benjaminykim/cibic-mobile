import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../VotingView.dart';

class CardSideLeft extends StatelessWidget {
  final int type;
  final int mode;

  CardSideLeft(this.type, this.mode);
  @override
  Widget build(BuildContext context) {
    if (mode == CARD_DEFAULT) {
      if (type == ACTIVITY_POLL) {
        return SizedBox(width: 28);
      }
      return VotingView();
    } else {
      return Icon(Icons.keyboard_arrow_left, size: 28);
    }
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../VotingView.dart';

class CardSideLeft extends StatelessWidget {
  final int mode;

  CardSideLeft(this.mode);
  @override
  Widget build(BuildContext context) {
    if (mode == CARD_DEFAULT) {
      return VotingView();
    } else if (mode == CARD_POLL) {
      // none
      return Container();
    } else {
      return Icon(Icons.keyboard_arrow_left, size: 28);
    }
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardSideRight extends StatelessWidget {
  final int mode;
  final String type;
  final Function moveRight;

  CardSideRight(this.type, this.mode, this.moveRight);

  @override
  Widget build(BuildContext context) {
    if (mode == CARD_LAST || (mode == CARD_DEFAULT && type == ACTIVITY_POLL)) {
      return SizedBox(width: 28);
    } else {
      return GestureDetector(
        onTap: () {
          moveRight();
        },
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 28,
        ),
      );
    }
  }
}

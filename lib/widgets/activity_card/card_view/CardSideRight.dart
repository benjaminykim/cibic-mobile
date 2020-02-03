import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardSideRight extends StatelessWidget {
  final int mode;

  CardSideRight(this.mode);
  @override
  Widget build(BuildContext context) {
    if (mode == CARD_POLL || mode == CARD_LAST) {
      return Container();
    } else
    return Icon(Icons.keyboard_arrow_right, size: 28);
  }
}
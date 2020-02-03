import 'package:flutter/material.dart';

import '../../../constants.dart';
import './CardSideLeft.dart';
import './CardSideRight.dart';
import './CardContents.dart';

class CardView extends StatelessWidget {
  final String title;
  final String label;
  final String text;
  final int mode;


  CardView(this.title, this.label, this.text, this.mode);

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
            CardSideLeft(mode),
            //center
            CardContents(title, label, text, mode),
            // right
            CardSideRight(mode),
          ],
        ),
      ),
    );
  }
}

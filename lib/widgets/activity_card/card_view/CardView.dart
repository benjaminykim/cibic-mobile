import 'package:flutter/material.dart';

import '../../../constants.dart';
import './CardContents.dart';
import '../activity_components/Title.dart';

class CardView extends StatefulWidget {
  final String title;
  final int type;
  final String text;
  final int mode;
  final String score;
  final Map<String, String> comment;
  final Function moveLeft;
  final Function moveRight;

  CardView(this.title, this.type, this.text, this.mode, this.score,
      this.comment, this.moveLeft, this.moveRight);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: labelColorPicker[this.widget.type],
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Column(
        children: <Widget>[
          // Title and Label
          CardTitle(this.widget.title, this.widget.type),
          // Contents
          Container(
            child: CardContents(widget.title, widget.type, widget.text, widget.mode, widget.comment),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}

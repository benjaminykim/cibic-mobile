import 'package:flutter/material.dart';

import './card_view/CardView.dart';
import '../../constants.dart';

class CardViewScroll extends StatelessWidget {
  final Map<String, Object> data;

  CardViewScroll(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardView(data['title'], data['type'], data['text'], CARD_DEFAULT),
          CardView(data['title'], data['type'], data['text'], CARD_COMMENT),
          CardView(data['title'], data['type'], data['text'], CARD_COMMENT),
          CardView(data['title'], data['type'], data['text'], CARD_LAST),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import './card_view/CardView.dart';

class CardViewScroll extends StatelessWidget {
  final Map<String, String> data;

  CardViewScroll(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardView(data['title'], data['label'], data['text']),
          CardView(data['title'], data['label'], data['text']),
          CardView(data['title'], data['label'], data['text']),
        ],
      ),
    );
  }
}
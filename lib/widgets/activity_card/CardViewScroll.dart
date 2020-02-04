import 'package:flutter/material.dart';

import './card_view/CardView.dart';
import '../../constants.dart';

class CardViewScroll extends StatelessWidget {
  final Map<String, Object> data;

  CardViewScroll(this.data);

  List<Widget> generateCards() {
    List<Widget> widgets = [];
    List comments = data['comments'];
    widgets.add(CardView(data['title'], data['type'], data['text'], CARD_DEFAULT, data['score'], comments[0]));
    if (data['comments'] != null) {
      for(int i=0; i < comments.length; i++) {
        if (i == comments.length - 1) {
          widgets.add(CardView(data['title'], data['type'], data['text'], CARD_LAST, data['score'], comments[i]));
        } else {
          widgets.add(CardView(data['title'], data['type'], data['text'], CARD_COMMENT, data['score'], comments[i]));
        }
      }
    } else {
      // empty card input comment view
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: generateCards()
      ),
    );
  }
}
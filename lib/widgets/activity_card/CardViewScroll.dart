import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './card_view/CardView.dart';
import '../../constants.dart';

class CardViewScroll extends StatefulWidget {
  final Map<String, Object> data;

  CardViewScroll(this.data);

  @override
  _CardViewScrollState createState() => _CardViewScrollState();
}

class _CardViewScrollState extends State<CardViewScroll> {
  ScrollController _controller;
  double width;

  _scrollListener() {
    double cutoff = (_controller.offset % width);
    // if (width - cutoff < (width * 0.7)) {
    //   _controller.animateTo(_controller.offset + (width - cutoff),
    //       curve: Curves.linear, duration: Duration(milliseconds: 500));
    // }
  }

  _moveCardLeft() {
    _controller.animateTo(_controller.offset - (width),
        curve: Curves.linear, duration: Duration(milliseconds: 250));
  }

  _moveCardRight() {
    double cutoff = (_controller.offset % width);
    _controller.animateTo(_controller.offset + (width - cutoff),
        curve: Curves.linear, duration: Duration(milliseconds: 250));
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  List<Widget> generateCards() {
    List<Widget> widgets = [];
    List comments = widget.data['comments'];
    widgets.add(CardView(
        widget.data['title'],
        widget.data['type'],
        widget.data['text'],
        CARD_DEFAULT,
        widget.data['score'],
        comments[0],
        _moveCardLeft,
        _moveCardRight));
    if (widget.data['comments'] != null) {
      int cardMode;
      for (int i = 0; i < comments.length; i++) {
        cardMode = (i == comments.length - 1) ? CARD_LAST : CARD_COMMENT;
        widgets.add(CardView(
            widget.data['title'],
            widget.data['type'],
            widget.data['text'],
            cardMode,
            widget.data['score'],
            comments[i],
            _moveCardLeft,
            _moveCardRight));
      }
    } else {
      // empty card input comment view
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 180,
      child: GestureDetector(
        child: ListView(
          dragStartBehavior: DragStartBehavior.down,
          scrollDirection: Axis.horizontal,
          children: generateCards(),
          controller: _controller,
        ),
      ),
    );
  }
}

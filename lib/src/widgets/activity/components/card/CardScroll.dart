import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardScrollPhysics.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';

class CardScroll extends StatefulWidget {
  final String title;
  final String type;
  final String text;
  final int score;
  final List<CommentModel> comments;

  CardScroll(this.title, this.type, this.text, this.score, this.comments);

  @override
  _CardScrollState createState() => _CardScrollState();
}

class _CardScrollState extends State<CardScroll> {
  final _controller = ScrollController();
  double width;
  ScrollPhysics _physics;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _controller.position.maxScrollExtent / (3);
          _physics = CardScrollPhysics(itemDimension: dimension);
        });
      }
    });
  }

  List<Widget> generateCards() {
    List<Widget> widgets = [];
    List<CommentModel> comments = widget.comments;
    widgets.add(CardView(widget.title, widget.type, widget.text, CARD_DEFAULT,
        widget.score, null));
    if (widget.comments != null) {
      int cardMode;
      for (int i = 0; i < comments.length; i++) {
        cardMode = (i == comments.length - 1) ? CARD_LAST : CARD_COMMENT;
        widgets.add(CardView(widget.title, widget.type, widget.text, cardMode,
            widget.score, widget.comments[i]));
      }
    } else {
      // empty card input comment view
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 250,
        maxHeight: 415,
      ),
        child: ListView(
          shrinkWrap: true,
          dragStartBehavior: DragStartBehavior.down,
          scrollDirection: Axis.horizontal,
          children: generateCards(),
          controller: _controller,
          physics: _physics,
        ),
    );
  }
}

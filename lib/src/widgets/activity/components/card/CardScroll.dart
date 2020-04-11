import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/activity/components/card/CardScrollPhysics.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/CardView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';

class CardScroll extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;

  CardScroll(this.activity, this.jwt);

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
    widgets.add(CardView(widget.activity, widget.jwt, CARD_DEFAULT));
    if (widget.activity.comments != null) {
      for (int i = 0; i < 3; i++) {
        widgets.add(CardView(widget.activity, widget.jwt, CARD_COMMENT_0 + i));
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

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/activity/card/CardView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';

class CardScroll extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;
  final int userReaction;
  final Function onReact;

  CardScroll(this.activity, this.jwt, this.userReaction, this.onReact);

  @override
  _CardScrollState createState() => _CardScrollState();
}

class _CardScrollState extends State<CardScroll> {
  final _controller = ScrollController();
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
    widgets.add(CardView(widget.activity, widget.jwt, CARD_DEFAULT, widget.userReaction, widget.onReact));
    if (widget.activity.comments != null) {
      for (int i = 0; i < 3; i++) {
        widgets.add(CardView(widget.activity, widget.jwt, CARD_COMMENT_0 + i, widget.userReaction, widget.onReact));
      }
    } else {
      // empty card input comment view
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            physics: _physics,
            dragStartBehavior: DragStartBehavior.down,
            child: new Row(
              children: generateCards(),
            ),
          ),
        ],
      )
    );
  }
}

class CardScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  CardScrollPhysics({this.itemDimension, ScrollPhysics parent})
      : super(parent: parent);

  @override
  CardScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CardScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

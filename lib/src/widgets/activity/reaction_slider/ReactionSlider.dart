import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/activity/reaction_slider/ReactionPainter.dart';

class ReactionSlider extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;
  final int userReaction;
  final Function onReact;

  ReactionSlider(this.activity, this.jwt, this.userReaction, this.onReact);

  @override
  _ReactionSliderState createState() => _ReactionSliderState();
}

class _ReactionSliderState extends State<ReactionSlider> {
  double reactValue;
  double _dragPosition;
  double _dragPercentage;
  double width = 250;
  double height = 40;

  @override
  initState() {
    super.initState();
    this.reactValue = widget.userReaction.toDouble();
    this._dragPosition = this.reactValue * (this.width / 4);
    this._dragPercentage = this._dragPosition / this.width;
    this._dragPercentage = 0;
  }

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0;
    double xPos = val.dx - 50;

    if (xPos < 0) {
      newDragPosition = 0;
    } else if (xPos >= this.width) {
      newDragPosition = this.width;
    } else {
      newDragPosition = xPos;
    }

    setState(() {
      _dragPosition = newDragPosition;
      reactValue = _dragPosition * 4 / this.width;
      _dragPercentage = _dragPosition / this.width;
    });
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    reactToActivity(widget.activity, widget.jwt, this.reactValue.toInt() - 2);
    widget.onReact(this.reactValue.toInt());
  }

  void _onTap(BuildContext context, TapUpDetails tap) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(tap.globalPosition);
    _updateDragPosition(offset);
    reactToActivity(widget.activity, widget.jwt, this.reactValue.toInt() - 2);
    widget.onReact(this.reactValue.toInt());
  }

  @override
  Widget build(BuildContext context) {
    this._dragPosition = this.reactValue * (this.width / 4);
    this._dragPercentage = _dragPosition / this.width;
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: SizedBox(
          width: this.width + 20,
          height: this.height,
          child: CustomPaint(
            painter: ReactionPainter(
              dragPercentage: _dragPercentage,
              sliderPosition: _dragPosition,
              width: this.width,
            ),
          ),
        ),
        onHorizontalDragUpdate: (DragUpdateDetails update) =>
            _onDragUpdate(context, update),
        onHorizontalDragStart: (DragStartDetails start) =>
            _onDragStart(context, start),
        onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
        onTapUp: (TapUpDetails tap) => _onTap(context, tap),
      ),
    );
  }
}

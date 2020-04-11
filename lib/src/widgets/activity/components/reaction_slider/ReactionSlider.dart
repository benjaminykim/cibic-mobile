import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/activity/components/reaction_slider/ReactionPainter.dart';

class ReactionSlider extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;

  ReactionSlider(this.activity, this.jwt);

  @override
  _ReactionSliderState createState() => _ReactionSliderState();
}

class _ReactionSliderState extends State<ReactionSlider> {
  double reactValue = 2.0;
  double _dragPosition = 130;
  double _dragPercentage = 0;
  double width = 250;
  double height = 40;
  int userReaction = 2;

  @override
  initState() {
    super.initState();
        for (int i = 0; i < widget.activity.reactions.length; i++) {
      if (widget.activity.reactions[i].idUser == extractID(widget.jwt)) {
        userReaction = widget.activity.reactions[i].value + 2;
        break;
      }
    }
    this.reactValue = this.userReaction.toDouble();
    this._dragPosition = this.reactValue * (this.width / 4);
    this._dragPercentage = this._dragPosition / this.width;
  }

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0;

    if (val.dx < 0) {
      newDragPosition = 0;
    } else if (val.dx >= this.width) {
      newDragPosition = this.width;
    } else {
      newDragPosition = val.dx;
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
    setState(() {});
  }

  void _onTap(BuildContext context, TapUpDetails tap) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(tap.globalPosition);
    _updateDragPosition(offset);
    reactToActivity(widget.activity, widget.jwt, this.reactValue.toInt() - 2);
  }

  @override
  Widget build(BuildContext context) {
    this._dragPosition = this.reactValue * (this.width / 4);
    this._dragPercentage = _dragPosition / this.width;
    return GestureDetector(
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
    );
  }
}

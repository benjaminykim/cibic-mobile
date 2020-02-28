import 'package:flutter/material.dart';

import './ReactionPainter.dart';

class ReactionSlider extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const ReactionSlider({
    this.width = 250,
    this.height = 40,
    this.color = Colors.black,
  });

  @override
  _ReactionSliderState createState() => _ReactionSliderState();
}

class _ReactionSliderState extends State<ReactionSlider> {
  double reactValue = 2.0;
  double _dragPosition = 0;
  double _dragPercentage = 0;

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0;

    if (val.dx < 0) {
      newDragPosition = 0;
    } else if (val.dx >= widget.width) {
      newDragPosition = widget.width;
    } else {
      newDragPosition = val.dx;
    }

    setState(() {
      _dragPosition = newDragPosition;
      _dragPercentage = _dragPosition / widget.width;
    });
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    print(offset);
    _updateDragPosition(offset);
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    print(offset);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
  }

  void _onTap(BuildContext context, TapUpDetails tap) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(tap.globalPosition);
    _updateDragPosition(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: SizedBox(
          width: widget.width + 20,
          height: widget.height,
          child: CustomPaint(
            painter: ReactionPainter(
              dragPercentage: _dragPercentage,
              sliderPosition: _dragPosition,
              width: widget.width,
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

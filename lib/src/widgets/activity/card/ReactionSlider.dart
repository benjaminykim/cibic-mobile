import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReactionSlider extends StatefulWidget {
  final ActivityModel activity;
  final Function onReact;

  ReactionSlider(this.activity, this.onReact);

  @override
  _ReactionSliderState createState() => _ReactionSliderState();
}

class _ReactionSliderState extends State<ReactionSlider> {
  final double width = 250;
  final double height = 40;
  double dragPosition;
  double dragPercentage;

  void _updateDragPosition(Offset val, _ReactionViewModel vm) {
    double newDragPosition = 0;
    double xPos = val.dx - 50;

    if (xPos < 0) {
      newDragPosition = 0;
    } else if (xPos >= this.width) {
      newDragPosition = this.width;
    } else {
      newDragPosition = xPos;
    }
    vm.reactValue = newDragPosition * 4 ~/ this.width;
    setState(() {
      this.dragPosition = newDragPosition;
      this.dragPercentage = newDragPosition / this.width;
    });
  }

  void _onDragUpdate(
      BuildContext context, DragUpdateDetails update, _ReactionViewModel vm) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset, vm);
  }

  void _onDragStart(
      BuildContext context, DragStartDetails start, _ReactionViewModel vm) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset, vm);
  }

  void _onDragEnd(
      BuildContext context, DragEndDetails end, _ReactionViewModel vm) {
    widget.onReact(this.widget.activity, vm.reactValue.toInt() - 2);
  }

  void _onTap(BuildContext context, TapUpDetails tap, _ReactionViewModel vm) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(tap.globalPosition);
    _updateDragPosition(offset, vm);
    widget.onReact(this.widget.activity, vm.reactValue.toInt() - 2);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ReactionViewModel>(
      converter: (Store<AppState> store) {
        String idUser = store.state.idUser;
        int reactValue = 2;
        for (int i = 0; i < widget.activity.reactions.length; i++) {
          if (widget.activity.reactions[i].idUser == idUser) {
            reactValue = widget.activity.reactions[i].value + 2;
            break;
          }
        }

        this.dragPosition = reactValue * (this.width / 4);
        this.dragPercentage = reactValue / 4;
        return _ReactionViewModel(reactValue);
      },
      builder: (BuildContext context, _ReactionViewModel vm) {
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
                  dragPercentage: this.dragPercentage,
                  sliderPosition: this.dragPosition,
                  width: this.width,
                ),
              ),
            ),
            onHorizontalDragUpdate: (DragUpdateDetails update) =>
                _onDragUpdate(context, update, vm),
            onHorizontalDragStart: (DragStartDetails start) =>
                _onDragStart(context, start, vm),
            onHorizontalDragEnd: (DragEndDetails end) =>
                _onDragEnd(context, end, vm),
            onTapUp: (TapUpDetails tap) => _onTap(context, tap, vm),
          ),
        );
      },
    );
  }
}

class _ReactionViewModel {
  int reactValue;
  _ReactionViewModel(this.reactValue);
}

class ReactionPainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final double width;
  final List<Color> anchorColors = [
    Color(0xffdb453e),
    Color(0xffdd8736),
    Color(0xffefe158),
    Color(0xff93cf6b),
    Color(0xff59b791)
  ];
  final List<double> anchorRadius = [10.0, 9.0, 7.0, 9.0, 10.0];
  List<double> anchorPositions;

  ReactionPainter({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.width,
  }) {
    anchorPositions = [];
    double interval = 0;
    while (interval <= width) {
      anchorPositions.add(interval);
      interval += width / 4;
    }
  }

  Paint fillPainter(Color anchorColor) {
    return Paint()
      ..color = anchorColor
      ..style = PaintingStyle.fill;
  }

  Paint linePainter(Size size) {
    return Paint()
      ..color = Colors.black
      ..shader = LinearGradient(
        colors: anchorColors,
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintLine(canvas, size);
    _paintMarker(canvas, size);
    _paintAnchors(canvas, size);
  }

  _paintAnchors(Canvas canvas, Size size) {
    double interval = 0;
    int anchorIndex = 0;

    while (interval <= size.width) {
      canvas.drawCircle(
          Offset(anchorPositions[anchorIndex] + 10, size.height / 2),
          anchorRadius[anchorIndex],
          fillPainter(anchorColors[anchorIndex]));
      interval += size.width / 4;
      anchorIndex++;
    }
  }

  _paintLine(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(1.0, size.height / 2);
    path.lineTo(size.width - 10, size.height / 2);
    canvas.drawPath(path, linePainter(size));
  }

  _findClosestAnchorIndex(double position) {
    double minDiff = width / 4;
    double diff;
    int minIndex = 0;
    int index = 0;

    for (final anchor in anchorPositions) {
      diff = (position - anchor - anchorRadius[index]).abs();
      if (diff < minDiff) {
        minDiff = diff;
        minIndex = index;
      }
      index++;
    }
    return minIndex;
  }

  _paintMarker(Canvas canvas, Size size) {
    int anchorIndex = _findClosestAnchorIndex(sliderPosition);
    canvas.drawCircle(
        Offset(anchorPositions[anchorIndex] + 10, size.height / 2),
        anchorRadius[anchorIndex] + 2.5,
        fillPainter(Color(0xff666456)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

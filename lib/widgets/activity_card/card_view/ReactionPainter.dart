import 'package:flutter/material.dart';

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
  final List<double> anchorRadius = [10.0, 9.0, 8.0, 9.0, 10.0];
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
    path.moveTo(0.0, size.height / 2);
    path.lineTo(size.width - 10, size.height / 2);
    canvas.drawPath(path, linePainter(size));
  }

  _findClosestAnchorIndex(double position) {
    double minDiff = width / 8;
    double diff;
    int minIndex = 0;
    int index = 0;

    for (final anchor in anchorPositions) {
      diff = (anchor - position).abs();
      if (diff < minDiff) {
        minDiff = diff;
        minIndex = index;
      }
      index++;
    }
    print(minIndex);
    return minIndex;
  }

  _paintMarker(Canvas canvas, Size size) {
    int anchorIndex = _findClosestAnchorIndex(sliderPosition);
    canvas.drawCircle(
        Offset(anchorPositions[anchorIndex] + 10, size.height / 2),
        anchorRadius[anchorIndex] + 2,
        fillPainter(Color(0xff666456)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

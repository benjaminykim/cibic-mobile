import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: COLOR_DEEP_BLUE,
        child: SpinKitChasingDots(
          color: COLOR_SOFT_BLUE,
          size: 50.0,
        ));
  }
}

class LoadingPiece extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: COLOR_SOFT_BLUE,
      size: 50.0,
    );
  }
}
import 'package:cibic_mobile/src/onboard/userEducation.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  final jwt;

  Onboard(this.jwt);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  Image cibicGIF = Image(image: AssetImage('assets/images/cibic.gif'));

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserEducation(widget.jwt)));
      },
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: COLOR_DEEP_BLUE,
        child: Container(
          width: 300,
          alignment: Alignment.center,
          child: cibicGIF,
        ),
      ),
    );
  }
}

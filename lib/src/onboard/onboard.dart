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
  Image cibicTilt = Image(image: AssetImage('assets/images/cibic_tilt.png'));
  Image cibicTilt2 = Image(image: AssetImage('assets/images/cibic_tilt2.png'));
  Image cibicLogo = Image(image: AssetImage('assets/images/cibic_logo.png'));
  List<Image> images;
  int imageIndex = 0;

  @override
  initState() {
    super.initState();
    this.images = [this.cibicTilt, this.cibicTilt2, this.cibicLogo];
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (this.imageIndex == 0) {
          setState(() {
            this.imageIndex++;
          });
        } else if (this.imageIndex == 1) {
          setState(() {
            this.imageIndex++;
          });
        } else if (this.imageIndex == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserEducation(widget.jwt)));
        }
      },
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: COLOR_DEEP_BLUE,
        child: Container(
          width: 300,
          alignment: Alignment.center,
          child: images[this.imageIndex],
        ),
      ),
    );
  }
}
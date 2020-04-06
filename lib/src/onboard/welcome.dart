import 'package:cibic_mobile/src/onboard/login.dart';
import 'package:cibic_mobile/src/onboard/register.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  final storage;

  Welcome(this.storage);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final welcomeDecoration = BoxDecoration(
    color: COLOR_SOFT_BLUE,
    borderRadius: BorderRadius.circular(15),
  );

  final welcomeTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  Container createButtonView(String str) {
    Decoration buttonDecoration;
    TextStyle style;

    if (str == "Inicia sesion") {
      buttonDecoration = BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      );
      style = TextStyle(
        fontSize: 17,
        color: Colors.white,
      );
    } else {
      buttonDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      );
      style = TextStyle(
        fontSize: 17,
        color: Colors.black,
      );
    }

    return Container(
      height: 45,
      width: 200,
      decoration: buttonDecoration,
      alignment: Alignment.center,
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: COLOR_DEEP_BLUE,
      padding: const EdgeInsets.fromLTRB(50, 100, 50, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(image: AssetImage('assets/images/cibic_logo.png')),
          SizedBox(height: 190),
          // WELCOME
          Container(
            decoration: this.welcomeDecoration,
            height: 45,
            alignment: Alignment.center,
            child: Text(
              "Bienvenido a cibic",
              textAlign: TextAlign.center,
              style: this.welcomeTextStyle,
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(widget.storage)));
            },
            child: createButtonView("Inicia sesion"),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Register(widget.storage)));
            },
            child: createButtonView("Registrate"),
          ),
          Spacer(),
          Text(
            '\u00a9 cibic 2020',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    ));
  }
}

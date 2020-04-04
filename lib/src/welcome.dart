import 'package:cibic_mobile/src/register.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final storage;

  final welcomeDecoration = BoxDecoration(
    color: COLOR_SOFT_BLUE,
    borderRadius: BorderRadius.circular(15),
  );
  final welcomeTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final buttonDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );
  final buttonTextStyle = TextStyle(
    fontSize: 25,
    color: Colors.black,
  );

  Welcome(this.storage);

  Container createButtonView(String str) {
    return Container(
      height: 65,
      width: 220,
      decoration: this.buttonDecoration,
      alignment: Alignment.center,
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: this.buttonTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: COLOR_DEEP_BLUE,
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 77),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(image: AssetImage('assets/icons/cibic_logo.png')),
              SizedBox(height: 190),
              Container(
                decoration: this.welcomeDecoration,
                height: 55,
                alignment: Alignment.center,
                child: Text(
                  "Bienvenido a cibic",
                  textAlign: TextAlign.center,
                  style: this.welcomeTextStyle,
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {},
                child: createButtonView("Inicia sesion"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register(storage)));
                },
                child: createButtonView("Registrate"),
              ),
            ],
          ),
        ));
  }
}

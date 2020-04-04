import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final storage;

  final inputDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );

  final buttonDecoration = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(10),
  );

  final fadedTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontWeight: FontWeight.w300,
  );

  final defaultTextStyle = TextStyle(
    fontSize: 25,
    color: Colors.black,
  );

  Register(this.storage);

  Container createInputView(String str) {
    return Container(
      height: 40,
      width: 150,
      decoration: this.inputDecoration,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
      child: Text(
        str + "*",
        textAlign: TextAlign.center,
        style: this.fadedTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: COLOR_DEEP_BLUE,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: COLOR_SOFT_BLUE,
              height: 120,
              padding: EdgeInsets.only(top: 60),
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "REGISTRARSE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                "DATOS PERSONALES",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Text(
                "Tus datos son privados.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            SizedBox(height: 15),
            createInputView("correo electronico"),
            createInputView("user name"),
            createInputView("first nombre"),
            createInputView("last nombre"),
            createInputView("sexo"),
            createInputView("numero de telefono"),
            createInputView("contrasena"),
            SizedBox(height: 2),
            Center(
              child: Text(
                "Minimo 8 caracteres, un numero y una mayuscula",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

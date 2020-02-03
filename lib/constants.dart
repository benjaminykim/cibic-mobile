import 'package:flutter/material.dart';

const APP_BAR_BG = Color(0xff2D9CDB);
const APP_BAR_SELECTED = Color(0xff518cad);
const APP_BAR_BOTTOM = Color(0xff6cbae6);

ThemeData get cibicTheme {
  return ThemeData(
// Define the default brightness and colors.
    primaryColor: Color(0xff2D9CDB),
    accentColor: Colors.cyan[600],

    // Define the default font family.
    fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      title: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w400,
        fontFamily: "Montserrat",
        color: Color(0xfff2f2f2),
      ),
      body1: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w200,
        fontFamily: "Montserrat",
        color: Color(0xfff2f2f2),
      )
    ),
  );
}

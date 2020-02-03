import 'package:flutter/material.dart';

const APP_BAR_BG = Color(0xff2D9CDB);
const APP_BAR_SELECTED = Color(0xff518cad);
const APP_BAR_BOTTOM = Color(0xff6cbae6);

ThemeData get cibicTheme {
  return ThemeData(
// Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.cyan[600],

    // Define the default font family.
    fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 28.0, fontFamily: "Montserrat", ),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}

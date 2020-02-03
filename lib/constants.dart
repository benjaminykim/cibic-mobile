import 'package:flutter/material.dart';

const APP_BAR_BG = Color(0xff2D9CDB);
const APP_BAR_SELECTED = Color(0xff518CAD);
const APP_BAR_BOTTOM = Color(0xff6CBAE6);
const CARD_BACKGROUND = Color(0xffFFFFFF);
const CARD_DIVIDER = Color(0xff2D9CDB);

ThemeData get cibicTheme {
  return ThemeData(
    primaryColor: Color(0xff2D9CDB),
    accentColor: Colors.cyan[600],
    fontFamily: 'Montserrat',
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
      ),
      body2: TextStyle(
        fontSize: 14.0,
        fontFamily: "Montserrat",
        color: Color(0xff828282),
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}

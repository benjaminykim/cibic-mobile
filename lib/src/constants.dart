import 'package:flutter/material.dart';

const APP_BAR_BG = Color(0xff2D9CDB);
const APP_BAR_SELECTED = Color(0xff518CAD);
const APP_BAR_BOTTOM = Color(0xff6CBAE6);
const CARD_BACKGROUND = Color(0xffFFFFFF);
const CARD_DIVIDER = Colors.grey;
const LABEL_PROPOSAL_COLOR = Color(0xff2d9cdb);
const LABEL_DISCUSS_COLOR = Color(0xff000000);
const LABEL_POLL_COLOR = Color(0xff000000);
const CARD_DEFAULT = 0;
const CARD_COMMENT = 1;
const CARD_LAST = 2;
const CARD_POLL = 3;
const ACTIVITY_DISCUSS = "discussion";
const ACTIVITY_PROPOSAL = "proposal";
const ACTIVITY_POLL = "poll";

const Map<String, Color> labelColorPicker = {
    ACTIVITY_PROPOSAL: LABEL_PROPOSAL_COLOR,
    ACTIVITY_DISCUSS: LABEL_DISCUSS_COLOR,
    ACTIVITY_POLL: LABEL_POLL_COLOR,
};
const Map<String, String> labelTextPicker = {
  ACTIVITY_PROPOSAL: 'propuesta',
  ACTIVITY_DISCUSS: 'discusion',
  ACTIVITY_POLL: 'encuesta',
};

ThemeData get cibicTheme {
  return ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.cyan[600],
    fontFamily: 'OpenSans',
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w200,
      ),
      title: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w200,
        fontFamily: "OpenSans",
        color: Color(0xfff2f2f2),
      ),
      body1: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w200,
        fontFamily: "OpenSans",
        color: Color(0xfff2f2f2),
      ),
      body2: TextStyle(
        fontSize: 12.0,
        fontFamily: "OpenSans",
        color: Color(0xff828282),
        fontWeight: FontWeight.w200,
      ),
    ),
  );
}
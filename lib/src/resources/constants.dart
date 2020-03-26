import 'package:flutter/material.dart';

const APP_BAR_BG = Color(0xff2D9CDB);
const APP_BAR_SELECTED = Color(0xff518CAD);
const APP_BAR_BOTTOM = Color(0xff6CBAE6);
const APP_BACKGROUND = Color(0xffF2F2F2);
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
const ACTIVITY_TYPES = [ACTIVITY_DISCUSS, ACTIVITY_POLL, ACTIVITY_PROPOSAL];

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
        fontSize: 48.0,
        fontWeight: FontWeight.w700,
        fontFamily: "OpenSans",
        color: Color(0xff000000),
      ),
      body1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        fontFamily: "OpenSans",
        color: APP_BACKGROUND,
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

const URL_PROD_BASE = "http://cibic.io/api/user_id/feed_home";
const URL_LOCALHOST_BASE = "http://10.0.2.2:3000/";
const URL_AWS_BASE = "http://52.9.99.38:3000/";
const ENDPOINT_ACTIVITY = "activity";
const ENDPOINT_POST_ACTIVITY = "activity";
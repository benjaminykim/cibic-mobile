import 'package:flutter/material.dart';

const APP_BAR_BG = Color(0xff43a1bf);
const APP_BAR_SELECTED = Color(0xff518CAD);
const APP_BAR_BOTTOM = Color(0xff6CBAE6);
const APP_BACKGROUND = Color(0xffF2F2F2);
const CARD_BACKGROUND = Color(0xffFFFFFF);

const COLOR_SOFT_BLUE = Color(0xff12668f);
const COLOR_DEEP_BLUE = Color(0xff43a1bf);

const CARD_DIVIDER = Colors.grey;

const LABEL_PROPOSAL_COLOR = Color(0xff2d9cdb);
const LABEL_DISCUSS_COLOR = Color(0xff000000);
const LABEL_POLL_COLOR = Color(0xff000000);

const CARD_DEFAULT = 0;
const CARD_COMMENT_0 = 1;
const CARD_COMMENT_1 = 2;
const CARD_COMMENT_2 = 3;
const CARD_LAST = 4;
const CARD_POLL = 5;
const CARD_SCREEN = 6;

const FEED_HOME = 0;
const FEED_PUBLIC = 1;
const FEED_USER = 2;

const ACTIVITY_DISCUSS = 0;
const ACTIVITY_PROPOSAL = 1;
const ACTIVITY_POLL = 2;
const ACTIVITY_TYPES = [ACTIVITY_DISCUSS, ACTIVITY_POLL, ACTIVITY_PROPOSAL];

const Map<int, Color> labelColorPicker = {
  ACTIVITY_PROPOSAL: LABEL_PROPOSAL_COLOR,
  ACTIVITY_DISCUSS: LABEL_DISCUSS_COLOR,
  ACTIVITY_POLL: LABEL_POLL_COLOR,
};
const Map<int, String> labelTextPicker = {
  ACTIVITY_PROPOSAL: 'Propuesta',
  ACTIVITY_DISCUSS: 'Discusión',
  ACTIVITY_POLL: 'encuesta',
};

ThemeData get cibicTheme {
  return ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.cyan[600],
    fontFamily: 'OpenSans',
    textTheme: TextTheme(
      headline5: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w200,
      ),
      headline6: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w700,
        fontFamily: "OpenSans",
        color: Color(0xff000000),
      ),
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        fontFamily: "OpenSans",
        color: APP_BACKGROUND,
      ),
      bodyText2: TextStyle(
        fontSize: 12.0,
        fontFamily: "OpenSans",
        color: Color(0xff828282),
        fontWeight: FontWeight.w200,
      ),
    ),
  );
}

final loginInputDec = BoxDecoration(
  color: Colors.transparent,
  borderRadius: const BorderRadius.all(const Radius.circular(10)),
  border: Border.all(
    color: Colors.white,
    width: 1.0,
    style: BorderStyle.solid,
  ),
);

const LOGIN_INPUT_TXT = TextStyle(
  fontSize: 15,
  color: Colors.black,
  fontWeight: FontWeight.w300,
);

const REGISTER_INPUT_DEC = const BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(const Radius.circular(10)),
);

const REGISTER_INPUT_TXT = TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontWeight: FontWeight.w300,
);

const REGISTER_TXT = TextStyle(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.w300,
);

get serverError => ListView(
  children: <Widget>[
    Container(
      height: 200,
      padding: EdgeInsets.all(50),
      alignment: Alignment.center,
      child: Text(
        "Cibic server error",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ],
);

Map<String, String> getAuthHeader(String jwt) {
  return {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  };
}

const URL_LOCALHOST_BASE = "http://10.0.2.2:30012/";
const URL_FIREKITTEN_BASE = "http://10.10.126.56:4444/";
const URL_FIREKITTEN_3EA_SMONROE_BASE = "http://192.168.8.130:4445/";
const URL_FIREKITTEN_3EA_BEKIM_BASE = "http://192.168.8.130:3001/";
const URL_AWS_BASE = "https://www.cibic.app/api/";

const ENDPOINT_LOGIN = "auth/login/";
const ENDPOINT_FIREBASE = "auth/notify/";

const ENDPOINT_ACTIVITY = "activity/";
const ENDPOINT_PUBLIC_FEED = "activity/public/";
const ENDPOINT_ACTIVITY_REACT = "activity/react";
const ENDPOINT_ACTIVITY_VOTE = "activity/vote";
const ENDPOINT_ACTIVITY_COMMENT = "activity/comment";
const ENDPOINT_ACTIVITY_COMMENT_VOTE = "activity/comment/vote";
const ENDPOINT_ACTIVITY_REPLY = "activity/reply";
const ENDPOINT_ACTIVITY_REPLY_VOTE = "activity/reply/vote";
const ENDPOINT_ACTIVITY_SAVE_FEED = "activity/save/feed";
const ENDPOINT_ACTIVITY_SAVE = "activity/save";
const ENDPOINT_ACTIVITY_UNSAVE = "activity/unsave";

const ENDPOINT_CABILDOS = "cabildo/";
const ENDPOINT_CABILDO_PROFILE = "cabildo/profile/";
const ENDPOINT_CABILDO_FEED = "cabildo/feed/";
const ENDPOINT_CABILDO_DESCRIPTION = "cabildo/description/";

const ENDPOINT_USER = "user/";
const ENDPOINT_USER_FEED = "user/feed/";
const ENDPOINT_DEFAULT_FEED = "user/home/";
const ENDPOINT_FOLLOW_USER = "user/followuser";
const ENDPOINT_UNFOLLOW_USER = "user/unfollowuser";
const ENDPOINT_FOLLOW_CABILDO = "user/followcabildo";
const ENDPOINT_UNFOLLOW_CABILDO = "user/unfollowcabildo";
const ENDPOINT_USER_DESCRIPTION = "user/description";

const ENDPOINT_SEARCH_USER = "search/users";
const ENDPOINT_SEARCH_ACTIVITY = "search/activities";
const ENDPOINT_SEARCH_CABILDO = "search/cabildos";
const ENDPOINT_SEARCH_ACTIVITY_BY_TAG = "search/tag";
const ENDPOINT_SEARCH_TAG = "tag/";

const ENDPOINT_UNETE_COMMENT = "cibic/comment";

//const API_BASE = URL_LOCALHOST_BASE;
//const API_BASE = URL_FIREKITTEN_BASE;
//const API_BASE = URL_FIREKITTEN_3EA_SMONROE_BASE;
//const API_BASE = URL_FIREKITTEN_3EA_BEKIM_BASE;
const API_BASE = URL_AWS_BASE;
import 'dart:convert';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

fetchProfile(String jwt, String type, String id, NextDispatcher next) async {
  String url = API_BASE;
  if (type == "selfUser") {
    url += ENDPOINT_USER + id;
  }

  final response = await http.get(url, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  printResponse("SELF PROFILE", "GET", response.statusCode);
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json.decode(response.body));
    next(FetchProfileSuccess(type, user));
  } else {
    next(FetchProfileError(type, response.statusCode.toString()));
  }
}

fetchProfileFeed(String jwt, String id, int offset, NextDispatcher next) async {
  String url = API_BASE + ENDPOINT_USER_FEED + id + "/" + offset.toString();

  final response = await http.get(url, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  printResponse("PROFILE FEED", "GET", response.statusCode);
  if (response.statusCode == 200) {
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    if (offset != 0) {
      if (feed.feed.length != 0) {
        next(FetchProfileFeedAppend(feed));
      }
    } else {
      next(FetchProfileFeedSuccess(feed));
    }
  } else {
    next(FetchProfileFeedError(response.statusCode.toString()));
  }
}

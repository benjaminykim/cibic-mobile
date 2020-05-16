import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:redux/redux.dart';

fetchFeed(String jwt, String mode, NextDispatcher next) async {
  String url;
  if (mode == "public") {
    url = API_BASE + ENDPOINT_PUBLIC_FEED;
  } else {
    url = API_BASE + ENDPOINT_DEFAULT_FEED;
  }
  Map<String, String> header = getAuthHeader(jwt);
  var response = await http.get(url, headers: header);
  print("$mode ${response.statusCode}");
  if (response != null && response.statusCode == 200) {
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
    next(FetchFeedSuccess(mode, feed));
  } else {
    next(FetchFeedError(mode, response.statusCode.toString()));
  }
}

fetchUserProfile(String jwt, NextDispatcher next) async {
  String idUser = extractID(jwt);
  final response = await http.get(API_BASE + ENDPOINT_USER + idUser, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });
  print("fetchUserProfile: ${response.statusCode}");
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json.decode(response.body));
    next(FetchUserProfileSuccess(user));
  } else {
    next(FetchUserProfileError(response.statusCode.toString()));
  }
}

fetchUserProfileFeed(String jwt, NextDispatcher next) async {
  String idUser = extractID(jwt);
  final response =
      await http.get(API_BASE + ENDPOINT_USER_FEED + idUser, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });
  print("fetchUserProfileFeed: ${response.statusCode}");
  if (response.statusCode == 200) {
    FeedModel feed = FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    next(FetchUserProfileFeedSuccess(feed));
  } else {
    next(FetchUserProfileFeedError(response.statusCode.toString()));
  }
}
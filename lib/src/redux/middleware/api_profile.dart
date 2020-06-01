import 'dart:convert';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

fetchProfile(String jwt, String type, String id, NextDispatcher next) async {
  String url = API_BASE;
  if (type == "selfUser" || type == "foreignUser") {
    url += ENDPOINT_USER + id;
  }

  final response = await http.get(url, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("fetchProfile: ${response.statusCode}");
  print(" type: $type     id: $id");
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json.decode(response.body));
    next(FetchProfileSuccess(type, user));
  } else {
    next(FetchProfileSuccess(type, response.statusCode.toString()));
  }
}

fetchProfileFeed(
    String jwt, String type, String id, NextDispatcher next) async {
  String url = API_BASE;
  if (type == "selfUser" || type == "foreignUser") {
    url += ENDPOINT_USER_FEED + id;
  }

  final response = await http.get(url, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("fetchFeed: ${response.statusCode}");
  print(" type: $type     id: $id");
  if (response.statusCode == 200) {
    print("profile feed process cabildo");
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    next(FetchProfileFeedSuccess(type, feed));
  } else {
    next(FetchProfileFeedError(type, response.statusCode.toString()));
  }
}

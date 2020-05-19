import 'dart:convert';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

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
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    next(FetchUserProfileFeedSuccess(feed));
  } else {
    next(FetchUserProfileFeedError(response.statusCode.toString()));
  }
}

fetchCabildoProfile(String jwt, String idCabildo, NextDispatcher next) async {
  final response =
      await http.get(API_BASE + ENDPOINT_CABILDO_PROFILE + idCabildo, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  if (response.statusCode == 200) {
    CabildoModel cabildo = CabildoModel.fromJson(json.decode(response.body));
    next(FetchCabildoProfileSuccess(cabildo));
  } else {
    next(FetchCabildoProfileError(response.statusCode.toString()));
  }
}

fetchCabildoProfileFeed(
    String jwt, String idCabildo, NextDispatcher next) async {
  final response =
      await http.get(API_BASE + ENDPOINT_CABILDO_FEED + idCabildo, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });
  if (response.statusCode == 200) {
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    next(FetchCabildoProfileFeedSuccess(feed));
  } else {
    next(FetchCabildoProfileFeedError(response.statusCode.toString()));
  }
}
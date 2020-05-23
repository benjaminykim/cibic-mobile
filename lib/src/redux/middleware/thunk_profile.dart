import 'dart:convert';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
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
  final profileResponse =
      await http.get(API_BASE + ENDPOINT_CABILDO_PROFILE + idCabildo, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  final feedResponse =
      await http.get(API_BASE + ENDPOINT_CABILDO_FEED + idCabildo, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  if (profileResponse.statusCode == 200 && feedResponse.statusCode == 200) {
    CabildoModel cabildo = CabildoModel.fromJson(json.decode(profileResponse.body));
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed": ' + feedResponse.body + '}'));
    next(FetchCabildoProfileSuccess(cabildo, feed));
  } else {
    next(FetchCabildoProfileError(profileResponse.statusCode.toString() + " " + feedResponse.statusCode.toString()));
  }
}


fetchForeignUserProfile(String jwt, NextDispatcher next, String idUser) async {
  final response = await http.get(API_BASE + ENDPOINT_USER + idUser, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });
  print("fetchUserProfile: ${response.statusCode}");
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json.decode(response.body));
    next(FetchForeignUserProfileSuccess(user));
  } else {
    next(FetchForeignUserProfileError(response.statusCode.toString()));
  }
}

fetchForeignUserProfileFeed(String jwt, NextDispatcher next, String idUser) async {
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
    next(FetchForeignUserProfileFeedSuccess(feed));
  } else {
    next(FetchForeignUserProfileFeedError(response.statusCode.toString()));
  }
}
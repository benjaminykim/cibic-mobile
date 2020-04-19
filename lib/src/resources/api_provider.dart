import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:http/http.dart' as http;

void printDebugResponse(var response) {
  if (response != Null) {
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body.toString()}");
  }
}

void printFetchRequest(String idUser, String jwt) {
  print("id: $idUser");
  print("jwt: $jwt");
}

Future<UserModel> fetchUserProfile(String idUser, String jwt) async {
  final response = await http.get(API_BASE + ENDPOINT_USER + idUser, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("DEBUG: fetchUserProfile");
  printFetchRequest(idUser, jwt);
  printDebugResponse(response);
  if (response.statusCode == 200) {
    return UserModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(
        'Failed to load user profile: ' + response.statusCode.toString());
  }
}

Future<FeedModel> fetchUserFeed(String idUser, String jwt) async {
  final response =
      await http.get(API_BASE + ENDPOINT_USER_FEED + idUser, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("DEBUG: fetchUserFeed");
  printFetchRequest(idUser, jwt);
  printDebugResponse(response);
  if (response.statusCode == 200) {
    return FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
  } else {
    throw Exception(
        'Failed to load user feed: ' + response.statusCode.toString());
  }
}

Future<CabildoModel> fetchCabildoProfile(String idCabildo, String jwt) async {
  final response =
      await http.get(API_BASE + ENDPOINT_CABILDO_PROFILE + idCabildo, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("DEBUG: fetchCabildoProfile");
  printFetchRequest(idCabildo, jwt);
  printDebugResponse(response);
  if (response.statusCode == 200) {
    return CabildoModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(
        'Failed to load cabildo profile: ' + response.statusCode.toString());
  }
}

Future<FeedModel> fetchCabildoFeed(String idCabildo, String jwt) async {
  final response =
      await http.get(API_BASE + ENDPOINT_CABILDO_FEED + idCabildo, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("DEBUG: fetchCabildoFeed");
  printFetchRequest(idCabildo, jwt);
  printDebugResponse(response);
  if (response.statusCode == 200) {
    return FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
  } else {
    throw Exception(
        'Failed to load cabildo profile: ' + response.statusCode.toString());
  }
}

Future<String> followUser(String idUserFollow, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_USER));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"idUser": idUserFollow})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: followUser");
  printFetchRequest(idUserFollow, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  } else {
    return "error";
  }
}

Future<String> followCabildo(String idCabildo, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"idCabildo": idCabildo})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: followCabildo");
  printFetchRequest(idCabildo, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  } else {
    return "error";
  }
}

Future<String> reactToActivity(
    ActivityModel activity, String jwt, int reactValue) async {
  String idUser = extractID(jwt);
  bool newReaction = true;
  String idReaction;
  for (int i = 0; i < activity.reactions.length; i++) {
    if (idUser == activity.reactions[i].idUser) {
      newReaction = false;
      idReaction = activity.reactions[i].id;
      activity.reactions[i].value = reactValue;
      break;
    }
  }

  if (newReaction) {
    var reaction = {
      "idActivity": activity.id,
      "reaction": {"idUser": idUser, "value": reactValue}
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REACT));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode(reaction)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printFetchRequest(activity.id, jwt);
    print(response.statusCode);
    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      String id = json.decode(responseBody)['id'];
      ReactionModel newReaction = ReactionModel.fromJson({"_id": id, "idUser": idUser, "value": reactValue});
      activity.reactions.add(newReaction);
      return responseBody;
    } else {
      return "error";
    }
  } else {
    var reaction = {
      "idActivity": activity.id,
      "idReaction": idReaction,
      "value": reactValue
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.putUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REACT));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode(reaction)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printFetchRequest(activity.id, jwt);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      return responseBody;
    } else {
      return "error";
    }
  }
}

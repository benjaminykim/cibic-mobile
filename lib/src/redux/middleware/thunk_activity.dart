

import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:redux/redux.dart';

postActivity(dynamic action, String jwt, NextDispatcher next, Store store) async {
  String type = action.type;
  String title = action.title;
  String body = action.body;
  String idCabildo = action.idCabildo;
  //String tags = action.tags;
  String idUser = extractID(jwt);
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  var requestBody;
  if (type == "discussion" || type == "proposal") {
    if (idCabildo == "todo") {
      requestBody = {
        'activity': {
          'idUser': idUser,
          'activityType': type,
          'title': title,
          'text': body
        }
      };
    } else {
      requestBody = {
        'activity': {
          'idUser': idUser,
          'idCabildo': idCabildo,
          'activityType': type,
          'title': title,
          'text': body
        }
      };
    }
  } else {
    if (idCabildo == "todo") {
      requestBody = {
        'activity': {
          'idUser': idUser,
          'activityType': type,
          'title': title,
          'text': "none"
        }
      };
    } else {
      requestBody = {
        'activity': {
          'idUser': idUser,
          'idCabildo': idCabildo,
          'activityType': type,
          'title': title,
          'text': "none"
        }
      };
    }
  }

  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  if (response.statusCode == 201) {
    //final responseBody = await response.transform(utf8.decoder).join();
    //Map<String, dynamic> activity = jsonDecode(responseBody);
    store.dispatch(SubmitActivitySuccess());
  } else {
    store.dispatch(SubmitActivityError(response.statusCode.toString()));
  }
}
postReaction(ActivityModel activity, String jwt, int reactValue, String idUser, int mode, NextDispatcher next) async {
  print("DEBUG");
  print("Activity: ${activity.id}");
  print("JWT: $jwt");
  print("reactvalue: ${reactValue.toString()}");
  print("idUser: $idUser");
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

    print(response.statusCode);
    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      String id = json.decode(responseBody)['id'];
      ReactionModel newReaction = ReactionModel.fromJson(
          {"_id": id, "idUser": idUser, "value": reactValue});
      next(PostReactionSuccess(activity.id, newReaction, mode));
    } else {
      next(PostReactionError(response.statusCode.toString()));
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

    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      print("Response Body: $responseBody");
      next(PostReactionUpdate(activity.id, idReaction, reactValue, mode));
    } else {
      next(PostReactionError(response.statusCode.toString()));
    }
  }
}
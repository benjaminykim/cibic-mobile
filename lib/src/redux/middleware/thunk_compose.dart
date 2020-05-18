

import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:redux/redux.dart';

postActivity(dynamic action, String jwt, NextDispatcher next) async {
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
    next(SubmitActivitySuccess);
  } else {
    next(SubmitActivityError(response.statusCode.toString()));
  }
}
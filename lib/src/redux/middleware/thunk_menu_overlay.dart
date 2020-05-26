import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

postCabildo(dynamic action, String jwt, NextDispatcher next, Store store) async {
  String name = action.name;
  String desc = action.desc;
  String loc = action.location;
  String tag = action.tag;
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_CABILDOS));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    'cabildo': {
      'name': name,
      'location': loc,
      'desc': desc,
      'issues': [tag],
    }
  };

  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> cabildo = jsonDecode(responseBody);
    int reply = cabildo['id'];
    // follow cabildo
    await followCabildo(reply, jwt);
    // update user profile
    store.dispatch(SubmitCabildoSuccess(reply));
    // pop context
    Navigator.pop(action.context);
  } else {
    // send error
    next(SubmitCabildoError(response.statusCode.toString()));
  }
}

postSaveActivity(int activityId, String jwt, bool save, NextDispatcher next, Store store) async {
  HttpClient httpClient = new HttpClient();
  String url = API_BASE + ((save) ? ENDPOINT_ACTIVITY_SAVE : ENDPOINT_ACTIVITY_UNSAVE);
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(url));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    'activityId':
      activityId
  };

  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  if (response.statusCode == 201) {
    store.dispatch(PostSaveSuccess());
  } else {
    next(SubmitCabildoError(response.statusCode.toString()));
  }
}
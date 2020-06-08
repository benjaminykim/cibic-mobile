import 'dart:convert';
import 'dart:io';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/search_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

attemptRegister(
    String email,
    String password,
    String firstName,
    String lastName,
    String telephone,
    Store store,
    BuildContext context,
    NextDispatcher next) async {
  Map<String, Map<String, dynamic>> requestBody = {
    'user': {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phone': telephone,
    }
  };
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_USER));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  printResponse("REGISTER", "POST", response.statusCode);
  if (response.statusCode == 201) {
    await store.dispatch(LogInAttempt(email, password, context));
    next(PostRegisterSuccess(firstName, lastName, context, store));
  } else {
    next(PostRegisterError(response.statusCode.toString()));
  }
}

attemptLogin(
    String email, String password, Store store, NextDispatcher next) async {
  Map requestBody = {'email': '$email', 'password': '$password'};
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_LOGIN));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  printResponse("LOGIN", "POST", response.statusCode);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> jwtResponse = jsonDecode(responseBody);
    String jwt = jwtResponse['access_token'];
    final storage = FlutterSecureStorage();
    storage.write(key: "jwt", value: jwt);
    next(LogInSuccess(jwt));
  } else {
    next(LogInError(response.statusCode));
  }
}

filterTag(String jwt, String query, int mode, NextDispatcher next) async {
  String url = API_BASE + ENDPOINT_SEARCH_TAG + query;
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  HttpClientResponse response = await request.close();
  httpClient.close();
  printResponse("SEARCH FILTER", "GET", response.statusCode);
  if (response.statusCode == 200) {
    final responseBody = await response.transform(utf8.decoder).join();
    List<Map<String, dynamic>> responseList =
        SearchTagModel.fromJson(json.decode(responseBody)).tags;
    next(PostSearchSuccess(mode, responseList));
  } else {
    next(PostSearchSuccess(mode, []));
  }
}

postSearchActivityByTag(
    String jwt, String query, int mode, NextDispatcher next) async {
  String url = API_BASE + ENDPOINT_SEARCH_ACTIVITY_BY_TAG;
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({
    "search": {"query": query}
  })));
  HttpClientResponse response = await request.close();
  httpClient.close();

  printResponse("SEARCH ACTIVITY BY TAG", "POST", response.statusCode);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    List<ActivityModel> feed =
        FeedModel.fromJson(json.decode('{"feed":' + responseBody + '}')).feed;
    next(PostSearchSuccess(2, feed));
  } else if (response.statusCode == 204) {
    List<ActivityModel> responseList = [];
    next(PostSearchSuccess(2, responseList));
  } else {
    next(PostSearchError(response.statusCode.toString()));
  }
}

postSearchQuery(String jwt, int offset, String query, int mode, NextDispatcher next) async {
  String url = API_BASE;
  switch (mode) {
    case 0:
      url += ENDPOINT_SEARCH_USER + "/" + offset.toString();
      break;
    case 1:
      url += ENDPOINT_SEARCH_CABILDO + "/" + offset.toString();
      break;
    case 2:
      url += ENDPOINT_SEARCH_ACTIVITY + "/" + offset.toString();
      break;
    case 3:
      filterTag(jwt, query, mode, next);
      return;
    case 4:
      url += ENDPOINT_SEARCH_ACTIVITY_BY_TAG + "/" + offset.toString();
      break;
  }
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({
    "search": {"query": query}
  })));
  HttpClientResponse response = await request.close();
  httpClient.close();

  printResponse("SEARCH QUERY", "POST", response.statusCode);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    switch (mode) {
      case 0:
        List<UserModel> responseList = SearchUserModel.fromJson(
                json.decode('{"user":' + responseBody + '}'))
            .user;
        if (offset == 0) {
          next(PostSearchSuccess(mode, responseList));
        } else {
          //next(PostSearchAppendSuccess(mode, responseList));
        }
        break;
      case 1:
        List<CabildoModel> responseList = SearchCabildoModel.fromJson(
                json.decode('{"cabildo":' + responseBody + '}'))
            .cabildo;
        if (offset == 0) {
        next(PostSearchSuccess(mode, responseList));
        } else {
        }
        break;
      case 2:
        List<ActivityModel> feed =
            FeedModel.fromJson(json.decode('{"feed":' + responseBody + '}'))
                .feed;
        if (offset == 0) {
        next(PostSearchSuccess(mode, feed));
        } else {
        }
        break;
      case 4:
        List<ActivityModel> feed =
            FeedModel.fromJson(json.decode('{"feed":' + responseBody + '}'))
                .feed;
        if (offset == 0) {
        next(PostSearchSuccess(mode, feed));
        } else {
        }
        break;
    }
  } else if (response.statusCode == 204) {
    switch (mode) {
      case 0:
        List<UserModel> responseList = [];
        next(PostSearchSuccess(mode, responseList));
        break;
      case 1:
        List<CabildoModel> responseList = [];
        next(PostSearchSuccess(mode, responseList));
        break;
      case 2:
        List<ActivityModel> responseList = [];
        next(PostSearchSuccess(mode, responseList));
        break;
      case 4:
        List<ActivityModel> responseList = [];
        next(PostSearchSuccess(mode, responseList));
        break;
    }
  } else {
    next(PostSearchError(response.statusCode.toString()));
  }
}

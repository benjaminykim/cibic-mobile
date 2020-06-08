import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class PostRegisterAttempt {
  String email;
  String password;
  String firstName;
  String lastName;
  String telephone;
  BuildContext context;
  PostRegisterAttempt(this.email, this.password, this.firstName, this.lastName,
      this.telephone, this.context);
}

class PostRegisterSuccess {
  String firstName;
  String lastName;
  BuildContext context;
  Store store;
  PostRegisterSuccess(this.firstName, this.lastName, this.context, this.store);
}

class PostRegisterError {
  String error;
  PostRegisterError(this.error);
}

class LogInAttempt {
  String email;
  String password;
  BuildContext context;
  LogInAttempt(this.email, this.password, this.context);
}

class LogInSuccess {
  String jwt;
  LogInSuccess(this.jwt);
}

class LogInLoading {}

class LogInError {
  var payload;
  LogInError(this.payload);
}

class LogOut {}

class RefreshApp {
  String jwt;
  BuildContext context;
  RefreshApp(this.jwt, this.context);
}

class FireBaseTokenAttempt {}

class FireBaseTokenSuccess {
  String token;
  dynamic firebase;
  FireBaseTokenSuccess(this.token, this.firebase);
}

class FireBaseTokenError {
  String error;
  FireBaseTokenError(this.error);
}

class FetchProfileAttempt {
  int id;
  String type;
  FetchProfileAttempt(this.id, this.type);
}

class FetchProfileSuccess {
  String type;
  UserModel profile;
  FetchProfileSuccess(this.type, this.profile);
}

class FetchProfileError {
  String type;
  String error;
  FetchProfileError(this.type, this.error);
}

class FetchProfileFeedAttempt {
  int id;
  bool reset;
  FetchProfileFeedAttempt(this.id, this.reset);
}

class FetchProfileFeedSuccess {
  FeedModel feed;
  FetchProfileFeedSuccess(this.feed);
}

class FetchProfileFeedAppend {
  FeedModel feed;
  FetchProfileFeedAppend(this.feed);
}

class FetchProfileFeedError {
  String error;
  FetchProfileFeedError(this.error);
}

class PutDescriptionAttempt {
  String description;
  PutDescriptionAttempt(this.description);
}

class PutDescriptionSuccess {
  String description;
  PutDescriptionSuccess(this.description);
}

class ClearProfile {
  String type;
  ClearProfile(this.type);
}

class FetchSavedFeedAttempt {
  FetchSavedFeedAttempt();
}

class PostSearchAttempt {
  String query;
  bool reset;
  PostSearchAttempt(this.query, this.reset);
}

class PostSearchAppendAttempt {
  String query;
  int mode;
  PostSearchAppendAttempt(this.query, this.mode);
}
class PostSearchActivityByTagAttempt {
  String query;
  int offset;
  PostSearchActivityByTagAttempt(this.query, this.offset);
}

class PostSearchSuccess {
  int mode; // 0 -> user, 1 -> cabildo, 2 -> activity, 3 -> tag, 4-> activity by tag
  List<UserModel> resultUser;
  List<CabildoModel> resultCabildo;
  List<ActivityModel> resultActivity;
  List<Map<String, dynamic>> resultTag;
  List<ActivityModel> resultActivityByTag;
  PostSearchSuccess(this.mode, result) {
    switch (this.mode) {
      case 0:
        this.resultUser = result;
        break;
      case 1:
        this.resultCabildo = result;
        break;
      case 2:
        this.resultActivity = result;
        break;
      case 3:
        this.resultTag = result;
        break;
      case 4:
        this.resultActivityByTag = result;
        break;
    }
  }
}

class PostSearchAppend {
  int mode; // 0 -> user, 1 -> cabildo, 2 -> activity, 3 -> tag, 4-> activity by tag
  List<UserModel> resultUser;
  List<CabildoModel> resultCabildo;
  List<ActivityModel> resultActivity;
  List<Map<String, dynamic>> resultTag;
  List<ActivityModel> resultActivityByTag;
  PostSearchAppend(this.mode, result) {
    switch (this.mode) {
      case 0:
        this.resultUser = result;
        break;
      case 1:
        this.resultCabildo = result;
        break;
      case 2:
        this.resultActivity = result;
        break;
      case 3:
        this.resultTag = result;
        break;
      case 4:
        this.resultActivityByTag = result;
        break;
    }
  }
}
class PostSearchError {
  String error;
  PostSearchError(this.error);
}

class IsLoading {}

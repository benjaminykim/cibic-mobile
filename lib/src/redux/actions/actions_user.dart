import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:flutter/material.dart';

class PostRegisterAttempt {
  String email;
  String password;
  String firstName;
  String lastName;
  String telephone;
  BuildContext context;
  PostRegisterAttempt(this.email, this.password, this.firstName, this.lastName, this.telephone, this.context);
}

class PostRegisterSuccess {
  String firstName;
  String lastName;
  BuildContext context;
  PostRegisterSuccess(this.firstName, this.lastName, this.context);
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

class FireBaseTokenAttempt {
}

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
  dynamic profile;
  FetchProfileSuccess(this.type, this.profile);
}

class FetchProfileError {
  String type;
  String error;
  FetchProfileError(this.type, this.error);
}

class FetchProfileFeedAttempt {
  int id;
  String type;
  FetchProfileFeedAttempt(this.id, this.type);
}

class FetchProfileFeedSuccess {
  String type;
  FeedModel feed;
  FetchProfileFeedSuccess(this.type, this.feed);
}

class FetchProfileFeedError {
  String type;
  String error;
  FetchProfileFeedError(this.type, this.error);
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
  PostSearchAttempt(this.query);
}

class PostSearchSuccess {
  int mode; // 0 -> user, 1 -> cabildo, 2 -> activity
  List<UserModel> resultUser;
  List<CabildoModel> resultCabildo;
  List<ActivityModel> resultActivity;
  PostSearchSuccess(this.mode, result) {
    switch(this.mode) {
      case 0:
        this.resultUser = result;
        break;
      case 1:
        this.resultCabildo = result;
        break;
      case 2:
        this.resultActivity = result;
        break;
    }
  }
}

class PostSearchError {
  String error;
  PostSearchError(this.error);
}

class IsLoading {
}
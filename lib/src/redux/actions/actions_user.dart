import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogInAttempt {
  String email;
  String password;
  LogInAttempt(this.email, this.password);
}

class LogInSuccess {
  String jwt;
  LogInSuccess(this.jwt);
}

class LogInError {
  var payload;
  LogInError(this.payload);
}

class FireBaseTokenAttempt {
}

class FireBaseTokenSuccess {
  String token;
  FirebaseMessaging firebase;
  FireBaseTokenSuccess(this.token, this.firebase);
}

class FireBaseTokenError {
  String error;
  FireBaseTokenError(this.error);
}

class FetchUserProfileAttempt {
}

class FetchUserProfileSuccess {
  UserModel user;
  FetchUserProfileSuccess(this.user);
}

class FetchUserProfileError {
  String error;
  FetchUserProfileError(this.error);
}

class FetchUserProfileFeedSuccess {
  FeedModel feed;
  FetchUserProfileFeedSuccess(this.feed);
}

class FetchUserProfileFeedError {
  String error;
  FetchUserProfileFeedError(this.error);
}

class FetchForeignUserProfileAttempt {
  int idUser;
  FetchForeignUserProfileAttempt(this.idUser);
}

class FetchForeignUserProfileSuccess {
  UserModel user;
  FetchForeignUserProfileSuccess(this.user);
}

class FetchForeignUserProfileError {
  String error;
  FetchForeignUserProfileError(this.error);
}

class FetchForeignUserProfileFeedSuccess {
  FeedModel feed;
  FetchForeignUserProfileFeedSuccess(this.feed);
}

class FetchForeignUserProfileFeedError {
  String error;
  FetchForeignUserProfileFeedError(this.error);
}

class FetchForeignUserProfileClear {
}

class FetchSavedFeedAttempt {
  FetchSavedFeedAttempt();
}
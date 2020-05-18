import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';

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

class FetchFeedAttempt {
  String mode;
  FetchFeedAttempt(this.mode);
}

class FetchFeedSuccess {
  String mode;
  FeedModel feed;
  FetchFeedSuccess(this.mode, this.feed);
}

class FetchFeedError {
  String mode;
  String error;
  FetchFeedError(this.mode, this.error);
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

class SubmitActivityAttempt {
  String type;
  String title;
  String body;
  String idCabildo;
  String tags;
  SubmitActivityAttempt(this.type, this.title, this.body, this.idCabildo, this.tags);
}

class SubmitActivitySuccess {
}

class SubmitActivityError {
  String error;
  SubmitActivityError(this.error);
}
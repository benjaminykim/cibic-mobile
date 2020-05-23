import 'package:cibic_mobile/src/models/feed_model.dart';

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
  int mode;
  FetchFeedAttempt(this.mode);
}

class FetchFeedSuccess {
  int mode;
  FeedModel feed;
  FetchFeedSuccess(this.mode, this.feed);
}

class FetchFeedError {
  int mode;
  String error;
  FetchFeedError(this.mode, this.error);
}
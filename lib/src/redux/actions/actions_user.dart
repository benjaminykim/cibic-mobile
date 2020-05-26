import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';

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
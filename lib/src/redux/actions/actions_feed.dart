import 'package:cibic_mobile/src/models/feed_model.dart';

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
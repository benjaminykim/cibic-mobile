import 'package:cibic_mobile/src/models/feed_model.dart';

class FetchFeedAttempt {
  int mode;
  int offset;
  FetchFeedAttempt(this.mode, this.offset);
}

class FetchFeedAppend {
  int mode;
  FeedModel feed;
  FetchFeedAppend(this.mode, this.feed);
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

class VoteLock {
  bool lock;
  VoteLock(this.lock);
}
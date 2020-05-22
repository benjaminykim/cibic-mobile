import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';

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

class PostReactionAttempt {
  ActivityModel activity;
  int reactValue;
  int mode; // 0 -> home, 1 -> public, 2 -> user profile, 3 -> cabildo profile, 4 -> foreign user profile
  PostReactionAttempt(this.activity, this.reactValue, this.mode);
}

class PostReactionSuccess {
  String activityId;
  ReactionModel reaction;
  int mode; // 0 -> home, 1 -> public, 2 -> user profile, 3 -> cabildo profile, 4 -> foreign user profile
  PostReactionSuccess(this.activityId, this.reaction, this.mode);
}

class PostReactionUpdate {
  String activityId;
  String reactionId;
  int reactValue;
  int mode; // 0 -> home, 1 -> public, 2 -> user profile, 3 -> cabildo profile, 4 -> foreign user profile
  PostReactionUpdate(this.activityId, this.reactionId, this.reactValue, this.mode);
}

class PostReactionError {
  String error;
  PostReactionError(this.error);
}

class PostCommentAttempt {
  String idActivity;
  String content;
  int mode;
  PostCommentAttempt(this.idActivity, this.content, this.mode);
}

class PostCommentSuccess {
  String idActivity;
  CommentModel comment;
  int mode;
  PostCommentSuccess(this.idActivity, this.comment, this.mode);
}

class PostCommentError {
  String error;
  PostCommentError(this.error);
}
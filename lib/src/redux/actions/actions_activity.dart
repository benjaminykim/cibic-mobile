import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';

class SubmitActivityAttempt {
  int type;
  String title;
  String body;
  int idCabildo;
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
  int activityId;
  ReactionModel reaction;
  int mode; // 0 -> home, 1 -> public, 2 -> user profile, 3 -> cabildo profile, 4 -> foreign user profile
  PostReactionSuccess(this.activityId, this.reaction, this.mode);
}

class PostReactionUpdate {
  int activityId;
  int reactionId;
  int reactValue;
  int mode; // 0 -> home, 1 -> public, 2 -> user profile, 3 -> cabildo profile, 4 -> foreign user profile
  PostReactionUpdate(this.activityId, this.reactionId, this.reactValue, this.mode);
}

class PostReactionError {
  String error;
  PostReactionError(this.error);
}

class PostCommentAttempt {
  int idActivity;
  String content;
  int mode;
  PostCommentAttempt(this.idActivity, this.content, this.mode);
}

class PostCommentSuccess {
  int idActivity;
  CommentModel comment;
  int mode;
  PostCommentSuccess(this.idActivity, this.comment, this.mode);
}

class PostCommentError {
  String error;
  PostCommentError(this.error);
}

class PostReplyAttempt {
  int idActivity;
  int idComment;
  String content;
  int mode;
  PostReplyAttempt(this.idActivity, this.idComment, this.content, this.mode);
}

class PostReplySuccess {
  int idActivity;
  int idComment;
  ReplyModel reply;
  int mode;
  PostReplySuccess(this.idActivity, this.idComment, this.reply, this.mode);
}

class PostReplyError {
  String error;
  PostReplyError(this.error);
}

class PostSaveAttempt {
  int activityId;
  bool save;
  PostSaveAttempt(this.activityId, this.save);
}

class PostSaveSuccess {
}

class PostSaveError {
  String error;
  PostSaveError(this.error);
}

class PostCommentVoteAttempt {
  int value;
  int activityid;
  CommentModel comment;
  int mode;
  PostCommentVoteAttempt(this.value, this.activityid, this.comment, this.mode);
}

class PostCommentVoteSuccess {
  int activityId;
  int commentId;
  Map<String, int> vote;
  int mode;
  PostCommentVoteSuccess(this.activityId, this.commentId, this.vote, this.mode);
}

class PostCommentVoteUpdate {
  int activityId;
  int commentId;
  int voteId;
  int value;
  int mode;
  PostCommentVoteUpdate(this.activityId, this.commentId, this.voteId, this.value, this.mode);
}

class PostCommentVoteError {
  String error;
  PostCommentVoteError(this.error);
}

class PostReplyVoteAttempt {
  int value;
  int activityid;
  ReplyModel reply;
  int mode;
  PostReplyVoteAttempt(this.value, this.activityid, this.reply, this.mode);
}

class PostReplyVoteSuccess {
  int activityId;
  int replyId;
  Map<String, int> vote;
  int mode;
  PostReplyVoteSuccess(this.activityId, this.replyId, this.vote, this.mode);
}

class PostReplyVoteUpdate {
  int activityId;
  int replyId;
  int voteId;
  int value;
  int mode;
  PostReplyVoteUpdate(this.activityId, this.replyId, this.voteId, this.value, this.mode);
}

class PostReplyVoteError {
  String error;
  PostReplyVoteError(this.error);
}

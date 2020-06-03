import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';

class SubmitActivityAttempt {
  int type;
  String title;
  String body;
  int idCabildo;
  List<String> tags;
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

import 'package:cibic_mobile/src/models/activity_model.dart';
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
  PostReactionAttempt(this.activity, this.reactValue);
}

class PostReactionSuccess {
  String activityId;
  ReactionModel reaction;
  PostReactionSuccess(this.activityId, this.reaction);
}

class PostReactionUpdate {
  String activityId;
  String reactionId;
  int reactValue;
  PostReactionUpdate(this.activityId, this.reactionId, this.reactValue);
}

class PostReactionError {
  String error;
  PostReactionError(this.error);
}
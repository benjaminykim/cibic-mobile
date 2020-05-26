import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  int id;
  int activityType;
  int score;
  int ping;
  int comment_number;
  DateTime publishDate;
  String title;
  String text;
  int userId;
  Map<String, dynamic> user;
  Map<String, dynamic> cabildo;
  List<CommentModel> comments;
  List<ReactionModel> reactions;
  List<Map<String, dynamic>> votes;

  ActivityModel(
    this.id,
    this.activityType,
    this.score,
    this.ping,
    this.comment_number,
    this.publishDate,
    this.title,
    this.text,
    this.user,
    this.cabildo,
    this.comments,
    this.reactions,
    this.votes);

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
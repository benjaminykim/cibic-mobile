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
  int commentNumber;
  DateTime publishDate;
  String title;
  String text;
  int userId;
  Map<String, dynamic> user;
  Map<String, dynamic> cabildo;
  List<CommentModel> comments;
  List<ReactionModel> reactions;
  List<Map<String, dynamic>> votes;
  List<Map<String, dynamic>> tags;

  ActivityModel(
    this.id,
    this.activityType,
    this.score,
    this.ping,
    this.commentNumber,
    this.publishDate,
    this.title,
    this.text,
    this.user,
    this.cabildo,
    this.comments,
    this.reactions,
    this.votes,
    this.tags);

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  Map<String, dynamic> idUser;
  Map<String, dynamic> idCabildo;
  String activityType;
  int score;
  int pingNumber;
  int commentNumber;
  DateTime publishDate;
  String title;
  String text;
  List<CommentModel> comments;
  List<String> reactions;
  List<String> votes;

  ActivityModel(
    this.idUser,
    this.idCabildo,
    this.activityType,
    this.score,
    this.pingNumber,
    this.commentNumber,
    this.publishDate,
    this.title,
    this.text,
    this.comments,
    this.reactions,
    this.votes);

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
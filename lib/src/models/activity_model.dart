import 'package:json_annotation/json_annotation.dart';
import './comment_model.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  String id_activity;
  String id_user;
  String user_cp;
  String id_cabildo;
  String type;
  String score;
  String ping_number;
  String comment_number;
  String publish_date;
  String title;
  String text;
  String reactions;
  String votes;
  List<CommentModel> comments;

  ActivityModel(this.id_activity, this.id_user, this.user_cp, this.id_cabildo, this.type, this.score, this.ping_number, this.comment_number, this.publish_date, this.title, this.text, this.reactions, this.votes, this.comments);

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
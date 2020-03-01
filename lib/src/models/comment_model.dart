import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String id_user;
  String user_cp;
  String text;
  String score;

  CommentModel(this.id_user, this.user_cp, this.text, this.score);

  factory CommentModel.fromJson(Map<String, String> json) => _$CommentModelFromJson(json);

  Map<String, String> toJson() => _$CommentModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String idUser;
  int score;
  String content;

  CommentModel(this.idUser, this.content, this.score);

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, String> toJson() => _$CommentModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String id;
  Map<String, dynamic> idUser;
  int score;
  String content;
  List<ReplyModel> reply;

  CommentModel(this.id, this.idUser, this.content, this.score, this.reply);

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, String> toJson() => _$CommentModelToJson(this);
}
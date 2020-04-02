import 'package:json_annotation/json_annotation.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  Map<String, dynamic> idUser;
  int score;
  String content;
  List<ReplyModel> reply;

  CommentModel(this.idUser, this.content, this.score, this.reply);

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, String> toJson() => _$CommentModelToJson(this);
}
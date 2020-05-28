import 'package:json_annotation/json_annotation.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  int id;
  Map<String, dynamic> user;
  int score;
  String content;
  List<ReplyModel> replies;
  List<dynamic> votes;

  CommentModel(this.id, this.user, this.content, this.score, this.replies, this.votes);

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, String> toJson() => _$CommentModelToJson(this);
}
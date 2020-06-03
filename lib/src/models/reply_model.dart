import 'package:json_annotation/json_annotation.dart';

part 'reply_model.g.dart';

@JsonSerializable()
class ReplyModel {
  int id;
  Map<String, dynamic> user;
  Map<String, dynamic> taggedUser;
  int score;
  String content;
  List<dynamic> votes;

  ReplyModel(this.id, this.user, this.taggedUser, this.content, this.score, this.votes);

  factory ReplyModel.fromJson(Map<String, dynamic> json) => _$ReplyModelFromJson(json);

  Map<String, String> toJson() => _$ReplyModelToJson(this);
}
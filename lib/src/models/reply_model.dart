import 'package:json_annotation/json_annotation.dart';

part 'reply_model.g.dart';

@JsonSerializable()
class ReplyModel {
  int id;
  Map<String, dynamic> user;
  int score;
  String content;

  ReplyModel(this.id, this.user, this.content, this.score);

  factory ReplyModel.fromJson(Map<String, dynamic> json) => _$ReplyModelFromJson(json);

  Map<String, String> toJson() => _$ReplyModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'reply_model.g.dart';

@JsonSerializable()
class ReplyModel {
  String idUser;
  int score;
  String content;

  ReplyModel(this.idUser, this.content, this.score);

  factory ReplyModel.fromJson(Map<String, dynamic> json) => _$ReplyModelFromJson(json);

  Map<String, String> toJson() => _$ReplyModelToJson(this);
}
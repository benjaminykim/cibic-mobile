import 'package:json_annotation/json_annotation.dart';

part 'reaction_model.g.dart';

@JsonSerializable()
class ReactionModel {
  int id;
  int userId;
  int value;

  ReactionModel(this.id, this.userId, this.value);

  factory ReactionModel.fromJson(Map<String, dynamic> json) => _$ReactionModelFromJson(json);

  Map<String, String> toJson() => _$ReactionModelToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) {
  return ReplyModel(
    json['id'] as int,
    json['user'] as Map<String, dynamic>,
    json['content'] as String,
    json['score'] as int,
    json['votes'] as List,
  );
}

Map<String, dynamic> _$ReplyModelToJson(ReplyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'score': instance.score,
      'content': instance.content,
      'votes': instance.votes,
    };

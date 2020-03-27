// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) {
  return ReplyModel(
    json['idUser'] as String,
    json['content'] as String,
    json['score'] as int,
  );
}

Map<String, dynamic> _$ReplyModelToJson(ReplyModel instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'score': instance.score,
      'content': instance.content,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    json['id_user'] as String,
    json['user_cp'] as String,
    json['text'] as String,
    json['score'] as String,
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id_user': instance.id_user,
      'user_cp': instance.user_cp,
      'text': instance.text,
      'score': instance.score,
    };

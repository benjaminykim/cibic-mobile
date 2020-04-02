// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    json['idUser'] as Map<String, dynamic>,
    json['content'] as String,
    json['score'] as int,
    (json['reply'] as List)
        ?.map((e) =>
            e == null ? null : ReplyModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'score': instance.score,
      'content': instance.content,
      'reply': instance.reply,
    };

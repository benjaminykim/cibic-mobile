// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    json['id'] as int,
    json['user'] as Map<String, dynamic>,
    json['content'] as String,
    json['score'] as int,
    (json['replies'] as List)
        ?.map((e) =>
            e == null ? null : ReplyModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'score': instance.score,
      'content': instance.content,
      'replies': instance.replies,
    };

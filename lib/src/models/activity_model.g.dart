// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
    json['id'] as int,
    json['activityType'] as int,
    json['score'] as int,
    json['ping'] as int,
    json['comment_number'] as int,
    json['publishDate'] == null
        ? null
        : DateTime.parse(json['publishDate'] as String),
    json['title'] as String,
    json['text'] as String,
    json['user'] as Map<String, dynamic>,
    json['cabildo'] as Map<String, dynamic>,
    (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['reactions'] as List)
        ?.map((e) => e == null
            ? null
            : ReactionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['votes'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  )..userId = json['userId'] as int;
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityType': instance.activityType,
      'score': instance.score,
      'ping': instance.ping,
      'comment_number': instance.comment_number,
      'publishDate': instance.publishDate?.toIso8601String(),
      'title': instance.title,
      'text': instance.text,
      'userId': instance.userId,
      'user': instance.user,
      'cabildo': instance.cabildo,
      'comments': instance.comments,
      'reactions': instance.reactions,
      'votes': instance.votes,
    };

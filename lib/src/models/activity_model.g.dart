// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
    json['_id'] as String,
    json['idUser'] as Map<String, dynamic>,
    json['idCabildo'] as Map<String, dynamic>,
    json['activityType'] as String,
    json['score'] as int,
    json['ping'] as int,
    json['commentNumber'] as int,
    json['publishDate'] == null
        ? null
        : DateTime.parse(json['publishDate'] as String),
    json['title'] as String,
    json['text'] as String,
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
  );
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'idUser': instance.idUser,
      'idCabildo': instance.idCabildo,
      'activityType': instance.activityType,
      'score': instance.score,
      'ping': instance.ping,
      'commentNumber': instance.commentNumber,
      'publishDate': instance.publishDate?.toIso8601String(),
      'title': instance.title,
      'text': instance.text,
      'comments': instance.comments,
      'reactions': instance.reactions,
      'votes': instance.votes,
    };

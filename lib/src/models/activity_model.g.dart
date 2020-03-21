// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
    json['idUser'] as String,
    json['idCabildo'] as String,
    json['activityType'] as String,
    json['score'] as int,
    json['pingNumber'] as int,
    json['commentNumber'] as int,
    json['publishDate'] as String,
    json['title'] as String,
    json['text'] as String,
    (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['reactions'] as List)?.map((e) => e as String)?.toList(),
    (json['votes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'idCabildo': instance.idCabildo,
      'activityType': instance.activityType,
      'score': instance.score,
      'pingNumber': instance.pingNumber,
      'commentNumber': instance.commentNumber,
      'publishDate': instance.publishDate,
      'title': instance.title,
      'text': instance.text,
      'comments': instance.comments,
      'reactions': instance.reactions,
      'votes': instance.votes,
    };

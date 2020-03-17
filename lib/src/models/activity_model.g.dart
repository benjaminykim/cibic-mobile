// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
    json['createdBy'] as String,
    json['cabildo'] as String,
    json['activityType'] as String,
    json['number'] as int,
    json['pingNumber'] as int,
    json['commentNumber'] as int,
    json['createdAt'] as String,
    json['title'] as String,
    json['text'] as String,
    (json['comments'] as List)?.map((e) => e as String)?.toList(),
    (json['reaction'] as List)?.map((e) => e as String)?.toList(),
    (json['votes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'cabildo': instance.cabildo,
      'activityType': instance.activityType,
      'number': instance.number,
      'pingNumber': instance.pingNumber,
      'commentNumber': instance.commentNumber,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'text': instance.text,
      'comments': instance.comments,
      'reaction': instance.reaction,
      'votes': instance.votes,
    };

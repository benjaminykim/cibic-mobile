// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
    json['id_activity'] as String,
    json['id_user'] as String,
    json['user_cp'] as String,
    json['id_cabildo'] as String,
    json['type'] as String,
    json['score'] as String,
    json['ping_number'] as String,
    json['comment_number'] as String,
    json['publish_date'] as String,
    json['title'] as String,
    json['text'] as String,
    json['reactions'] as String,
    json['votes'] as String,
    (json['comments'] as List)
        ?.map((e) => e == null
            ? null
            : CommentModel.fromJson((e as Map<String, dynamic>)?.map(
                (k, e) => MapEntry(k, e as String),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id_activity': instance.id_activity,
      'id_user': instance.id_user,
      'user_cp': instance.user_cp,
      'id_cabildo': instance.id_cabildo,
      'type': instance.type,
      'score': instance.score,
      'ping_number': instance.ping_number,
      'comment_number': instance.comment_number,
      'publish_date': instance.publish_date,
      'title': instance.title,
      'text': instance.text,
      'reactions': instance.reactions,
      'votes': instance.votes,
      'comments': instance.comments,
    };

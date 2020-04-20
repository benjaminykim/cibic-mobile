// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabildo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CabildoModel _$CabildoModelFromJson(Map<String, dynamic> json) {
  return CabildoModel(
    json['_id'] as String,
    json['name'] as String,
    (json['members'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, e as String),
            ))
        ?.toList(),
    (json['moderators'] as List)?.map((e) => e as String)?.toList(),
    json['admin'] as Map<String, dynamic>,
    json['location'] as String,
    (json['issues'] as List)?.map((e) => e as String)?.toList(),
    (json['meetings'] as List)?.map((e) => e as String)?.toList(),
    (json['files'] as List)?.map((e) => e as String)?.toList(),
    (json['activityFeed'] as List)?.map((e) => e as String)?.toList(),
    json['desc'] as String,
  );
}

Map<String, dynamic> _$CabildoModelToJson(CabildoModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'members': instance.members,
      'moderators': instance.moderators,
      'issues': instance.issues,
      'meetings': instance.meetings,
      'files': instance.files,
      'activityFeed': instance.activityFeed,
      'name': instance.name,
      'desc': instance.desc,
      'admin': instance.admin,
      'location': instance.location,
    };

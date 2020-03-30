// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabildo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CabildoModel _$CabildoModelFromJson(Map<String, dynamic> json) {
  return CabildoModel(
    json['id'] as String,
    json['name'] as String,
    (json['members'] as List)?.map((e) => e as String)?.toList(),
    (json['moderators'] as List)?.map((e) => e as String)?.toList(),
    json['admin'] as String,
    json['location'] as String,
    (json['issues'] as List)?.map((e) => e as String)?.toList(),
    (json['meetings'] as List)?.map((e) => e as String)?.toList(),
    (json['files'] as List)?.map((e) => e as String)?.toList(),
    (json['activities'] as List)
        ?.map((e) => e == null
            ? null
            : ActivityModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CabildoModelToJson(CabildoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
      'moderators': instance.moderators,
      'admin': instance.admin,
      'location': instance.location,
      'issues': instance.issues,
      'meetings': instance.meetings,
      'files': instance.files,
      'activities': instance.activities,
    };

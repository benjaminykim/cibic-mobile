// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabildo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CabildoModel _$CabildoModelFromJson(Map<String, dynamic> json) {
  return CabildoModel(
    json['id'] as int,
    json['name'] as String,
    json['location'] as String,
    json['desc'] as String,
    json['admin'] == null
        ? null
        : UserModel.fromJson(json['admin'] as Map<String, dynamic>),
    (json['members'] as List)
        ?.map((e) =>
            e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['moderators'] as List)
        ?.map((e) =>
            e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CabildoModelToJson(CabildoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'desc': instance.desc,
      'admin': instance.admin,
      'members': instance.members,
      'moderators': instance.moderators,
    };

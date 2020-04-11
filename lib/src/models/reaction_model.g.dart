// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) {
  return ReactionModel(
    json['_id'] as String,
    json['idUser'] as String,
    json['value'] as int,
  );
}

Map<String, dynamic> _$ReactionModelToJson(ReactionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'idUser': instance.idUser,
      'value': instance.value,
    };

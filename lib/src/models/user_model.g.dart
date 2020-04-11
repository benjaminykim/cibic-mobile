// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['_id'] as String,
    (json['cabildos'] as List)
        ?.map((e) =>
            e == null ? null : CabildoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['activityVotes'] as List)?.map((e) => e as String)?.toList(),
    (json['commentVotes'] as List)?.map((e) => e as String)?.toList(),
    (json['files'] as List)?.map((e) => e as String)?.toList(),
    (json['followers'] as List)?.map((e) => e as String)?.toList(),
    (json['following'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    (json['activityFeed'] as List)?.map((e) => e as String)?.toList(),
    (json['followingFeed'] as List)?.map((e) => e as String)?.toList(),
    json['citizenPoints'] as int,
    json['username'] as String,
    json['email'] as String,
    json['password'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['maidenName'] as String,
    json['phone'] as int,
    json['rut'] as String,
    json['desc'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'cabildos': instance.cabildos,
      'activityVotes': instance.activityVotes,
      'commentVotes': instance.commentVotes,
      'files': instance.files,
      'followers': instance.followers,
      'following': instance.following,
      'activityFeed': instance.activityFeed,
      'followingFeed': instance.followingFeed,
      'citizenPoints': instance.citizenPoints,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'maidenName': instance.maidenName,
      'phone': instance.phone,
      'rut': instance.rut,
      'desc': instance.desc,
    };

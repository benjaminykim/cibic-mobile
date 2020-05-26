// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['id'] as int,
    (json['cabildosIds'] as List)?.map((e) => e as int)?.toList(),
    (json['cabildos'] as List)
        ?.map((e) =>
            e == null ? null : CabildoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['activityVotes'] as List)?.map((e) => e as int)?.toList(),
    (json['commentVotesIds'] as List)?.map((e) => e as int)?.toList(),
    (json['files'] as List)?.map((e) => e as String)?.toList(),
    (json['followersIds'] as List)?.map((e) => e as int)?.toList(),
    (json['followingIds'] as List)?.map((e) => e as int)?.toList(),
    (json['activityFeedIds'] as List)?.map((e) => e as int)?.toList(),
    json['citizenPoints'] as int,
    json['email'] as String,
    json['password'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['maidenName'] as String,
    json['phone'] as int,
    json['rut'] as String,
    json['desc'] as String,
  )
    ..replyVotesIds =
        (json['replyVotesIds'] as List)?.map((e) => e as int)?.toList()
    ..followers = (json['followers'] as List)
        ?.map((e) =>
            e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..following = (json['following'] as List)
        ?.map((e) =>
            e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'cabildosIds': instance.cabildosIds,
      'cabildos': instance.cabildos,
      'activityVotes': instance.activityVotes,
      'commentVotesIds': instance.commentVotesIds,
      'replyVotesIds': instance.replyVotesIds,
      'files': instance.files,
      'followersIds': instance.followersIds,
      'followingIds': instance.followingIds,
      'followers': instance.followers,
      'following': instance.following,
      'activityFeedIds': instance.activityFeedIds,
      'citizenPoints': instance.citizenPoints,
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

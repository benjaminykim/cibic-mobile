// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserModel _$SearchUserModelFromJson(Map<String, dynamic> json) {
  return SearchUserModel(
    (json['user'] as List)
        ?.map((e) =>
            e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchUserModelToJson(SearchUserModel instance) =>
    <String, dynamic>{
      'user': instance.user?.map((e) => e?.toJson())?.toList(),
    };

SearchCabildoModel _$SearchCabildoModelFromJson(Map<String, dynamic> json) {
  return SearchCabildoModel(
    (json['cabildo'] as List)
        ?.map((e) =>
            e == null ? null : CabildoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchCabildoModelToJson(SearchCabildoModel instance) =>
    <String, dynamic>{
      'cabildo': instance.cabildo?.map((e) => e?.toJson())?.toList(),
    };

SearchTagModel _$SearchTagModelFromJson(Map<String, dynamic> json) {
  return SearchTagModel(
    (json['tag'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  );
}

Map<String, dynamic> _$SearchTagModelToJson(SearchTagModel instance) =>
    <String, dynamic>{
      'tag': instance.tag,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedModel _$FeedModelFromJson(Map<String, dynamic> json) {
  return FeedModel(
    (json['feed'] as List)
        ?.map((e) => e == null
            ? null
            : ActivityModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FeedModelToJson(FeedModel instance) => <String, dynamic>{
      'feed': instance.feed?.map((e) => e?.toJson())?.toList(),
    };

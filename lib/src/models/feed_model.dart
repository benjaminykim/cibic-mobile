import 'package:json_annotation/json_annotation.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';

part 'feed_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FeedModel {
  List<ActivityModel> feed;

  FeedModel(this.feed);

  factory FeedModel.fromJson(Map<String, dynamic> json) => _$FeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedModelToJson(this);
}
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cabildo_model.g.dart';

@JsonSerializable()
class CabildoModel {
  String id;
  String name;
  List<String> members;
  List<String> moderators;
  String admin;
  String location;
  List<String> issues;
  List<String> meetings;
  List<String> files;
  List<ActivityModel> activities;

  CabildoModel(this.id, this.name, this.members, this.moderators, this.admin, this.location, this.issues,
  this.meetings, this.files, this.activities);

  factory CabildoModel.fromJson(Map<String, dynamic> json) => _$CabildoModelFromJson(json);

  Map<String, String> toJson() => _$CabildoModelToJson(this);
}
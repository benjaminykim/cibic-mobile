import 'package:json_annotation/json_annotation.dart';

part 'cabildo_model.g.dart';

@JsonSerializable()
class CabildoModel {
  String id;
  List<String> members;
  List<String> moderators;
  List<String> issues;
  List<String> meetings;
  List<String> files;
  List<String> activities;
  String name;
  String admin;
  String location;

  CabildoModel(this.id, this.name, this.members, this.moderators, this.admin, this.location, this.issues,
  this.meetings, this.files, this.activities);

  factory CabildoModel.fromJson(Map<String, dynamic> json) => _$CabildoModelFromJson(json);

  Map<String, String> toJson() => _$CabildoModelToJson(this);
}
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cabildo_model.g.dart';

@JsonSerializable()
class CabildoModel {
  int id;
  String name;
  String location;
  String desc;
  UserModel admin;
  List<UserModel> members;
  List<UserModel> moderators;

  CabildoModel(this.id, this.name, this.location, this.desc, this.admin, this.members, this.moderators);

  factory CabildoModel.fromJson(Map<String, dynamic> json) => _$CabildoModelFromJson(json);

  Map<String, String> toJson() => _$CabildoModelToJson(this);
}
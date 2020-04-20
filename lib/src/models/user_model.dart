import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  List<CabildoModel> cabildos;
  List<String> activityVotes;
  List<String> commentVotes;
  List<String> files;
  List<String> followers;
  List<Map<String, dynamic>> following;
  List<String> activityFeed;
  List<String> followingFeed;
  int citizenPoints;
  String username;
  String email;
  String password;
  String firstName;
  String middleName;
  String lastName;
  String maidenName;
  int phone;
  String rut;
  String desc;

  UserModel(this.id, this.cabildos, this.activityVotes, this.commentVotes, this.files, this.followers,
  this.following, this.activityFeed, this.followingFeed, this.citizenPoints, this.username, this.email,
  this.password, this.firstName, this.middleName, this.lastName, this.maidenName, this.phone, this.rut, this.desc);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
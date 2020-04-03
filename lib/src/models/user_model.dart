import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  String username;
  String email;
  String password;
  String firstName;
  String middleName;
  String lastName;
  String maidenName;
  int phone;
  int citizenPoints;
  String rut;
  List<String> cabildos;
  List<String> activityVotes;
  List<String> commentVotes;
  List<String> files;
  List<String> followers;
  List<String> following;
  List<ActivityModel> activityFeed;

  UserModel(this.id, this.username, this.email, this.password, this.firstName, this.middleName, this.lastName,
  this.maidenName, this.phone, this.citizenPoints, this.rut, this.cabildos, this.activityVotes, this.commentVotes, this.files,
  this.followers, this.following, this.activityFeed);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
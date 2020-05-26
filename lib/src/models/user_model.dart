import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  List<int> cabildosIds;
  List<CabildoModel> cabildos;
  List<int> activityVotes;
  List<int> commentVotesIds;
  List<int> replyVotesIds;
  List<String> files;
  List<int> followersIds;
  List<int> followingIds;
  List<UserModel> followers;
  List<UserModel> following;
  List<int> activityFeedIds;
  int citizenPoints;
  String email;
  String password;
  String firstName;
  String middleName;
  String lastName;
  String maidenName;
  int phone;
  String rut;
  String desc;

  UserModel(this.id, this.cabildosIds, this.cabildos, this.activityVotes, this.commentVotesIds, this.files, this.followersIds,
  this.followingIds, this.activityFeedIds, this.citizenPoints, this.email,
  this.password, this.firstName, this.middleName, this.lastName, this.maidenName, this.phone, this.rut, this.desc);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
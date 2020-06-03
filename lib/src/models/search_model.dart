import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchUserModel {
  List<UserModel> user;

  SearchUserModel(this.user);

  factory SearchUserModel.fromJson(Map<String, dynamic> json) => _$SearchUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchCabildoModel {
  List<CabildoModel> cabildo;

  SearchCabildoModel(this.cabildo);

  factory SearchCabildoModel.fromJson(Map<String, dynamic> json) => _$SearchCabildoModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCabildoModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchTagModel {
  List<Map<String, dynamic>> tags;

  SearchTagModel(this.tags);

  factory SearchTagModel.fromJson(Map<String, dynamic> json) => _$SearchTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTagModelToJson(this);

}
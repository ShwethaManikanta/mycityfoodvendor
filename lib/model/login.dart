import 'package:mycityfoodvendor/model/profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(required: false)
  String? status;

  @JsonKey(required: false)
  String? message;

  @JsonKey(required: false)
  UserDetails? driver_details;

  LoginModel({
    this.status,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

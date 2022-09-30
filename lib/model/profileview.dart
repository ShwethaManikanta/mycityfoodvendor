/*
import 'package:json_annotation/json_annotation.dart';

part 'profileview.g.dart';

@JsonSerializable()
class ProfileModel {
  @JsonKey(required: false)
  String? status;

  @JsonKey(required: false)
  String? message;

  @JsonKey(required: false)
  String? tooltip;

  @JsonKey(required: false)
  String? user_id;

  @JsonKey(required: false)
  UserDetails? user_details;

  @JsonKey(required: false)
  String profile_baseurl;

  ProfileModel(
      {this.status,
      this.message,
      this.tooltip,
      this.user_details,
      this.user_id,
      required this.profile_baseurl});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
class UserDetails {
  @JsonKey(required: false)
  String? id;

  @JsonKey(required: false)
  String? outlet_name;

  @JsonKey(required: false)
  String? image;

  @JsonKey(required: false)
  String? athar_image;

  @JsonKey(required: false)
  String? license_image;

  @JsonKey(required: false)
  String? request_amt;

  @JsonKey(required: false)
  String? email;

  @JsonKey(required: false)
  String? gst_number;

  @JsonKey(required: false)
  String? password;

  @JsonKey(required: false)
  String? decrypt_password;

  @JsonKey(required: false)
  String? mobile;

  @JsonKey(required: false)
  String? pwd_otp;

  @JsonKey(required: false)
  String? outlet_address;

  @JsonKey(required: false)
  String? food_type;

  @JsonKey(required: false)
  String? food_type_id;

  @JsonKey(required: false)
  String? gst;

  @JsonKey(required: false)
  String? latitude;

  @JsonKey(required: false)
  String? longitude;

  @JsonKey(required: false)
  String? device_token;

  @JsonKey(required: false)
  String? status;

  @JsonKey(required: false)
  String? created_at;

  UserDetails(
      {this.status,
      this.id,
      this.outlet_address,
      this.athar_image,
      this.created_at,
      this.decrypt_password,
      this.device_token,
      this.email,
      this.food_type,
      this.gst,
      this.image,
      this.license_image,
      this.mobile,
      this.password,
      this.pwd_otp,
      this.latitude,
      this.longitude,
      this.outlet_name});

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
*/

/*
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      tooltip: json['tooltip'] as String?,
      user_details: json['user_details'] == null
          ? null
          : UserDetails.fromJson(json['user_details'] as Map<String, dynamic>),
      user_id: json['user_id'] as String?,
      profile_baseurl: json['profile_baseurl'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'tooltip': instance.tooltip,
      'user_id': instance.user_id,
      'user_details': instance.user_details,
      'profile_baseurl': instance.profile_baseurl,
    };

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      status: json['status'] as String?,
      id: json['id'] as String?,
      outlet_address: json['outlet_address'] as String?,
      athar_image: json['athar_image'] as String?,
      created_at: json['created_at'] as String?,
      decrypt_password: json['decrypt_password'] as String?,
      device_token: json['device_token'] as String?,
      email: json['email'] as String?,
      food_type: json['food_type'] as String?,
      gst: json['gst'] as String?,
      image: json['image'] as String?,
      license_image: json['license_image'] as String?,
      mobile: json['mobile'] as String?,
      password: json['password'] as String?,
      pwd_otp: json['pwd_otp'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      outlet_name: json['outlet_name'] as String?,
    )
      ..request_amt = json['request_amt'] as String?
      ..gst_number = json['gst_number'] as String?
      ..food_type_id = json['food_type_id'] as String?;

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outlet_name': instance.outlet_name,
      'image': instance.image,
      'athar_image': instance.athar_image,
      'license_image': instance.license_image,
      'request_amt': instance.request_amt,
      'email': instance.email,
      'gst_number': instance.gst_number,
      'password': instance.password,
      'decrypt_password': instance.decrypt_password,
      'mobile': instance.mobile,
      'pwd_otp': instance.pwd_otp,
      'outlet_address': instance.outlet_address,
      'food_type': instance.food_type,
      'food_type_id': instance.food_type_id,
      'gst': instance.gst,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'device_token': instance.device_token,
      'status': instance.status,
      'created_at': instance.created_at,
    };
*/

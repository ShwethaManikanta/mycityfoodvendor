// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    )..driver_details = json['driver_details'] == null
        ? null
        : UserDetails.fromJson(json['driver_details'] as Map<String, dynamic>);

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'driver_details': instance.driver_details,
    };

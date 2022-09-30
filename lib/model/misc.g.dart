// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'misc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotModel _$ForgotModelFromJson(Map<String, dynamic> json) => ForgotModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    )
      ..otp = json['otp'] as String?
      ..user_id = json['user_id'] as String?
      ..withdraw_detail_list = (json['withdraw_detail_list'] as List<dynamic>?)
          ?.map((e) => WithDrawList.fromJson(e as Map<String, dynamic>))
          .toList();
// ..product_list = (json['product_list'] as List<dynamic>?)
//     ?.map((e) => ProductList.fromJson(e as Map<String, dynamic>))
//     .toList();

Map<String, dynamic> _$ForgotModelToJson(ForgotModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'otp': instance.otp,
      'user_id': instance.user_id,
      'withdraw_detail_list': instance.withdraw_detail_list,
      // 'product_list': instance.product_list,
    };

// ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
//       id: json['id'] as String?,
//       menu_name: json['menu_name'] as String?,
//       mrp: json['mrp'] as String?,
//     )..status = json['status'] as String?;

// Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'menu_name': instance.menu_name,
//       'mrp': instance.mrp,
//       'status': instance.status,
//     };

WithDrawList _$WithDrawListFromJson(Map<String, dynamic> json) => WithDrawList(
      id: json['id'] as String?,
      date_time: json['date_time'] as String?,
      total: json['total'] as String?,
    );

Map<String, dynamic> _$WithDrawListToJson(WithDrawList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date_time': instance.date_time,
      'total': instance.total,
    };

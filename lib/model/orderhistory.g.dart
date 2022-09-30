// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderhistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// OrderCancelledModel _$OrderCancelledModelFromJson(Map<String, dynamic> json) =>
//     OrderCancelledModel(
//       status: json['status'] as String?,
//       message: json['message'] as String?,
//       order_history_list: (json['order_history_list'] as List<dynamic>?)
//           ?.map((e) => OrderList.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       product_image_baseurl: json['product_image_baseurl'] as String?,
//     )
//       ..order_completed_list = (json['order_completed_list'] as List<dynamic>?)
//           ?.map((e) => OrderList.fromJson(e as Map<String, dynamic>))
//           .toList()
//       ..order_history = (json['order_history'] as List<dynamic>?)
//           ?.map((e) => OrderList.fromJson(e as Map<String, dynamic>))
//           .toList();

// Map<String, dynamic> _$OrderCancelledModelToJson(
//         OrderCancelledModel instance) =>
//     <String, dynamic>{
//       'status': instance.status,
//       'message': instance.message,
//       'product_image_baseurl': instance.product_image_baseurl,
//       'order_history_list': instance.order_history_list,
//       'order_completed_list': instance.order_completed_list,
//       'order_history': instance.order_history,
//     };

// OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
//       id: json['id'] as String?,
//       total: json['total'] as String?,
//       product_name: (json['product_name'] as List<dynamic>?)
//           ?.map((e) => ProductName.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       status: json['status'] as String?,
//       address: json['address'] as String?,
//       customer_name: json['customer_name'] as String?,
//       delivery_date: json['delivery_date'] as String?,
//     )..product_details = json['product_details'] == null
//         ? null
//         : ProductName.fromJson(json['product_details'] as Map<String, dynamic>);

// Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
//       'id': instance.id,
//       'total': instance.total,
//       'customer_name': instance.customer_name,
//       'address': instance.address,
//       'delivery_date': instance.delivery_date,
//       'status': instance.status,
//       'product_details': instance.product_details,
//       'product_name': instance.product_name,
//     };

// ProductName _$ProductNameFromJson(Map<String, dynamic> json) => ProductName(
//       id: json['id'] as String?,
//       name: json['name'] as String?,
//       quantity: json['quantity'] as String?,
//       qty: json['qty'] as String?,
//     )
//       ..product_name = json['product_name'] as String?
//       ..price = json['price'];

// Map<String, dynamic> _$ProductNameToJson(ProductName instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'name': instance.name,
//       'product_name': instance.product_name,
//       'quantity': instance.quantity,
//       'qty': instance.qty,
//       'price': instance.price,
//     };

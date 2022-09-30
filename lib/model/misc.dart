import 'package:json_annotation/json_annotation.dart';

part 'misc.g.dart';

@JsonSerializable()
class ForgotModel {
  @JsonKey(required: false)
  String? status;

  @JsonKey(required: false)
  String? message;

  @JsonKey(required: false)
  String? otp;

  @JsonKey(required: false)
  String? user_id;

  @JsonKey(required: false)
  List<WithDrawList>? withdraw_detail_list;

  // @JsonKey(required: false)
  // List<ProductList>? product_list;

  ForgotModel({
    this.status,
    this.message,
  });

  factory ForgotModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotModelToJson(this);
}

// @JsonSerializable()
// class ProductList {
//   @JsonKey(required: false)
//   String? id;

//   @JsonKey(required: false)
//   String? menu_name;

//   @JsonKey(required: false)
//   String? mrp;

//   @JsonKey(required: false)
//   String? status;

//   ProductList({
//     this.id,
//     this.menu_name,
//     this.mrp,
//   });

//   factory ProductList.fromJson(Map<String, dynamic> json) =>
//       _$ProductListFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductListToJson(this);
// }

@JsonSerializable()
class WithDrawList {
  @JsonKey(required: false)
  String? id;

  @JsonKey(required: false)
  String? date_time;

  @JsonKey(required: false)
  String? total;

  WithDrawList({this.id, this.date_time, this.total});

  factory WithDrawList.fromJson(Map<String, dynamic> json) =>
      _$WithDrawListFromJson(json);

  Map<String, dynamic> toJson() => _$WithDrawListToJson(this);
}

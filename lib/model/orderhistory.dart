import 'package:json_annotation/json_annotation.dart';
part 'orderhistory.g.dart';

// @JsonSerializable()
// class OrderCancelledModel {
//   @JsonKey(required: false)
//   String? status;

//   @JsonKey(required: false)
//   String? message;

//   @JsonKey(required: false)
//   String? product_image_baseurl;

//   @JsonKey(required: false)
//   List<OrderList>? order_history_list;

//   @JsonKey(required: false)
//   List<OrderList>? order_completed_list;

//   @JsonKey(required: false)
//   List<OrderList>? order_history;

//   OrderCancelledModel(
//       {this.status,
//       this.message,
//       this.order_history_list,
//       this.product_image_baseurl});

//   factory OrderCancelledModel.fromJson(Map<String, dynamic> json) =>
//       _$OrderCancelledModelFromJson(json);

//   Map<String, dynamic> toJson() => _$OrderCancelledModelToJson(this);
// }

// @JsonSerializable()
// class OrderList {
//   @JsonKey(required: false)
//   String? id;

//   @JsonKey(required: false)
//   String? total;

//   @JsonKey(required: false)
//   String? customer_name;

//   @JsonKey(required: false)
//   String? address;

//   @JsonKey(required: false)
//   String? delivery_date;

//   @JsonKey(required: false)
//   String? status;

//   @JsonKey(required: false)
//   ProductName? product_details;

//   @JsonKey(required: false)
//   List<ProductName>? product_name;

//   OrderList(
//       {this.id,
//       this.total,
//       this.product_name,
//       this.status,
//       this.address,
//       this.customer_name,
//       this.delivery_date});

//   factory OrderList.fromJson(Map<String, dynamic> json) =>
//       _$OrderListFromJson(json);

//   Map<String, dynamic> toJson() => _$OrderListToJson(this);
// }

// @JsonSerializable()
// class ProductName {
//   @JsonKey(required: false)
//   String? id;

//   @JsonKey(required: false)
//   String? name;

//   @JsonKey(required: false)
//   String? product_name;

//   @JsonKey(required: false)
//   String? quantity;

//   @JsonKey(required: false)
//   String? qty;

//   @JsonKey(required: false)
//   dynamic? price;

//   ProductName({this.id, this.name, this.quantity, this.qty});

//   factory ProductName.fromJson(Map<String, dynamic> json) =>
//       _$ProductNameFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductNameToJson(this);
// }

class OrderCompleteModel {
  String? status;
  String? message;
  String? productImageBaseurl;
  List<OrderCompletedList>? orderCompletedList;

  OrderCompleteModel(
      {this.status,
      this.message,
      this.productImageBaseurl,
      this.orderCompletedList});

  OrderCompleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productImageBaseurl = json['product_image_baseurl'];
    if (json['order_completed_list'] != null) {
      orderCompletedList = <OrderCompletedList>[];
      json['order_completed_list'].forEach((v) {
        orderCompletedList!.add(new OrderCompletedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_image_baseurl'] = this.productImageBaseurl;
    if (this.orderCompletedList != null) {
      data['order_completed_list'] =
          this.orderCompletedList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderCompletedList {
  String? id;
  List<ProductDetails>? productDetails;
  String? customerName;
  String? address;
  String? total;
  String? deliveryDate;
  String? status;

  OrderCompletedList(
      {this.id,
      this.productDetails,
      this.customerName,
      this.address,
      this.total,
      this.deliveryDate,
      this.status});

  OrderCompletedList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    customerName = json['customer_name'];
    address = json['address'];
    total = json['total'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['total'] = this.total;
    data['delivery_date'] = this.deliveryDate;
    data['status'] = this.status;
    return data;
  }
}

class OrderCancelledModel {
  String? status;
  String? message;
  String? productImageBaseurl;
  List<OrderHistoryList>? orderHistoryList;

  OrderCancelledModel(
      {this.status,
      this.message,
      this.productImageBaseurl,
      this.orderHistoryList});

  OrderCancelledModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productImageBaseurl = json['product_image_baseurl'];
    if (json['order_history_list'] != null) {
      orderHistoryList = <OrderHistoryList>[];
      json['order_history_list'].forEach((v) {
        orderHistoryList!.add(new OrderHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_image_baseurl'] = this.productImageBaseurl;
    if (this.orderHistoryList != null) {
      data['order_history_list'] =
          this.orderHistoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistoryList {
  String? id;
  List<ProductDetails>? productDetails;
  String? customerName;
  String? address;
  String? total;
  String? deliveryDate;
  String? status;

  OrderHistoryList(
      {this.id,
      this.productDetails,
      this.customerName,
      this.address,
      this.total,
      this.deliveryDate,
      this.status});

  OrderHistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    customerName = json['customer_name'];
    address = json['address'];
    total = json['total'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['total'] = this.total;
    data['delivery_date'] = this.deliveryDate;
    data['status'] = this.status;
    return data;
  }
}

class OngoingOrderResponseModel {
  String? status;
  String? message;
  String? retailerProfileurl;
  List<OrderHistory>? orderHistory;

  OngoingOrderResponseModel(
      {this.status, this.message, this.retailerProfileurl, this.orderHistory});

  OngoingOrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    retailerProfileurl = json['retailer_profileurl'];
    if (json['order_history'] != null) {
      orderHistory = <OrderHistory>[];
      json['order_history'].forEach((v) {
        orderHistory!.add(new OrderHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['retailer_profileurl'] = this.retailerProfileurl;
    if (this.orderHistory != null) {
      data['order_history'] =
          this.orderHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistory {
  String? id;
  List<ProductDetails>? productDetails;
  CustomerName? customerName;
  String? address;
  String? total;
  String? deliveryDate;
  String? status;

  OrderHistory(
      {this.id,
      this.productDetails,
      this.customerName,
      this.address,
      this.total,
      this.deliveryDate,
      this.status});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    customerName = json['customer_name'] != null
        ? new CustomerName.fromJson(json['customer_name'])
        : null;
    address = json['address'];
    total = json['total'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    if (this.customerName != null) {
      data['customer_name'] = this.customerName!.toJson();
    }
    data['address'] = this.address;
    data['total'] = this.total;
    data['delivery_date'] = this.deliveryDate;
    data['status'] = this.status;
    return data;
  }
}

class ProductDetails {
  String? id;
  String? productName;
  String? qty;
  int? price;

  ProductDetails({this.id, this.productName, this.qty, this.price});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}

class CustomerName {
  String? id;
  String? firebaseId;
  String? customerName;
  String? mobile;
  String? password;
  String? pwdOtp;
  String? addtionalNumber;
  String? email;
  String? addressTypeId;
  String? selectedAddress;
  String? address;
  String? landMark;
  String? floor;
  String? reach;
  String? lat;
  String? long;
  String? status;
  String? deviceType;
  String? deviceToken;
  String? createdAt;

  CustomerName(
      {this.id,
      this.firebaseId,
      this.customerName,
      this.mobile,
      this.password,
      this.pwdOtp,
      this.addtionalNumber,
      this.email,
      this.addressTypeId,
      this.selectedAddress,
      this.address,
      this.landMark,
      this.floor,
      this.reach,
      this.lat,
      this.long,
      this.status,
      this.deviceType,
      this.deviceToken,
      this.createdAt});

  CustomerName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    customerName = json['customer_name'];
    mobile = json['mobile'];
    password = json['password'];
    pwdOtp = json['pwd_otp'];
    addtionalNumber = json['addtional_number'];
    email = json['email'];
    addressTypeId = json['address_type_id'];
    selectedAddress = json['selected_address'];
    address = json['address'];
    landMark = json['land_mark'];
    floor = json['floor'];
    reach = json['reach'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['customer_name'] = this.customerName;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['pwd_otp'] = this.pwdOtp;
    data['addtional_number'] = this.addtionalNumber;
    data['email'] = this.email;
    data['address_type_id'] = this.addressTypeId;
    data['selected_address'] = this.selectedAddress;
    data['address'] = this.address;
    data['land_mark'] = this.landMark;
    data['floor'] = this.floor;
    data['reach'] = this.reach;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class LoginResponseModel {
  String? status;
  String? message;
  DriverDetails? driverDetails;

  LoginResponseModel({this.status, this.message, this.driverDetails});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    driverDetails = json['driver_details'] != null
        ? new DriverDetails.fromJson(json['driver_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.driverDetails != null) {
      data['driver_details'] = this.driverDetails!.toJson();
    }
    return data;
  }
}

class DriverDetails {
  String? id;
  String? type;
  String? outletMainId;
  String? outletSubId;
  String? email;
  String? password;
  String? decryptPassword;
  String? mobile;
  String? pwdOtp;
  String? image;
  String? atharImage;
  String? licenseImage;
  String? fssaiNumber;
  String? fssaiExpiryDate;
  String? outletName;
  String? outletAddress;
  String? deliveryTime;
  String? offerSpot;
  String? upTo;
  String? outletImage;
  String? latitude;
  String? longitude;
  String? foodTypeId;
  String? restaurantType;
  String? gstStatus;
  String? gstPercentage;
  String? gstImage;
  String? gstNumber;
  String? carryBag;
  String? sponsor;
  String? orderType;
  String? bankCheckList;
  String? description;
  String? deviceToken;
  String? status;
  String? requestStatus;
  String? requestAmt;
  String? createdAt;
  String? updatedAt;

  DriverDetails(
      {this.id,
      this.type,
      this.outletMainId,
      this.outletSubId,
      this.email,
      this.password,
      this.decryptPassword,
      this.mobile,
      this.pwdOtp,
      this.image,
      this.atharImage,
      this.licenseImage,
      this.fssaiNumber,
      this.fssaiExpiryDate,
      this.outletName,
      this.outletAddress,
      this.deliveryTime,
      this.offerSpot,
      this.upTo,
      this.outletImage,
      this.latitude,
      this.longitude,
      this.foodTypeId,
      this.restaurantType,
      this.gstStatus,
      this.gstPercentage,
      this.gstImage,
      this.gstNumber,
      this.carryBag,
      this.sponsor,
      this.orderType,
      this.bankCheckList,
      this.description,
      this.deviceToken,
      this.status,
      this.requestStatus,
      this.requestAmt,
      this.createdAt,
      this.updatedAt});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    outletMainId = json['outlet_main_id'];
    outletSubId = json['outlet_sub_id'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    mobile = json['mobile'];
    pwdOtp = json['pwd_otp'];
    image = json['image'];
    atharImage = json['athar_image'];
    licenseImage = json['license_image'];
    fssaiNumber = json['fssai_number'];
    fssaiExpiryDate = json['fssai_expiry_date'];
    outletName = json['outlet_name'];
    outletAddress = json['outlet_address'];
    deliveryTime = json['delivery_time'];
    offerSpot = json['offer_spot'];
    upTo = json['up_to'];
    outletImage = json['outlet_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    foodTypeId = json['food_type_id'];
    restaurantType = json['restaurant_type'];
    gstStatus = json['gst_status'];
    gstPercentage = json['gst_percentage'];
    gstImage = json['gst_image'];
    gstNumber = json['gst_number'];
    carryBag = json['carry_bag'];
    sponsor = json['sponsor'];
    orderType = json['order_type'];
    bankCheckList = json['bank_check_list'];
    description = json['description'];
    deviceToken = json['device_token'];
    status = json['status'];
    requestStatus = json['request_status'];
    requestAmt = json['request_amt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['outlet_main_id'] = this.outletMainId;
    data['outlet_sub_id'] = this.outletSubId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['mobile'] = this.mobile;
    data['pwd_otp'] = this.pwdOtp;
    data['image'] = this.image;
    data['athar_image'] = this.atharImage;
    data['license_image'] = this.licenseImage;
    data['fssai_number'] = this.fssaiNumber;
    data['fssai_expiry_date'] = this.fssaiExpiryDate;
    data['outlet_name'] = this.outletName;
    data['outlet_address'] = this.outletAddress;
    data['delivery_time'] = this.deliveryTime;
    data['offer_spot'] = this.offerSpot;
    data['up_to'] = this.upTo;
    data['outlet_image'] = this.outletImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['food_type_id'] = this.foodTypeId;
    data['restaurant_type'] = this.restaurantType;
    data['gst_status'] = this.gstStatus;
    data['gst_percentage'] = this.gstPercentage;
    data['gst_image'] = this.gstImage;
    data['gst_number'] = this.gstNumber;
    data['carry_bag'] = this.carryBag;
    data['sponsor'] = this.sponsor;
    data['order_type'] = this.orderType;
    data['bank_check_list'] = this.bankCheckList;
    data['description'] = this.description;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['request_status'] = this.requestStatus;
    data['request_amt'] = this.requestAmt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

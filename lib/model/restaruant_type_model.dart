class RestaruantTypeModel {
  String? status;
  String? message;
  List<OutletList>? outletList;

  RestaruantTypeModel({this.status, this.message, this.outletList});

  RestaruantTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['outlet_list'] != null) {
      outletList = <OutletList>[];
      json['outlet_list'].forEach((v) {
        outletList!.add(new OutletList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.outletList != null) {
      data['outlet_list'] = this.outletList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutletList {
  String? id;
  String? outletName;
  String? outletAddress;
  String? description;

  OutletList({this.id, this.outletName});

  OutletList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletName = json['outlet_name'];
    outletAddress = json['outlet_address'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_name'] = this.outletName;
    return data;
  }
}

class MallListResponseModel {
  String? status;
  String? message;
  List<MallList>? mallList;

  MallListResponseModel({this.status, this.message, this.mallList});

  MallListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['mall_list'] != null) {
      mallList = <MallList>[];
      json['mall_list'].forEach((v) {
        mallList!.add(new MallList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.mallList != null) {
      data['mall_list'] = this.mallList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MallList {
  String? id;
  String? mallName;
  String? status;
  String? createdAt;

  MallList({this.id, this.mallName, this.status, this.createdAt});

  MallList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mallName = json['mall_name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mall_name'] = this.mallName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

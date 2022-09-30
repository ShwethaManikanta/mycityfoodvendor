class LimitListResponseModel {
  String? status;
  String? message;
  List<LimitsList>? limitsList;

  LimitListResponseModel({this.status, this.message, this.limitsList});

  LimitListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['limits_list'] != null) {
      limitsList = <LimitsList>[];
      json['limits_list'].forEach((v) {
        limitsList!.add(new LimitsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.limitsList != null) {
      data['limits_list'] = this.limitsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LimitsList {
  String? id;
  String? limits;
  String? status;
  String? createdAt;

  LimitsList({this.id, this.limits, this.status, this.createdAt});

  LimitsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    limits = json['limits'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['limits'] = this.limits;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

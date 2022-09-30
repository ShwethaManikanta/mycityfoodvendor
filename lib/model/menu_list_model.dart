class MenuListResponseModel {
  String? status;
  String? message;
  List<ProductList>? productList;

  MenuListResponseModel({this.status, this.message, this.productList});

  MenuListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productList != null) {
      data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? id;
  String? menuName;
  String? mrp;
  String? status;

  ProductList({this.id, this.menuName, this.mrp, this.status});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuName = json['menu_name'];
    mrp = json['mrp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_name'] = this.menuName;
    data['mrp'] = this.mrp;
    data['status'] = this.status;
    return data;
  }
}

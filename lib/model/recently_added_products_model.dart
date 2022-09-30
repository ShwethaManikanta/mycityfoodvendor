class RecentlyAddedProdutsModel {
  String? status;
  String? message;
  String? productImageUrl;
  List<RProductDetails>? productDetails;

  RecentlyAddedProdutsModel(
      {this.status, this.message, this.productImageUrl, this.productDetails});

  RecentlyAddedProdutsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productImageUrl = json['product_image_url'];
    if (json['product_details'] != null) {
      productDetails = <RProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(RProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_image_url'] = this.productImageUrl;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RProductDetails {
  String? id;
  String? vendorId;
  String? vendorName;
  String? productName;
  String? productImage;
  String? salePrice;
  String? mrp;
  String? qty;
  String? qty_type;
  String? serviceTax;
  String? foodType;
  String? resType;
  String? packingTax;
  String? categoryId;
  String? discount;
  String? productStock;
  String? description;
  String? approvelStatus;
  String? taxType;
  String? categoryName;
  String? containerChages;

  RProductDetails(
      {this.id,
      this.vendorId,
      this.vendorName,
      this.productName,
      this.productImage,
      this.salePrice,
      this.mrp,
      this.categoryId,
      this.qty,
      this.taxType,
      this.qty_type,
      this.containerChages,
      this.foodType,
      this.categoryName,
      this.resType,
      this.serviceTax,
      this.packingTax,
      this.discount,
      this.productStock,
      this.description,
      this.approvelStatus});

  RProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    productName = json['product_name'];
    productImage = json['product_image'];
    salePrice = json['sale_price'];
    mrp = json['mrp'];
    qty = json['qty'];
    taxType = json['tax_type'];
    qty_type = json['meat_qty'];
    foodType = json['food_type'];
    resType = json['res_type'];
    serviceTax = json['service_tax'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    packingTax = json['packing_tax'];
    containerChages = json["container_charge"];
    discount = json['discount'];
    productStock = json['product_stock'];
    description = json['description'];
    approvelStatus = json['approvel_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['sale_price'] = this.salePrice;
    data['mrp'] = this.mrp;
    data['meat_qty'] = this.qty;
    data['meat_qty_type'] = this.qty_type;
    data['food_type'] = this.foodType;
    data['res_type'] = this.resType;
    data['category_id'] = this.categoryId;
    data['service_tax'] = this.serviceTax;
    data['packing_tax'] = this.packingTax;
    data['discount'] = this.discount;
    data['product_stock'] = this.productStock;
    data['description'] = this.description;
    data['approvel_status'] = this.approvelStatus;
    return data;
  }
}

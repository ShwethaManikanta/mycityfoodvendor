class AddProductRequestModel {
  final String vendorId,
      productName,
      productImage,
      salePrice,
      mrp,
      discount,
      serviceTax,
      taxType,
      packingTax,
      stock,
      foodType,
      restaruantType,
      categoryId,
      quantity,
      quantityType,
      containerCharges,
      description;

  AddProductRequestModel({
    required this.vendorId,
    required this.productName,
    required this.productImage,
    required this.salePrice,
    required this.mrp,
    required this.discount,
    required this.taxType,
    required this.containerCharges,
    required this.serviceTax,
    required this.packingTax,
    required this.stock,
    required this.foodType,
    required this.restaruantType,
    required this.categoryId,
    required this.quantity,
    required this.quantityType,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'vendor_id': vendorId,
      'product_name': productName,
      'product_image': productImage,
      'sale_price': salePrice,
      'mrp': mrp,
      'discount': discount,
      'tax_type': taxType,
      'service_tax': serviceTax,
      'packing_tax': packingTax,
      'stock': stock,
      'res_type': foodType,
      'bus_type': restaruantType,
      'category_id': categoryId,
      'meat_qty': quantity,
      'meat_qty_type': quantityType,
      'description': description,
      'container_charge': containerCharges
    };
  }
}

class ProductInfo {
  List<Products>? products;

  ProductInfo({this.products});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  String? name;
  String? price;
  String? special;
  String? status;

  Products({this.productId, this.name, this.price, this.special, this.status});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    special = json['special'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['special'] = special;
    data['status'] = status;
    return data;
  }
}

class AddProductResponseModel {
  String? status;
  String? message;
  ProductDetails? productDetails;

  AddProductResponseModel({this.status, this.message, this.productDetails});

  AddProductResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  String? id;
  String? outletId;
  String? categoryId;
  String? menuName;
  String? menuType;
  String? adonId;
  String? description;
  String? menuImage;
  String? mrp;
  String? qty;
  String? qtyType;
  String? foodType;
  String? resType;
  String? commissionAmt;
  String? serviceTax;
  String? packingTax;
  String? productStock;
  String? salePrice;
  String? discountAmount;
  String? discountPercentage;
  String? approvelStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProductDetails(
      {this.id,
      this.outletId,
      this.categoryId,
      this.menuName,
      this.menuType,
      this.adonId,
      this.description,
      this.menuImage,
      this.mrp,
      this.qty,
      this.qtyType,
      this.foodType,
      this.resType,
      this.commissionAmt,
      this.serviceTax,
      this.packingTax,
      this.productStock,
      this.salePrice,
      this.discountAmount,
      this.discountPercentage,
      this.approvelStatus,
      this.status,
      this.createdAt,
      this.updatedAt});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    categoryId = json['category_id'];
    menuName = json['menu_name'];
    menuType = json['menu_type'];
    adonId = json['adon_id'];
    description = json['description'];
    menuImage = json['menu_image'];
    mrp = json['mrp'];
    qty = json['qty'];
    qtyType = json['qty_type'];
    foodType = json['food_type'];
    resType = json['res_type'];
    commissionAmt = json['commission_amt'];
    serviceTax = json['service_tax'];
    packingTax = json['packing_tax'];
    productStock = json['product_stock'];
    salePrice = json['sale_price'];
    discountAmount = json['discount_amount'];
    discountPercentage = json['discount_percentage'];
    approvelStatus = json['approvel_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['category_id'] = this.categoryId;
    data['menu_name'] = this.menuName;
    data['menu_type'] = this.menuType;
    data['adon_id'] = this.adonId;
    data['description'] = this.description;
    data['menu_image'] = this.menuImage;
    data['mrp'] = this.mrp;
    data['qty'] = this.qty;
    data['qty_type'] = this.qtyType;
    data['food_type'] = this.foodType;
    data['res_type'] = this.resType;
    data['commission_amt'] = this.commissionAmt;
    data['service_tax'] = this.serviceTax;
    data['packing_tax'] = this.packingTax;
    data['product_stock'] = this.productStock;
    data['sale_price'] = this.salePrice;
    data['discount_amount'] = this.discountAmount;
    data['discount_percentage'] = this.discountPercentage;
    data['approvel_status'] = this.approvelStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UpdateProductResponse {
  late String status;
  late String message;
  ProductDetails? productDetails;

  UpdateProductResponse(
      {required this.status,
      required this.message,
      required this.productDetails});

  UpdateProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetailsUpdateResponse {
  ProductDetails? productDetails;

  ProductDetailsUpdateResponse({this.productDetails});

  ProductDetailsUpdateResponse.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  late String id;
  late String outletId;
  late String categoryId;
  late String menuName;
  late String menuType;
  late String adonId;
  late String description;
  late String menuImage;
  late String mrp;
  late String qty;
  late String qtyType;
  late String foodType;
  late String resType;
  late String commissionAmt;
  late String serviceTax;
  late String packingTax;
  late String productStock;
  late String salePrice;
  late String discountAmount;
  late String discountPercentage;
  late String approvelStatus;
  late String status;
  late String createdAt;
  late String updatedAt;

  ProductDetails(
      {required this.id,
      required this.outletId,
      required this.categoryId,
      required this.menuName,
      required this.menuType,
      required this.adonId,
      required this.description,
      required this.menuImage,
      required this.mrp,
      required this.qty,
      required this.qtyType,
      required this.foodType,
      required this.resType,
      required this.commissionAmt,
      required this.serviceTax,
      required this.packingTax,
      required this.productStock,
      required this.salePrice,
      required this.discountAmount,
      required this.discountPercentage,
      required this.approvelStatus,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

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
    qty = json['meat_qty'];
    qtyType = json['meat_qty_type'];
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
    data['meat_qty'] = this.qty;
    data['meat_qty_type'] = this.qtyType;
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

class UpdateProductRequestModel {
  final String productId,
      vendorId,
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
      description;

  UpdateProductRequestModel({
    required this.vendorId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.salePrice,
    required this.mrp,
    required this.discount,
    required this.taxType,
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
      'product_id': productId,
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
      'description': description
    };
  }
}

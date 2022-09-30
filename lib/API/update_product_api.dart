import 'dart:convert';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:flutter/material.dart';
import 'package:mycityfoodvendor/model/product_update_model.dart';
import 'package:http/http.dart';

class UpdateProductAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  ProductDetailsUpdateResponse? _updateProductResponse;

  Future<void> updateProductInfo(
      {required UpdateProductRequestModel updateProductRequestModel}) async {
    Uri updateProductUrl = Uri.parse("${API.baseUrl}/update_product");
    final response =
        await post(updateProductUrl, body: updateProductRequestModel.toMap());
    if (response.statusCode == 200) {
      try {
        print("Response Status Code" + response.statusCode.toString());
        print("response Body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response----- " + jsonResponse.toString());
        _updateProductResponse =
            ProductDetailsUpdateResponse.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = "$e";
        print("The error message " + _errorMessage);
        _updateProductResponse = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong response code ${response.statusCode}";
      _updateProductResponse = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ProductDetailsUpdateResponse? get updateProductResponse =>
      _updateProductResponse;
}

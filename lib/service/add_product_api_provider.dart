import 'dart:convert';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycityfoodvendor/model/product_model.dart';
import 'package:http/http.dart';

class AddProductAPiProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  AddProductResponseModel? _addProductResponseModel;

  Future<void> addProduct(
      {required AddProductRequestModel addProductRequestModel}) async {
    Uri url = Uri.parse("${API.baseUrl}/add_product");

    Response response = await post(url, body: addProductRequestModel.toMap());

    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _addProductResponseModel =
            AddProductResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
      }
    } else {
      _error = true;
      _errorMessage = "Error with status code : ${response.statusCode}";
    }
    notifyListeners();
  }

  AddProductResponseModel? get profileDetails => _addProductResponseModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;
}

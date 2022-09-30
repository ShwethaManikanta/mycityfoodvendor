import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/model/recently_added_products_model.dart';
import 'package:http/http.dart';

class RecentAddedProductsAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  RecentlyAddedProdutsModel? _recentlyAddedProdutsModel;

  Future<void> fetchProduct() async {
    Uri url = Uri.parse("${API.baseUrl}/recently_product");
    print("The API user id  --- - -- - - - " + API.userData!);
    Response response = await post(url, body: {'vendor_id': API.userData});
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _recentlyAddedProdutsModel =
            RecentlyAddedProdutsModel.fromJson(jsonResponse);
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

  RecentlyAddedProdutsModel? get productDetails => _recentlyAddedProdutsModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _recentlyAddedProdutsModel = null;
  }
}

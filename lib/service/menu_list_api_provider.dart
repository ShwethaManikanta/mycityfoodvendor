import 'dart:convert';

import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/model/menu_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MenuListAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  MenuListResponseModel? _menuListResponseModel;

  Future<void> fetchData() async {
    Uri url = Uri.parse("${API.baseUrl}/get_menu_list");

    Response response = await post(url, body: {
      'outlet_id': API.userData,
    });
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _menuListResponseModel = MenuListResponseModel.fromJson(jsonResponse);
        print(_menuListResponseModel!.message!);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _menuListResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error with status code : ${response.statusCode}";
      _menuListResponseModel = null;
    }
    notifyListeners();
  }

  MenuListResponseModel? get menuListResponseModel => _menuListResponseModel;

  bool get ifLoading => _menuListResponseModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _menuListResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}

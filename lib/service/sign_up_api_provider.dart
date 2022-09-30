import 'dart:convert';
import 'package:mycityfoodvendor/model/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../API/api.dart';

class SignUpApiProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  LoginModel? _loginModel;

  Future<void> signUp({required Map<String, dynamic> requestMap}) async {
    Uri updateProductUrl = Uri.parse("${API.baseUrl}/reg");
    final response = await post(updateProductUrl, body: requestMap);
    if (response.statusCode == 200) {
      try {
        print("Response Status Code" + response.statusCode.toString());
        print("response Body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response----- " + jsonResponse.toString());
        _loginModel = LoginModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = "$e";
        print("The error message " + _errorMessage);
        _loginModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong response code ${response.statusCode}";
      _loginModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  LoginModel? get signUpResponse => _loginModel;

  initialize() {
    _loginModel = null;
    _error = false;
    _errorMessage = "";
  }
}

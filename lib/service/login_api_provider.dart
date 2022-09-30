import 'dart:convert';
import 'package:mycityfoodvendor/model/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../API/api.dart';

class LoginAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  LoginResponseModel? _loginResponseModel;

  Future<void> login(
      {required String email,
      required String password,
      required String deviceToken}) async {
    Uri url = Uri.parse("${API.baseUrl}/login");

    Response response = await post(url, body: {
      'email': email,
      'password': password,
      'device_token': deviceToken
    });
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _loginResponseModel = LoginResponseModel.fromJson(jsonResponse);
        print(_loginResponseModel!.message!);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _loginResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error with status code : ${response.statusCode}";
      _loginResponseModel = null;
    }
    notifyListeners();
  }

  LoginResponseModel? get loginResponse => _loginResponseModel;

  bool get ifLoading => _loginResponseModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _loginResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}

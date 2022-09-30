import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../API/api.dart';

class ValidateEmailPhone {
  String? status;
  String? message;

  ValidateEmailPhone({this.status, this.message});

  ValidateEmailPhone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class ValidateEmailPhoneNumberProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  ValidateEmailPhone? _validateEmailPhone;

  initialize() {
    _validateEmailPhone = null;
    _error = false;
    _errorMessage = "";
  }

  Future<void> validateEmailAndPhone(
      {required String email, required String phoneNumber}) async {
    Uri updateProductUrl = Uri.parse("${API.baseUrl}/check_user_login");
    print("valadating email" + email + '---- valadating phone' + phoneNumber);
    final response = await post(updateProductUrl,
        body: {'email': email, 'mobile': phoneNumber});
    if (response.statusCode == 200) {
      try {
        print("Response Status Code" + response.statusCode.toString());
        print("response Body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response----- " + jsonResponse.toString());
        _validateEmailPhone = ValidateEmailPhone.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = "$e";
        print("The error message " + _errorMessage);
        _validateEmailPhone = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong response code ${response.statusCode}";
      _validateEmailPhone = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ValidateEmailPhone? get response => _validateEmailPhone;
}

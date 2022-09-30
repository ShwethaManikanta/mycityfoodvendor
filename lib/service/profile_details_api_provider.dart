import 'dart:convert';

import 'package:mycityfoodvendor/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../API/api.dart';

class ProfileModelAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  ProfileModel? _profileModel;

  Future<void> getProfileDetails() async {
    Uri url = Uri.parse("${API.baseUrl}/profile");
    print("asdfasdf ---- - --asdf " + API.userData);
    Response response = await post(url, body: {"user_id": API.userData});
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _profileModel = ProfileModel.fromJson(jsonResponse);
        print("Description -   -- - - - - - - -" +
            _profileModel!.userDetails!.description!);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _profileModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error with status code : ${response.statusCode}";
      _profileModel = null;
    }
    notifyListeners();
  }

  ProfileModel? get profileModel => _profileModel;

  bool get ifLoading => _profileModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _profileModel = null;
  }
}

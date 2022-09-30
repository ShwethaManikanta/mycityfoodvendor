import 'dart:convert';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/model/limit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class LimitListAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  LimitListResponseModel? _limitListResponseModel;

  Future<void> getList() async {
    Uri url = Uri.parse("${API.baseUrl}/limits_list");

    Response response = await get(url);
    print("limit list api provider ---- - - - -" + response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _limitListResponseModel = LimitListResponseModel.fromJson(jsonResponse);
        print(_limitListResponseModel!.message!);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _limitListResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error with status code : ${response.statusCode}";
      _limitListResponseModel = null;
    }
    notifyListeners();
  }

  LimitListResponseModel? get limitListResponseModel => _limitListResponseModel;

  bool get ifLoading => _limitListResponseModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;
}

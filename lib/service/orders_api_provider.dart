import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../API/api.dart';
import '../model/orderhistory.dart';

class OrderHistoryAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  OngoingOrderResponseModel? _ongoingOrderResponseModel;

  Future<void> getOrders() async {
    Uri url = Uri.parse("${API.baseUrl}/order_history");

    Response response = await post(url, body: {"outlet_id": API.userData});
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _ongoingOrderResponseModel =
            OngoingOrderResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _ongoingOrderResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error with status code : ${response.statusCode}";
      _ongoingOrderResponseModel = null;
    }
    notifyListeners();
  }

  OngoingOrderResponseModel? get orderHistoryResponse =>
      _ongoingOrderResponseModel;

  bool get ifLoading => _ongoingOrderResponseModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _ongoingOrderResponseModel = null;
  }
}

class OrderCancelledAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  OrderCancelledModel? _orderCancelledModel;

  Future<void> getOrders() async {
    Uri url = Uri.parse("${API.baseUrl}/order_cancelled_list");

    Response response = await post(url, body: {"user_id": API.userData});
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _orderCancelledModel = OrderCancelledModel.fromJson(jsonResponse);
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

  OrderCancelledModel? get orderCancelledResponse => _orderCancelledModel;

  bool get ifLoading => _orderCancelledModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _orderCancelledModel = null;
  }
}

class OrdersCompletedAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  OrderCompleteModel? _orderCompletedResponse;

  Future<void> getOrders() async {
    Uri url = Uri.parse("${API.baseUrl}/order_completed");

    Response response = await post(url, body: {"user_id": API.userData});
    print(response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _orderCompletedResponse = OrderCompleteModel.fromJson(jsonResponse);
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

  OrderCompleteModel? get orderComepletedResponse => _orderCompletedResponse;

  bool get ifLoading => _orderCompletedResponse == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _orderCompletedResponse = null;
  }
}

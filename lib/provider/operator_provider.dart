import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/operator_model.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class OperatorProvider extends ChangeNotifier {
  OperatorModel? model;

  callOperatorListApiFunction(String url) async {
    model = null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: url, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = OperatorModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
  }
}

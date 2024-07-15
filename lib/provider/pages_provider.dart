import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/faq_model.dart';
import 'package:velvot_pay/model/privacy_policy_model.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class PagesProvider extends ChangeNotifier {
  FaqModel? model;
  PrivacyPolicyModel? policyModel;

  callFaqApiFunction() async {
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.faqUrl, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = FaqModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
  }

  callPrivacyApiFunction(String url) async {
    showLoader(navigatorKey.currentContext!);
    policyModel=null;
    notifyListeners();
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: url,
        body: body,
        method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      policyModel = PrivacyPolicyModel.fromJson(response);
    } else {}
    notifyListeners();
  }
}

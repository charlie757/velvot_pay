import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class VerifyOtpProvider extends ChangeNotifier {
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int counter = 30;
  Timer? timer;
  bool resend = false;
  bool isLoading = false;
  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  startTimer() {
    //shows timer
    counter = 30; //time counter
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter > 0 ? counter-- : timer.cancel();
      notifyListeners();
    });
  }

  resetValues() {
    otpController.clear();
    resend = false;
  }

  checkValidation(String number, String type) {
    if (formKey.currentState!.validate()) {
      print('object');
      callVerifyApiFunction(number, type);
    }
  }

  callVerifyApiFunction(
    String number,
    String type,
  ) async {
    var body = json.encode({
      "mobile_number": number,
      "type": type == 'login' ? "LOGIN" : "REGISTER", // LOGIN,REGISTER
      "otp": otpController.text,
      "device_token": "123456789",
      "device_type": Platform.isAndroid ? "ANDROID" : "IOS"
    });
    updateLoading(true);
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.verifyOtpUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      SessionManager.setToken = response['data']['api_token'];
      SessionManager.setUserId = response['data']['_id'];
      AppRoutes.pushReplacementNavigation(const DashboardScreen());
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
    } else {}
  }

  resendApiFunction(String number, String type) async {
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "mobile_number": number,
      "type": type == 'login' ? "LOGIN" : "REGISTER", // LOGIN,REGISTER
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.resendOtpUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      Utils.showToast(response['data']['otp'].toString());
      startTimer();
    } else {}
  }
}

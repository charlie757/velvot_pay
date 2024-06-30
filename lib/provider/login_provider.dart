import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/screens/auth/profile_screen.dart';
import 'package:velvot_pay/screens/auth/veriy_otp_screen.dart';
import 'package:velvot_pay/utils/utils.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  bool isLoading = false;

  upateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    if (formKey.currentState!.validate()) {
      callApiFunction();
    }
  }

  callApiFunction() async {
    upateLoading(true);
    var body = json.encode({'mobile_number': phoneController.text});
    final response = await ApiService.apiMethod(
        url: ApiUrl.loginUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    upateLoading(false);
    if (response != null) {
      Utils.showToast(response['data']['otp'].toString());
      AppRoutes.pushNavigation(VerifyOtpScreen(
        route: 'login',
        number: phoneController.text,
      ));
    } else {
      AppRoutes.pushNavigation(ProfileScreen(
        route: 'login',
        number: phoneController.text,
      ));
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/screens/auth/signup/verify_phone_screen.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../utils/Constants.dart';

class LoginProvider extends ChangeNotifier {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isVisible = false;

  upateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  resetValues(){
    isLoading = false;
    phoneController.clear();
    passwordController.clear();
  }

  checkValidation(formKey) {
    if (formKey.currentState!.validate()) {
      callApiFunction();
    }
  }

  callApiFunction() async {
    Constants.is401Error=false;
    notifyListeners();
    Utils.hideTextField();
    upateLoading(true);
    var body = json.encode({'mobile_number': phoneController.text,
    'password': passwordController.text
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.loginUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    upateLoading(false);
    if (response != null) {
      if(response['data']['isUser']){
        AppRoutes.pushNavigation(VerifyPhoneScreen(
          number: phoneController.text,
          otp: response['data']['otp'].toString(),
          isShowProgressBar: false,
          route: 'login',
        ));
      }
      else{
      }
    } else {

    }
  }
}

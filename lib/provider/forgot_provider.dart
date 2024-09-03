import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/screens/auth/login_screen.dart';
import 'package:velvot_pay/screens/auth/signup/verify_phone_screen.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../screens/auth/signup/verify_email_screen.dart';

class ForgotProvider extends ChangeNotifier{
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  updateLoading(bool value){
    isLoading=value;
    notifyListeners();
  }

  callForgotApiFunction(String value, String type)async{
    updateLoading(true);
    var body = json.encode({
      'identity': value,
      'type': type
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.forgotUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      type=='MOBILE'?
      AppRoutes.pushNavigation(VerifyPhoneScreen(number: value, isShowProgressBar: false,otp: response['data']!=null?response['data']['otp'].toString():'',
      route: 'forgot',)):
      AppRoutes.pushNavigation(VerifyEmailScreen(email: value, isProgressBar: false,
        route: 'forgot',));
    } else {

    }
  }

  resetPasswordApiFunction(String password)async{
    updateLoading(true);
    var body = json.encode({
      "password": password,
      "password_confirmation": password
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.resetPasswordUrl,
        body: body,
        method: checkApiMethod(httpMethod.put));
    updateLoading(false);
    if (response != null) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      AppRoutes.pushRemoveReplacementNavigation(const LoginScreen());
    } else {
    }

  }

}
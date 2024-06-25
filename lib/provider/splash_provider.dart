import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/screens/auth/login_screen.dart';

class SplashProvider extends ChangeNotifier{

  callSplash(){
    Future.delayed(const Duration(seconds: 3),(){
      AppRoutes.pushReplacementNavigation(LoginScreen());
    });
  }
}
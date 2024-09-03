import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/screens/auth/login_screen.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';

import '../screens/onboarding/onboarding_screen.dart';

class SplashProvider extends ChangeNotifier {
  callSplash() {
    Future.delayed(const Duration(seconds: 3), () {
      if (SessionManager.token.isNotEmpty&&SessionManager.pinSetup) {
        AppRoutes.pushReplacementNavigation(const DashboardScreen());
      } else {
        if(SessionManager.isFirstTime){
          AppRoutes.pushRemoveReplacementNavigation(const LoginScreen());
        }
        else{
          AppRoutes.pushReplacementNavigation(const OnBoardingScreen());
        }
      }
    });
  }
}

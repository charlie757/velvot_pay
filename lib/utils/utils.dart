import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/screens/auth/login_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Utils {
  static const emailPattern =
      r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static hideTextField() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static successSnackBar(
    String title,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.withOpacity(.9)),
            borderRadius: BorderRadius.circular(3)),
        // margin: EdgeInsets.only(left: 20, right: 20,),
        backgroundColor: Colors.green.withOpacity(.9),
        content: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static internetSnackBar(
    context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor.withOpacity(.8)),
            borderRadius: BorderRadius.circular(3)),
        //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
        backgroundColor: AppColor.redColor.withOpacity(.8),
        content: Text(
          'No Internet',
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static errorSnackBar(
    String title,
    context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor.withOpacity(.8)),
            borderRadius: BorderRadius.circular(3)),
        //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
        backgroundColor: AppColor.redColor.withOpacity(.8),
        content: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static logOut() {
    SessionManager.sharedPrefs.clear();
    AppRoutes.pushReplacementNavigation(const LoginScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/screens/auth/login_screen.dart';

enum route {
  operator,electricity,education,tv,insuranceThirdParty,insurancePersonal,insuranceHealth
}


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Utils {
  static unFocusTextField(){
    FocusScope.of(navigatorKey.currentContext!).unfocus();
  }
  static RegExp intRegex =  RegExp(r'\d+(\.\d+)?');
  static const emailPattern =
      r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static  RegExp alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

  static hideTextField() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

 static String getSplitValue(String input, int index, {String defaultValue = ''}) {
    List<String> parts = input.split('-');

    // Check if the index is within the bounds of the list
    if (index < parts.length) {
      return parts[index];
    } else {
      return defaultValue; // Return a default value or handle as needed
    }
  }

static String getInitials(String fullName) {
  List<String> nameParts = fullName.split(' ');

  List<String> initials = nameParts.map((part) => part.isNotEmpty ? part[0] : '').toList();
  return initials.join().substring(0, initials.length < 2 ? initials.length : 2).toUpperCase();
}

  static showToast(String title) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColor.blackColor,
      textColor: Colors.white,
    );
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

  static existAppSnackBar(BuildContext context, title){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            duration:const Duration(seconds: 2),
            shape: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.blackColor),
                borderRadius: BorderRadius.circular(3)
            ),
            width: 180,
            // margin: EdgeInsets.only(bottom: 109,left: MediaQuery.of(context).size.width-100,right:  MediaQuery.of(context).size.width-50),
            backgroundColor: AppColor.blackColor,
            content:
            Align(
                alignment: Alignment.center,
                child: Text(title,style: TextStyle(color: AppColor.whiteColor),))));

  }

  static logOut() {
    SessionManager.sharedPrefs.clear();
    AppRoutes.pushReplacementNavigation(const LoginScreen());
  }
}

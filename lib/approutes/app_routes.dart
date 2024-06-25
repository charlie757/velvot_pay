
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';


class AppRoutes{

  static Future pushNavigation(route){
    return Navigator.push(navigatorKey.currentContext!, CupertinoPageRoute(builder: (context)=>route));
  }
  static Future pushReplacementNavigation(route){
    return Navigator.pushReplacement(navigatorKey.currentContext!, CupertinoPageRoute(builder: (context)=>route));
  }
}
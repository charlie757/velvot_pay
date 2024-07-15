import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/banner_model.dart';
import 'package:velvot_pay/screens/auth/profile_screen.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../approutes/app_routes.dart';
import '../helper/app_color.dart';
import '../helper/images.dart';
import '../screens/dashboard/history/history_screen.dart';
import '../screens/dashboard/home/home_screen.dart';
import '../screens/dashboard/home/operator_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 1;
  BannerModel? bannerModel;
  DateTime? currentBackPressTime;
  List screenList = [
    const HistoryScreen(),
    const HomeScreen(),
    const ProfileScreen(
      route: 'dashboard',
    )
  ];

  List serviceList = [
    {
      'img':Images.dataSubscriptionIcon,
      'color':AppColor.dataSubsriptionColor,
      'title':'Data Subscription'
    },
    {
      'img':Images.topUpIcon,
      'color':AppColor.topUpColor,
      'title':'Mobile Top up'
    },
    {
      'img':Images.educationIcon,
      'color':AppColor.educationColor,
      'title':'Educational Payment'
    },
    {
      'img':Images.electricityIcon,
      'color':AppColor.electricityColor,
      'title':'Electricity Payment'
    },
    {
      'img':Images.tvSubscriptionIcon,
      'color':AppColor.tvSubcriptionColor,
      'title':'TV Subscription'
    },
    {
      'img':Images.insuranceIcon,
      'color':AppColor.insuranceColor,
      'title':'Insurance Payment'
    },
  ];

  resetValues() {
    currentIndex = 1;
    bannerModel = null;
  }

  updateIndex(val) {
    currentIndex = val;
    notifyListeners();
  }


  serviceNavigateRoutes(int index){
    switch (index){
      case 0:
        AppRoutes.pushNavigation(const OperatorScreen(
          title: 'Select Operator',
          route: 'operator',
        ));
        break;
      case 1:
        AppRoutes.pushNavigation(const OperatorScreen(
          title: 'Mobile Top up',
          route: 'topup',
        ));
        break;
      case 2:
    AppRoutes.pushNavigation(const OperatorScreen(
      title: 'Choose Educational Bill Operator',
      route: 'education',
    ));
    break;
      case 3:
    AppRoutes.pushNavigation(const OperatorScreen(
      title: 'Choose Electricity Bill Operator',
      route: 'electricity',
    ));
    break;
      case 4:
    AppRoutes.pushNavigation(const OperatorScreen(
      title: 'Choose TV Subcription Operator',
      route: 'tv',
    ));
    break;
      case 5:
    AppRoutes.pushNavigation(const OperatorScreen(
      title: 'Choose Insurance Bill Operator',
      route: 'insurance',
    ));
    break;
    }
  }


  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentIndex!=1) {
      updateIndex(1);
      return Future.value(false);
      // showTimerController.pauseAudioOnBack();
    }
    else {
      if(currentIndex==0||currentIndex==2){
        currentIndex=1;
        return Future.value(false);
      }
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Utils.existAppSnackBar(navigatorKey.currentContext!, 'Press again to exit app');
        return Future.value(false);
      }
      exit(0);
    }
    return true;
  }

  getBannerApiFunction() async {
    bannerModel == null ? showLoader(navigatorKey.currentContext!) : null;
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.bannerUrl,
        body: body,
        method: checkApiMethod(httpMethod.get));
    bannerModel == null ? Navigator.pop(navigatorKey.currentContext!) : null;
    if (response != null) {
      bannerModel = BannerModel.fromJson(response);
      notifyListeners();
    } else {
      bannerModel = null;
    }
  }
}

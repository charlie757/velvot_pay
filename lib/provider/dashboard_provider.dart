import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/banner_model.dart';
import 'package:velvot_pay/screens/auth/profile_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/education/education_payment_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/electricity/buy_electricity_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/insurance/insurance_operator_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/subscription/buy_subscription_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/tvSubscription/tv_subscription_screen.dart';
import 'package:velvot_pay/screens/dashboard/transaction/transaction_screen.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../approutes/app_routes.dart';
import '../model/dashboard_model.dart';
import '../screens/dashboard/home/home_screen.dart';
import '../screens/dashboard/home/operator_screen.dart';
import '../screens/dashboard/myprofile/new_profile_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 0;
  BannerModel? bannerModel;
  DateTime? currentBackPressTime;
   DashboardModel? dashboardModel;
  List screenList = [
    const HomeScreen(),
     TransactionScreen(),
    NewProfileScreen()
    // const ProfileScreen(
    //   route: 'dashboard',
    // )
  ];


  resetValues() {
    currentIndex = 0;
    dashboardModel = null;
    bannerModel = null;
  }

  updateIndex(val) {
    currentIndex = val;
    notifyListeners();
  }


  serviceNavigateRoutes(int index){
    switch (index){
      case 0:
        AppRoutes.pushNavigation(const BuyElectricityScreen());
        // AppRoutes.pushNavigation(const OperatorScreen(
        //   title: 'Choose Electricity Bill Operator',
        //   route: 'electricity',
        // ));

        break;
      case 1:
        AppRoutes.pushNavigation(const BuySubscriptionScreen());
        // AppRoutes.pushNavigation(const OperatorScreen(
        //   title: 'Select Operator',
        //   route: 'operator',
        // ));
        // AppRoutes.pushNavigation(const OperatorScreen(
        //   title: 'Mobile Top up',
        //   route: 'topup',
        // ));
        break;
      case 2:
        AppRoutes.pushNavigation(const InsuranceOperatorScreen());
        // AppRoutes.pushNavigation(const OperatorScreen(
        //   title: 'Choose Insurance Bill Operator',
        //   route: 'insurance',
        // ));

    break;
      case 3:
        AppRoutes.pushNavigation(const TvSubscriptionScreen());
    break;
      case 4:
        AppRoutes.pushNavigation(const EducationPaymentScreen());
    break;
      case 5:

    break;
    }
  }


  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentIndex!=0) {
      updateIndex(0);
      return Future.value(false);
      // showTimerController.pauseAudioOnBack();
    }
    else {
      if(currentIndex==1||currentIndex==2){
        currentIndex=0;
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

  dashboardApiFunction()async{
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.dashboardUrl,
        body: body,
        method: checkApiMethod(httpMethod.get));
    if(response!=null){
      dashboardModel = DashboardModel.fromJson(response);
      notifyListeners();
    }
  }
}

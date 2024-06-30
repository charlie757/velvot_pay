import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/banner_model.dart';
import 'package:velvot_pay/screens/auth/profile_screen.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../screens/dashboard/history/history_screen.dart';
import '../screens/dashboard/home/home_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 1;
  BannerModel? bannerModel;
  List screenList = [
    const HistoryScreen(),
    const HomeScreen(),
    const ProfileScreen(
      route: 'dashboard',
    )
  ];

  resetValues() {
    currentIndex = 1;
    bannerModel = null;
  }

  updateIndex(val) {
    currentIndex = val;
    notifyListeners();
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

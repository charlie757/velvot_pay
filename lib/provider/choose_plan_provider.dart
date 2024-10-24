import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/model/insurance_plan_model.dart';
import 'package:velvot_pay/model/tv_subscription_plan_model.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../model/data_subscription_plan_model.dart';
import '../model/educational_plan_model.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class ChoosePlanProvider extends ChangeNotifier{
  DataSubscriptionPlanModel? model;
  TvSubscriptionPlanModel? tvSubscriptionPlanModel;
  EducationPlanModel? educationPlanModel;
  InsurancePlanModel? insurancePlanModel;
  getDataSubscriptionPlanApiFunction(String  plan)async{
    model =null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.dataSubscriptionPlanListUrl}$plan", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = DataSubscriptionPlanModel.fromJson(response);
    } else {
    }
    notifyListeners();
  }

getTVSubscriptionPlanApiFunction(String plan)async{
    tvSubscriptionPlanModel=null;
  notifyListeners();
  showLoader(navigatorKey.currentContext!);
  var body = json.encode({});
  final response = await ApiService.apiMethod(
      url: "${ApiUrl.getTvOperatorPlanUrl}$plan", body: body, method: checkApiMethod(httpMethod.get));
  Navigator.pop(navigatorKey.currentContext!);
  if (response != null) {
    tvSubscriptionPlanModel = TvSubscriptionPlanModel.fromJson(response);
  } else {
  }
  notifyListeners();

}



  getEducationPlanApiFunction(String plan)async{
    educationPlanModel=null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.getEducationalPlanUrl}$plan", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      educationPlanModel = EducationPlanModel.fromJson(response);
    } else {
    }
    notifyListeners();

  }

  getInsurancePlanApiFunction(String plan)async{
    insurancePlanModel=null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.getInsurancePlanUrl}$plan", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      insurancePlanModel = InsurancePlanModel.fromJson(response);
    } else {
    }
    notifyListeners();

  }

}
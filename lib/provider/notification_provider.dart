import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/model/notification_model.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class NotificationProvider extends ChangeNotifier{

  NotificationModel? model;
  bool isLoading =false;

  updateLoading(bool value){
    isLoading=value;
    notifyListeners();
  }

  callNotificationApiFunction()async{
    model = null;
    notifyListeners();
    updateLoading(true);
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.notificationUrl,
        body: body,
        method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    updateLoading(false);
    if(response!=null){
      model = NotificationModel.fromJson(response);
      notifyListeners();
    }
  }
}
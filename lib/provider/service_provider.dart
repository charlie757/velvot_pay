import 'dart:convert';

import 'package:flutter/material.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../model/saved_buy_subscription_transaction_model.dart';

class ServiceProvider extends ChangeNotifier{
  SavedTransactionModel? savedTransactionModel;


  savedTransactionApiFunction(String type)async{
    savedTransactionModel=null;
    notifyListeners();
    var body = json.encode({
      'type':type
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.savedTransactionUrl, body: body, method: checkApiMethod(httpMethod.put));
    if (response != null) {
      savedTransactionModel = SavedTransactionModel.fromJson(response);
    } else {
    }
    notifyListeners();
  }

}
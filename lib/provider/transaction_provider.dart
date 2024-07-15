import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/transaction_details_model.dart';
import 'package:velvot_pay/model/transaction_model.dart';

import '../apiconfig/api_service.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class TransactionProvider extends ChangeNotifier{
  TransactionModel? model;
  TransactionDetailsModel? transactionDetailsModel;
  List transactionList = [];
  bool isLoading = false;
  bool scrollLoading = false;
  int page = 1;
  callTransactionApiFunction()async{
    page=1;
    notifyListeners();
    isLoading=true;
    transactionList.clear();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.transcationUrl}?page=$page", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    isLoading=false;
    if (response != null) {
      model = TransactionModel.fromJson(response);
      transactionList = model!.data!.data!;
    } else {
      transactionList.clear();
    }
    notifyListeners();
  }

  callTransactionPaginationApiFunction()async{
    if(transactionList.length<model!.data!.pagination!.total) {
      page += 1;
      scrollLoading=true;
      notifyListeners();
      var body = json.encode({});
      final response = await ApiService.apiMethod(
          url: "${ApiUrl.transcationUrl}?page=$page",
          body: body,
          method: checkApiMethod(httpMethod.get));
      scrollLoading=false;
      if (response != null) {
        model = TransactionModel.fromJson(response);
        transactionList = transactionList + model!.data!.data!;
      } else {}
      notifyListeners();
    }
  }

  getTransactionDetailsApiFunction(String id)async{
    notifyListeners();
    transactionDetailsModel=null;
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.transactionDetailsUrl}$id", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      transactionDetailsModel = TransactionDetailsModel.fromJson(response);
      // model = TransactionModel.fromJson(response);
    } else {
      // model = null;
    }
    notifyListeners();
  }
}
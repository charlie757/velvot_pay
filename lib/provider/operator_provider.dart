import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/model/operator_model.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class OperatorProvider extends ChangeNotifier {
  OperatorModel? model;
  bool noDataFound = false;
  List searchList = [];

  callOperatorListApiFunction(String url) async {
    model = null;
    searchList.clear();
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: url, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = OperatorModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
  }

  searchFunction(String val,)async{
    if (!model!.data
        .toString()
        .toLowerCase()
        .contains(val.toLowerCase())) {
      searchList.clear();
      noDataFound=true;
    }
    model!.data!.forEach((element) {
      if (val.isEmpty) {
        searchList.clear();
        noDataFound=false;
        notifyListeners();
      } else if (element.title
          .toLowerCase()
          .contains(val.toString().toLowerCase())) {
        noDataFound=false;
        print("element...${element.title}");
        searchList.add(element);
      } });
    notifyListeners();
    // setState(() {});
  }


}

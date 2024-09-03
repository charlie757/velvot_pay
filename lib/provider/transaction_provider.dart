import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/model/transaction_details_model.dart';
import 'package:velvot_pay/model/transaction_model.dart';
import 'package:velvot_pay/provider/profile_provider.dart';

import '../apiconfig/api_service.dart';
import '../helper/app_color.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class TransactionProvider extends ChangeNotifier{
  TransactionModel? model;
  TransactionDetailsModel? transactionDetailsModel;
  List transactionList = [];
  bool isLoading = false;
 int currentFilterIndex = -1;
 final startDateController = TextEditingController();
 final endDateController = TextEditingController();
 final emailController  = TextEditingController();
 final addressController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime initialStartDate = DateTime(DateTime.now().year, DateTime.now().month-1, DateTime.now().day);
  DateTime initialEndDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  resetValues(){
    startDateController.clear();
    endDateController.clear();
    initialStartDate = DateTime(DateTime.now().year , DateTime.now().month-1, DateTime.now().day);
     initialEndDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  updateCurrentFilterIndex(int index){
   currentFilterIndex=index;
   notifyListeners();
 }

 getProfileData(){
    final profileProvider = Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false);
    emailController.text =profileProvider.model!=null&&profileProvider.model!.data!=null? profileProvider.model!.data!.email??"":"";
    addressController.text =profileProvider.model!=null&&profileProvider.model!.data!=null? profileProvider.model!.data!.address??'':"";
 }


  callTransactionApiFunction(bool isLoading, String params)async{
    notifyListeners();
    isLoading=isLoading;
    isLoading? showLoader(navigatorKey.currentContext!):null;
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: params.isNotEmpty?"${ApiUrl.transactionUrl}?$params": ApiUrl.transactionUrl, body: body, method: checkApiMethod(httpMethod.get));
    isLoading? Navigator.pop(navigatorKey.currentContext!):null;
    isLoading=false;
    if (response != null) {
      model = TransactionModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
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

  Future downloadStatementApiFunction()async{
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.transactionDownloadUrl}?created_at_to=${startDateController.text}&created_at_from=${endDateController.text}", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if(response!=null){
    }
    return response;
  }

  Future datePicker(String hintText, DateTime date) async {
    DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData(colorSchemeSeed: AppColor.appColor),
            child: child!,
          );
        },
        helpText: hintText,
        context: navigatorKey.currentContext!,
        initialDate: date,
        firstDate: DateTime(2000, 1),
        lastDate: date
    );
    if (picked != null && picked != DateTime.now()) {
      selectedDate = picked;
      return selectedDate;
    }
  }

}
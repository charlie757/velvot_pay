import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../helper/app_color.dart';
import '../helper/custom_btn.dart';
import '../helper/getText.dart';
import '../helper/images.dart';
import '../helper/screen_size.dart';
import '../model/data_subscription_plan_model.dart';
import '../model/operator_model.dart';
import '../model/saved_buy_subscription_transaction_model.dart';
import '../utils/Constants.dart';
import '../utils/error_dialog_box.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';
import '../widget/row_column_confirmation_widget.dart';

class BuySubscriptionProvider extends ChangeNotifier{
  bool isCheckBox = false;
  int currentTabBarIndex =0;
  List<Contact> contactList= [];
  List searchList = [];
  bool isSearchEnable = false;
  String unknownNumber = '';
  bool noDataFound = false;
  DataSubscriptionPlanModel? dataModel;
  OperatorModel? model;
  int currentOperatorIndex =0;
  int currentSelectedData = -1;
  final numberController = TextEditingController();
  List savedDataList = [];
  List<Map<String, dynamic>> dailyPlans = [];
  List<Map<String, dynamic>> weeklyPlans = [];
  List<Map<String, dynamic>> biWeeklyPlans = [];
  List<Map<String, dynamic>> monthlyPlans = [];


  resetValues(){
    dataModel=null;
    savedDataList.clear();
    dailyPlans.clear();
    weeklyPlans.clear();
    biWeeklyPlans.clear();
    monthlyPlans.clear();
  currentOperatorIndex = 0;
  numberController.clear();
  isCheckBox =false;
  currentSelectedData=-1;
  currentTabBarIndex=0;
  dataModel=null;
}

  updateTabBarIndex(index){
    currentTabBarIndex = index;
    notifyListeners();
  }

  callOperatorListApiFunction() async {
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.dataSubscriptionOperatorListUrl, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = OperatorModel.fromJson(response);
      getDataSubscriptionPlanApiFunction(model!.data![0].serviceID);
    } else {
      model = null;
    }
    notifyListeners();
  }



  Future<List<Contact>> getContactList({
    bool withProperties = true,
    bool withPhoto = true,
  }) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: withProperties,
          withPhoto: withPhoto,
        );
        return contacts;
      } else {
        print('Permission denied to access contacts.');
        return [];
      }
    } catch (e) {
      print('Failed to fetch contacts: $e');
      return [];
    }
  }

  Future<void> fetchContacts() async {
    contactList.isNotEmpty?null: showLoader(navigatorKey.currentContext!);
    List<Contact> contacts = await getContactList();
    contactList.isNotEmpty?null: Navigator.pop(navigatorKey.currentContext!);
    // allContactList = contacts;
    contactList = contacts;
    notifyListeners();
  }


  searchFunction(String val,)async{
    if (!contactList
        .toString()
        .toLowerCase()
        .contains(val.toLowerCase())) {
      searchList.clear();
      print('nofsfj');
      noDataFound=true;
    }
    contactList.forEach((element) {
      String lowerCaseVal = val.toLowerCase();
      String lowerCaseName = element.displayName.isNotEmpty? element.displayName.toLowerCase():"";
      String lowerCasePhone = element.phones.isNotEmpty? element.phones.first.number.toLowerCase():"";
      if (val.isEmpty) {
        unknownNumber ='';
        searchList.clear();
        noDataFound=false;
        notifyListeners();
      } else if (lowerCaseName.contains(lowerCaseVal) || lowerCasePhone.contains(lowerCaseVal)) {
        // searchList.clear();
        noDataFound=false;
        unknownNumber ='';
        print("element...${element.phones.first.number}");
        searchList.add(element);
      }
      else if(val.isNotEmpty&&!lowerCasePhone.contains(lowerCaseVal)){
        unknownNumber =val;
      }
    });

    notifyListeners();
    // setState(() {});
  }


  getDataSubscriptionPlanApiFunction(String  plan)async{
    dataModel =null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: "${ApiUrl.dataSubscriptionPlanListUrl}$plan", body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      dataModel = DataSubscriptionPlanModel.fromJson(response);
      if(dataModel!=null&&dataModel!.data!=null&&dataModel!.data!.varations!=null) {
        dataModel!.data!.varations!.forEach((element) {
          if (element.time != null) {
            String time = element.time.toString().toLowerCase();
            if (time.contains('24 hrs') || time.contains('24hrs') ||
                time.contains('1day')) {
                dailyPlans.add({
                  'variation_code': element.variationCode,
                      'name': element.name,
                      'price': element.price,
                      'data': element.dataT,
                      'time': element.time,
                      'variation_amount': element.variationAmount,
                      'fixedPrice': element.fixedPrice}
                  );
            }
            else if (time.contains('2days') || time.contains('3days') ||
                time.contains('4days') || time.contains('5days') ||
                time.contains('6days') || time.contains('7days')) {
              weeklyPlans.add(
                  {'variation_code': element.variationCode,
                    'name': element.name,
                    'price': element.price,
                    'data': element.dataT,
                    'time': element.time,
                    'variation_amount': element.variationAmount,
                    'fixedPrice': element.fixedPrice}
                );
            }
            else if (time.contains('14 days')||time.contains('14days')) {
              biWeeklyPlans.add(
                  {'variation_code': element.variationCode,
                    'name': element.name,
                    'price': element.price,
                    'data': element.dataT,
                    'time': element.time,
                    'variation_amount': element.variationAmount,
                    'fixedPrice': element.fixedPrice}
                );
            }
            else if (time.contains('30 days')||time.contains('30days')) {
              monthlyPlans.add(
                  {'variation_code': element.variationCode,
                    'name': element.name,
                    'price': element.price,
                    'data': element.dataT,
                    'time': element.time,
                    'variation_amount': element.variationAmount,
                    'fixedPrice': element.fixedPrice}
                );
            }
          }
        });
      }
    } else {
    }
    notifyListeners();
  }


  checkPinApiFunction(String pin)async{
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      'pin':pin
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.checkPinUrl, body: body, method: checkApiMethod(httpMethod.put));
    Navigator.pop(navigatorKey.currentContext!);
    if(response!=null){
      if(response['status']==200){
        buyPlanApiFunction();
      }
      else{
        errorAlertDialog(response['message']);
      }

    }else{
    }
  }




  buyPlanApiFunction()async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
        "serviceID": dataModel!.data!.serviceID,
        "billersCode": '08011111111',
        "variation_code": savedDataList[0]['variation_code'].toString(),
        "amount": savedDataList[0]['price'].toString(),
        "phone": '08011111111',
        "plan_name":savedDataList[0]['name'],
        "operator": {
          "serviceID":model!.data![currentOperatorIndex].serviceID,
          "title": model!.data![currentOperatorIndex].title,
          "image": model!.data![currentOperatorIndex].image
      }
    });
   print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.buyDataSubscriptionPlanUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      if(response['status']==200){
        successBottomSheet();
      }
      else{
        errorAlertDialog(response['message']);
      }
    } else {
    }
    notifyListeners();
  }



  successBottomSheet(){
    showModalBottomSheet(
      isDismissible: false,
        isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.whiteColor
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8)
            )
        ),
        context: navigatorKey.currentContext!,
        builder: (context){
          return WillPopScope(
            onWillPop: ()async{
              return false;
            },
            child: Container(
              // color: AppColor.whiteColor,
              padding:const EdgeInsets.only(top: 30,left: 16,right: 16,bottom: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Images.successIcon),
                  ScreenSize.height(16),
                  getText(title: 'Purchase Successful', size: 20,
                      fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                      fontWeight: FontWeight.w700),
                  ScreenSize.height(4),
                  getText(title: 'Here is your receipt',
                      size: 14, fontFamily: Constants.galanoGrotesqueRegular,
                      color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                  ScreenSize.height(24),
                  rowColumnForConfirmationWidget('IUC No', numberController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Bundle', savedDataList[0]['name']),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Amount', '₦${savedDataList[0]['price']}'),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Additional Fee', '₦${dataModel!.data!.convinienceFee??''}'),
                  ScreenSize.height(24),
                  Container(
                    height: 1,
                    color: const Color(0xff7F808C33).withOpacity(.2),
                  ),
                  ScreenSize.height(24),
                  rowColumnForConfirmationWidget('Total Payment', '₦${savedDataList[0]['price']}'),
                  ScreenSize.height(24),
                  CustomBtn(title: "Done", onTap: (){
                    AppRoutes.pushRemoveReplacementNavigation(const DashboardScreen());
                  }),
                ],
              ),
            ),
          );
        });

  }

}
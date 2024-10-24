import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../approutes/app_routes.dart';
import '../helper/app_color.dart';
import '../helper/custom_btn.dart';
import '../helper/getText.dart';
import '../helper/images.dart';
import '../helper/screen_size.dart';
import '../model/electricity_plan_model.dart';
import '../model/operator_model.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../utils/Constants.dart';
import '../utils/error_dialog_box.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';
import '../widget/row_column_confirmation_widget.dart';

class ElectricityProvider extends ChangeNotifier{
  OperatorModel? model;
  ElectricityPlanModel?electricityPlanModel;
  int currentOperatorIndex =-1;
  int selectedBillTypeIndex = -1;
  final providerController = TextEditingController();
  final meterTypeController = TextEditingController();
  final meterNumberController =TextEditingController();
  final amountController = TextEditingController();
  final numberController = TextEditingController();

  resetValues(){
    numberController.clear();
    providerController.clear();
    meterNumberController.clear();
    meterTypeController.clear();
    amountController.clear();
    currentOperatorIndex=-1;
    selectedBillTypeIndex=-1;
  }


  updateBillTypeIndex(int value){
    selectedBillTypeIndex=value;
    notifyListeners();
  }

  callOperatorListApiFunction() async {
    model=null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.electricityOperatorListUrl, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = OperatorModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
  }



  electricityBillDetailsApiFunction()async{
    electricityPlanModel = null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "serviceID": model!.data![currentOperatorIndex].serviceID,
      "billersCode":meterNumberController.text,
      "type":meterTypeController.text
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.getElectricityPlanUrl, body: body, method: checkApiMethod(httpMethod.post));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      electricityPlanModel = ElectricityPlanModel.fromJson(response);
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
      "serviceID": model!.data![currentOperatorIndex].serviceID,
      "billersCode": meterNumberController.text,
      "variation_code": meterTypeController.text.toLowerCase(),
      "amount": amountController.text,
      "phone": "234${numberController.text}",
      "operator": {
        "serviceID": model!.data![currentOperatorIndex].serviceID,
        "title": model!.data![currentOperatorIndex].title,
        "image": model!.data![currentOperatorIndex].image,
        'type':meterTypeController.text,
    }
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.electricityBillPaymentUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
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
                  rowColumnForConfirmationWidget('Name', electricityPlanModel!.data!.customerName??""),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Phone Number', numberController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Meter No', meterNumberController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Meter Type', meterTypeController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Transfer Amount', '₦${amountController.text}'),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Additional Fee', '₦0'),
                  ScreenSize.height(24),
                  Container(
                    height: 1,
                    color:  Color(0xff7F808C33).withOpacity(.2),
                  ),
                  ScreenSize.height(24),
                  rowColumnForConfirmationWidget('Total Payment', '₦${amountController.text}'),
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
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
import '../model/educational_plan_model.dart';
import '../model/operator_model.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../utils/Constants.dart';
import '../utils/error_dialog_box.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';
import '../widget/row_column_confirmation_widget.dart';

class EducationProvider extends ChangeNotifier{
  OperatorModel? model;
  EducationPlanModel? educationPlanModel;
  int currentOperatorIndex =-1;
  int selectedServiceType = -1;
   final providerController = TextEditingController();
  final serviceTypeController = TextEditingController();
  final amountController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final networkOperatorController = TextEditingController();

  resetValues(){
    currentOperatorIndex = -1;
    selectedServiceType = -1;
    providerController.clear();
    serviceTypeController.clear();
    amountController.clear();
    phoneNumberController.clear();
    networkOperatorController.clear();
  }


  callOperatorListApiFunction() async {
    model=null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.educationalOperatorListUrl, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = OperatorModel.fromJson(response);
    } else {
      model = null;
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


  buyPlanApiFunction()async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "serviceID": model!.data![currentOperatorIndex].serviceID,
      "billersCode": "234${phoneNumberController.text}",
      // "0123456789",
      "variation_code": educationPlanModel!.data!.varations![selectedServiceType].variationCode,
      "amount": amountController.text,
      "phone": "234${phoneNumberController.text}",
      // "08011111111",
      "plan_name":educationPlanModel!.data!.varations![selectedServiceType].name,
      "operator": {
        "serviceID": model!.data![currentOperatorIndex].serviceID,
        "title": model!.data![currentOperatorIndex].title,
        "image": model!.data![currentOperatorIndex].image
      }
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.buyEducationalPlanUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
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
                  rowColumnForConfirmationWidget('Service Type', serviceTypeController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Phone Number', phoneNumberController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Amount', amountController.text),
                  ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Additional Fee', '₦0'),
                  ScreenSize.height(24),
                  Container(
                    height: 1,
                    color: const Color(0xff7F808C33).withOpacity(.2),
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
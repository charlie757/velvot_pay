import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../approutes/app_routes.dart';
import '../helper/app_color.dart';
import '../helper/custom_btn.dart';
import '../helper/getText.dart';
import '../helper/images.dart';
import '../helper/screen_size.dart';
import '../model/hospital_model.dart';
import '../model/operator_model.dart';
import '../model/saved_buy_subscription_transaction_model.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../utils/Constants.dart';
import '../utils/error_dialog_box.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';
import '../widget/row_column_confirmation_widget.dart';

class InsuranceProvider extends ChangeNotifier{
  OperatorModel? model;
  HospitalModel? hospitalModel;
  int selectedHospitalIndex = -1;
  bool noDataFound = false;
  File? file;
  int currentOperatorIndex =-1;
  String selectedHospitalValue = '';
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();
  final controller7 = TextEditingController();
  final controller8 = TextEditingController();
  final controller9 = TextEditingController();
  final amountController = TextEditingController();
  clearControllers(){
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    controller7.clear();
    controller8.clear();
    controller9.clear();
    amountController.clear();
    selectedHospitalIndex=-1;
    selectedHospitalValue='';
    noDataFound=false;
    file = null;
  }

  changeHospital(String value, String label, int index){
    selectedHospitalValue=value;
    controller4.text = label;
    selectedHospitalIndex=index;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  Future datePicker() async {
    DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData(colorSchemeSeed: AppColor.appColor),
            child: child!,
          );
        },
        helpText: "Select date of birth",
        context: navigatorKey.currentContext!,
        initialDate: DateTime(now.year - 18, now.month, now.day),
        firstDate: DateTime(1800, 1),
        lastDate: DateTime(now.year - 18, now.month, now.day));
    if (picked != null && picked != DateTime.now()) {
      selectedDate = picked;
      return selectedDate;
    }
  }

  resetValues(){
  currentOperatorIndex=-1;
}


  void imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
        source: source,
        imageQuality: 25
    );
    if (img == null) return;
    file = File(img.path);
    notifyListeners();
  }



  callOperatorListApiFunction() async {
    model=null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.insuranceOperatorListUrl, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = OperatorModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
  }



  getHospitalApiFunction()async{
    showLoader(navigatorKey.currentContext!);
    hospitalModel=null;
    notifyListeners();
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.getHospitalUrl, body: body, method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      hospitalModel = HospitalModel.fromJson(response);
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
        currentOperatorIndex==0?
            buyThirdPartyPlanApiFunction():
            currentOperatorIndex==1?
                buyHealthPlanApiFunction():
                buyPerosnalPlanApiFunction();
        // buyPlanApiFunction();
      }
      else{
        errorAlertDialog(response['message']);
      }
    }else{
    }
  }

  buyThirdPartyPlanApiFunction()async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "serviceID":model!.data![currentOperatorIndex].serviceID,
      "billersCode": "ATU480ER",
      "variation_code": "1",
      "amount": amountController.text,
      "phone": "08011111111",
      "Insured_Name": controller2.text,
      "Engine_Number": controller3.text,
      "Chasis_Number": controller4.text,
      "Plate_Number": controller1.text,
      "Vehicle_Make": controller5.text,
      "Vehicle_Color": controller6.text,
      "Vehicle_Model": controller7.text,
      "Year_of_Make": controller8.text,
      "Contact_Address": controller9.text,

      "operator": {
        "serviceID": model!.data![currentOperatorIndex].serviceID,
        "title": model!.data![currentOperatorIndex].title,
        "image": model!.data![currentOperatorIndex].image
      }
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.buyVehiclePlanUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
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

  buyHealthPlanApiFunction()async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "serviceID": model!.data![currentOperatorIndex].serviceID,
      "billersCode": "Testimetri Adams",
      "variation_code": "individual-monthly",
      "amount": amountController.text,
      "phone": controller2.text,
      "full_name":controller1.text,
      "address": controller3.text,
      "selected_hospital": controller4.text,
      'selected_hospital_value':selectedHospitalValue,
      "Passport_Photo":file!=null? file!.path:"",
      "date_of_birth": controller5.text,
      "extra_info": controller6.text,
      "operator": {
        "serviceID": model!.data![currentOperatorIndex].serviceID,
        "title": model!.data![currentOperatorIndex].title,
        "image": model!.data![currentOperatorIndex].image
      }
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.buyHealthPlanUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
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

  buyPerosnalPlanApiFunction()async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "serviceID": model!.data![currentOperatorIndex].serviceID,
      "billersCode": "Testimetri Adams",
      "variation_code": "option-a",
      "amount": amountController.text,
      "full_name": controller1.text,
      "phone": controller2.text,
      "address": controller3.text,
      "dob": controller5.text,
      "next_kin_name": controller1.text,
      "next_kin_phone": controller2.text,
      "business_occupation": controller4.text,
      "operator": {
        "serviceID": model!.data![currentOperatorIndex].serviceID,
        "title": model!.data![currentOperatorIndex].title,
        "image": model!.data![currentOperatorIndex].image
      }
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.buyPersonalPlanUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
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
            child: SizedBox(
              // height: MediaQuery.of(context).size.height*0.9,
              child: SingleChildScrollView(
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
                    currentOperatorIndex==0?
                    thirdPartyDetailsWidget():
                    currentOperatorIndex==1?
                    healthDetailsWidget():
                     personalDetailsWidget(),
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
            ),
          );
        });

  }

  thirdPartyDetailsWidget(){
    return Column(
      children: [
        rowColumnForConfirmationWidget('Vehicle Number', controller1.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Owner Name', controller2.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Engine Number', controller3.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Chassis Number', controller4.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Vehicle Maker', controller5.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Vehicle Color', controller6.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Vehicle Model', controller7.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Vehicle Purchased Year', controller8.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Address', controller9.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Amount', amountController.text),
      ],
    );
  }
  personalDetailsWidget(){
    return Column(
      children: [
        rowColumnForConfirmationWidget('Full Name', controller1.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Phone Number', controller2.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Address', controller3.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Business Occupation', controller4.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('DOB', controller5.text),
      ],
    );
  }
  healthDetailsWidget(){
    return Column(
      children: [
        rowColumnForConfirmationWidget('Full Name', controller1.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Phone Number', controller2.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Address', controller3.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Hospital', controller4.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('DOB', controller5.text),
        ScreenSize.height(16),
        rowColumnForConfirmationWidget('Description', controller6.text),
        ScreenSize.height(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getText(title: 'Photo', size: 14,
                fontFamily: Constants.galanoGrotesqueRegular,
                color: const Color(0xff7F808C), fontWeight: FontWeight.w400),
            ScreenSize.width(8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:  Image.file(File(file!.path),fit: BoxFit.cover,height: 80,width: 80,),)
          ],
        )
      ],
    );
  }


}
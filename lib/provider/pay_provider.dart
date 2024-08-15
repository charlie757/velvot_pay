import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/model/electricity_plan_model.dart';
import 'package:velvot_pay/provider/profile_provider.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../approutes/app_routes.dart';
import '../screens/dashboard/home/successfully_payment_screen.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class PayProvider extends ChangeNotifier{
  String base64String = '';
  String apiUrl = '';
ElectricityPlanModel?electricityPlanModel;


 setApiUrls(String route){
   switch(route){
     case 'operator':
       return ApiUrl.buyDataSubscriptionPlanUrl;
     case 'electricity':
       return  ApiUrl.electricityBillPaymentUrl;
     case 'education':
       return ApiUrl.buyEducationalPlanUrl;
     case 'tv':
       return ApiUrl.buyTvPlanUrl;
     case 'insurance-third party':
       return ApiUrl.buyVehiclePlanUrl;
     case 'insurance-health':
       return ApiUrl.buyHealthPlanUrl;
     case 'insurance-personal':
       return ApiUrl.buyPersonalPlanUrl;
     case 'topup':
       return ApiUrl.buyMobileTopUpPlanUrl;
     default:
       return '';
   }
 }
  Future<String> convertFileToBase64(String filePath) async {
    try {
      // Read the file
      File file = File(filePath);
      // Read the file contents as bytes
      List<int> fileBytes = await file.readAsBytes();
      // Convert bytes to base64 string
         base64String = base64Encode(fileBytes);
      print(base64String);
      return base64String;
    } catch (e) {
      print("Error converting file to base64: $e");
      return '';
    }
  }

  electricityBillDetailsApiFunction(String plan, String billerCode,String type)async{
    electricityPlanModel = null;
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "serviceID": plan,
      "billersCode":billerCode,
      "type":type
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

  payStackApiFunction(double amount, var data, String route, String isFromSearchNumberRoute)async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "amount":amount.toString()
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.payStackInitializeUrl, body: body, method: checkApiMethod(httpMethod.post));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      checkout(response['data']['access_code'], response['data']['reference'],amount,data,route, isFromSearchNumberRoute);
    } else {

    }
    notifyListeners();
  }


final plugin = PaystackPlugin();
String successMessage = '';


PaymentCard _getTestCard() {
  return PaymentCard(
    number: '4084 0840 8408 4081', // Declined transaction card
    cvc: '408',
    expiryMonth: 12,
    expiryYear: 24,
  );
}
  // test@gmail.com
checkout(String accessCode,String reference,double amount,var data,route, String isFromSearchNumberRoute) async {
  String email = Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!=null&&Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!=null?Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!.email:
  'test@gmail.com';
  int price = (amount*100).round();
  Charge charge = Charge()
    ..amount = price
    ..reference = reference
    ..email = email..card = _getTestCard()..accessCode=accessCode
    ..currency = "NGN";
  CheckoutResponse response = await plugin.checkout(
    navigatorKey.currentContext!,
    method: CheckoutMethod.card,
    charge: charge,
    // fullscreen: true
    // logo: Container()
  );
  if (response.status == true) {
    print('response....$response');
    var paymentData = {
      "card":{
        'cvc':response.card!.cvc,
        'expiryMonth':response.card!.expiryMonth,
        'expiryYear':response.card!.expiryYear,
        'name':response.card!.name,
        'type':response.card!.type,
        'last4Digit':response.card!.last4Digits
      },
      'verify':response.verify,
      'reference':response.reference,
      'method':response.method.name
    };
    print("paymentData...$paymentData");
    buyPlanApiFunction(data,paymentData,route,isFromSearchNumberRoute);
  } else {
    print(response.message);

  }
}


Future<String> setJsonBodyData(type,data,paymentData)async{
  switch (type){
    case 'insurance-third party':
      return json.encode({
        "serviceID": data['serviceId'],
        "billersCode":'ATU480ER',
        // data['billerData']['billersCode'],
        "variation_code": data['variation_code'],
        "amount": data['amount'],
        "phone": Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!.mobileNumber.toString(),
        "Insured_Name": data['billerData']['Insured_Name'],
        "Engine_Number": data['billerData']['Engine_Number'],
        "Chasis_Number": data['billerData']['Chasis_Number'],
        "Plate_Number": 'ATU480ER',
        "Vehicle_Make": data['billerData']['Vehicle_Make'],
        "Vehicle_Color": data['billerData']['Vehicle_Color'],
        "Vehicle_Model":data['billerData']['Vehicle_Model'],
        "Year_of_Make": data['billerData']['Year_of_Make'],
        "Contact_Address": data['billerData']['Contact_Address'],
        "paymentData": paymentData,
        "operator": {
          "serviceID":data['serviceId'],
          "title": data['operatorName'],
          "image": data['operatorImage']
        }
      });
    case 'insurance-personal':
      return json.encode({
        "serviceID": data['serviceId'],
        "billersCode":'Testimetri Adams',
        "variation_code": data['variation_code'],
        "amount": data['amount'],
        "phone": Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!.mobileNumber.toString(),
        "full_name": data['billerData']['full_name'],
        "address": data['billerData']['address'],
        "dob": data['billerData']['dob'],
        "next_kin_name": data['billerData']['full_name'],
        "next_kin_phone": data['billerData']['phone'],
        "business_occupation": data['billerData']['business_occupation'],
        "paymentData": paymentData,
        "operator": {
          "serviceID":data['serviceId'],
          "title": data['operatorName'],
          "image": data['operatorImage']
        }
      });
    case 'insurance-health':
      print('fdffd');
      return json.encode({
        "serviceID": data['serviceId'],
        "billersCode":'Testimetri Adams',
        "variation_code": data['variation_code'],
        "amount": data['amount'],
        "phone": data['billerData']['phone'],
        "full_name": data['billerData']['full_name'],
        "address": data['billerData']['address'],
        "dob": data['billerData']['date_of_birth'],
        "selected_hospital": data['billerData']['selected_hospital_value'],
        "extra_info": data['billerData']['extra_info'],
        "Passport_Photo":jsonEncode(base64String),
        "paymentData": paymentData,
        "operator": {
          "serviceID":data['serviceId'],
          "title": data['operatorName'],
          "image": data['operatorImage']
        }
      });
    case 'topup':
      return json.encode({
        "serviceID": data['serviceId'],
        // data['number'],
        "amount": data['amount'],
        "phone":  '08011111111',
        "paymentData": paymentData,
        "operator": {
          "serviceID":data['serviceId'],
          "title": data['operatorName'],
          "image": data['operatorImage'],
          "minimium_amount": data['minimium_amount'],
          "maximum_amount": data['maximum_amount'],
        }
      });
    default:
        return json.encode({
          "serviceID": data['serviceId'],
          "billersCode":type=='electricity'?data['billersCode']:type=='tv'?'1212121212': '08011111111',
          // data['number'],
          "variation_code": data['variation_code'],
          "amount": data['amount'],
          "phone": type=='operator'? '08011111111':Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!.mobileNumber.toString(),
          "paymentData": paymentData,
          "operator": {
            "serviceID":data['serviceId'],
            "title": data['operatorName'],
            "image": data['operatorImage']
          }
        });

  }
}


buyPlanApiFunction(var data,var paymentData,String route, String isFromSearchNumberRoute)async{
  notifyListeners();
  showLoader(navigatorKey.currentContext!);
  var body = await setJsonBodyData(route, data, paymentData);
print(body);
print(apiUrl);
  final response = await ApiService.apiMethod(
      url: apiUrl, body: body, method: checkApiMethod(httpMethod.post),isErrorMessageShow: true);
  Navigator.pop(navigatorKey.currentContext!);
  if (response != null) {
    AppRoutes.pushReplacementNavigation( SuccessfullyPaymentScreen(
      amount: data['amount'],
      operatorName: data['operatorName'],
      transactionId: response['data']['transaction_id'].toString(),
      route: route, isFromSearchNumberRoute:isFromSearchNumberRoute
    ));
  } else {
  }
  notifyListeners();

}

}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/model/bank_details_model.dart';
import 'package:velvot_pay/provider/profile_provider.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class WalletProvider extends ChangeNotifier{
final formKey = GlobalKey<FormState>();
final amountController = TextEditingController();
BankAccountModel? model;

resetValues(){
  amountController.clear();
}

checkValidation(){
  if(formKey.currentState!.validate()){
    print(amountController.text);
    payStackApiFunction();
  }
}

  payStackApiFunction()async{
    notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "amount":amountController.text
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.payStackInitializeUrl, body: body, method: checkApiMethod(httpMethod.post));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      checkout(response['data']['access_code'], response['data']['reference'],);
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
  checkout(String accessCode,String reference,) async {
    String email = Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!=null&&Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!=null?Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).model!.data!.email:
    'test@gmail.com';
    int price = (double.parse(amountController.text.toString())*100).round();
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
      addWalletApiFunction(paymentData);
    } else {
      Fluttertoast.showToast(msg: response.message.toString());
      print(response.message);

    }
  }

  addWalletApiFunction(var paymentData)async{
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "type": 'DEBIT',
      "amount": amountController.text,
      "payment_data": paymentData,
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.addWalletUrl,
        body: body,
        method: checkApiMethod(httpMethod.put));
    Navigator.pop(navigatorKey.currentContext!);
   if(response!=null){
     Navigator.pop(navigatorKey.currentContext!);
     Navigator.pop(navigatorKey.currentContext!);
     Utils.successSnackBar(response['message'].toString(), navigatorKey.currentContext!);
     // Fluttertoast.showToast(msg: response['message'].toString());
   }
  }

  createBankApiFunction()async{
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.createBankUrl,
        body: body,
        method: checkApiMethod(httpMethod.get));
    Navigator.pop(navigatorKey.currentContext!);
    if(response!=null){
      fetchBankApiFunction();
    }
  }

fetchBankApiFunction()async{
  model!=null?null: showLoader(navigatorKey.currentContext!);
  var body = json.encode({
  });
  final response = await ApiService.apiMethod(
      url: ApiUrl.bankUrl,
      body: body,
      method: checkApiMethod(httpMethod.get));
  model!=null?null:Navigator.pop(navigatorKey.currentContext!);
  if(response!=null){
    model = BankAccountModel.fromJson(response);
  }
  else{
    model = null;
  }
  notifyListeners();
}
}
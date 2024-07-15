import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class ContactUsProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final messageController = TextEditingController();
  final topicController = TextEditingController();
  // final OverlayPortalController tooltipController = OverlayPortalController();
  final link = LayerLink();
  List topicList = ["Transaction issue", 'Profile issue', 'Other'];
  final formKey = GlobalKey<FormState>();
  int selectedOption = -1;

  updateOptions(value){
    selectedOption=value;
    notifyListeners();
  }

  resetValue() {
    selectedOption=-1;
    nameController.clear();
    emailController.clear();
    numberController.clear();
    messageController.clear();
    topicController.clear();
  }

  checkValidation() {
    if (formKey.currentState!.validate()) {
      Utils.hideTextField();
      callContactUsApiFunction();
    }
  }

  callContactUsApiFunction() async {
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "name": nameController.text,
      "email": emailController.text,
      "number": numberController.text,
      "topic": topicController.text,
      "message": messageController.text
    });
    final response = await ApiService.apiMethod(
        url: ApiUrl.contactUsUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      topicController.clear();
      messageController.clear();
    } else {}
    notifyListeners();
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velvot_pay/apiconfig/api_service.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:velvot_pay/model/profile_model.dart';
import 'package:velvot_pay/screens/auth/signup/verify_email_screen.dart';
import 'package:velvot_pay/screens/auth/veriy_otp_screen.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class ProfileProvider extends ChangeNotifier {
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  File? file;
  ProfileModel? model;

  resetValues() {
    file = null;
    model=null;
    isLoading = false;
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    addressController.text = '';
  }

  updateIndex(bool value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    if (formKey.currentState!.validate()) {
      updateProfileApiFunction('profile');
    }
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

  setProfileValues(){
    firstNameController.text = model!.data!.firstName ?? '';
    lastNameController.text = model!.data!.lastName??'';
    emailController.text = model!.data!.email ?? '';
    numberController.text = model!.data!.mobileNumber ?? '';
    addressController.text = model!.data!.address ?? '';
  }

  getProfileApiFunction() async {
    file = null;
    model != null ? null : showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.getProfileUrl,
        body: body,
        method: checkApiMethod(httpMethod.get));
    model != null ? null : Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      model = ProfileModel.fromJson(response);
      setProfileValues();
      notifyListeners();
    } else {
      model = null;
    }
  }
  updateProfileApiFunction(String route) async {
    Utils.hideTextField();
    showLoader(navigatorKey.currentContext!);
    Map<String, String> headers = {"x-access-token": SessionManager.token};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
    request.headers.addAll(headers);
    request.fields['first_name'] = firstNameController.text;
    request.fields['last_name'] = lastNameController.text;
    request.fields['email'] = emailController.text;
    request.fields['address'] = addressController.text;
    if (file != null) {
      final file = await http.MultipartFile.fromPath(
        'image',
        this.file!.path,
      );
      request.files.add(file);
      print(file);
      print(this.file!.path);
    }
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    print(vb.request);
    log(vb.body);
    Navigator.pop(navigatorKey.currentContext!);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      if(route=='addEmail'){
        AppRoutes.pushNavigation(VerifyEmailScreen(email: emailController.text, isProgressBar: false,
        route: 'addEmail',
        ));
      }else {
        Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
        getProfileApiFunction();
      }
    } else if (vb.statusCode == 401) {
      Utils.logOut();
    } else {
      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
    }
  }

  deleteAccountApiFunction()async{
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({});
    final response = await ApiService.apiMethod(
        url: ApiUrl.deleteAccountUrl,
        body: body,
        method: checkApiMethod(httpMethod.delete));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      Utils.logOut();
      notifyListeners();
    } else {

    }
  }

}

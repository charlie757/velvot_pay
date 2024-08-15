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
import 'package:velvot_pay/screens/auth/veriy_otp_screen.dart';
import 'package:velvot_pay/utils/show_loader.dart';
import 'package:velvot_pay/utils/utils.dart';

class ProfileProvider extends ChangeNotifier {
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  bool isLoading = false;
  bool isPhotoError = false;
  File? file;
  ProfileModel? model;

  resetValues() {
    file = null;
    model=null;
    isLoading = false;
    isPhotoError = false;
    nameController.text = '';
    emailController.text = '';
    addressController.text = '';
  }

  updateIndex(bool value) {
    isLoading = value;
    notifyListeners();
  }

  updatePhotoError(bool value) {
    isPhotoError = value;
    notifyListeners();
  }

  checkValidation(formKey) {
    if (formKey.currentState!.validate() && file != null) {
      updatePhotoError(false);
      callRegisterApiFunction();
    }
    if (file == null) {
      updatePhotoError(true);
    } else {
      updatePhotoError(false);
    }
  }

  checkUpdateProfileValidation(formKey) {
    if (formKey.currentState!.validate()) {
      updateProfileApiFunction();
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

  callRegisterApiFunction() async {
    updateIndex(true);
    Map<String, String> headers = {"x-access-token": SessionManager.token};

    var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.registerUrl));
    request.headers.addAll(headers);
    request.fields['name'] = nameController.text;
    request.fields['mobile_number'] = numberController.text;
    request.fields['email'] = emailController.text;
    request.fields['address'] = addressController.text;
    if (file != null) {
      final file = await http.MultipartFile.fromPath(
        'image', this.file!.path,
        // contentType: mime.MediaType("image", "jpg")
      );
      request.files.add(file);
    }

    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    updateIndex(false);
    log(vb.body);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      Utils.showToast(dataAll['data']['otp'].toString());
      AppRoutes.pushReplacementNavigation(VerifyOtpScreen(
        number: numberController.text,
        route: 'register',
      ));
    } else {
      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
    }
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
      nameController.text = model!.data!.firstName ?? '';
      emailController.text = model!.data!.email ?? '';
      numberController.text = model!.data!.mobileNumber ?? '';
      addressController.text = model!.data!.address ?? '';
      notifyListeners();
    } else {
      model = null;
    }
  }

  updateProfileApiFunction() async {
    showLoader(navigatorKey.currentContext!);
    Map<String, String> headers = {"x-access-token": SessionManager.token};

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
    request.headers.addAll(headers);
    request.fields['name'] = nameController.text;
    request.fields['address'] = addressController.text;
    if (file != null) {
      final file = await http.MultipartFile.fromPath(
        'image',
        this.file!.path,
      );
      request.files.add(file);
    }

    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    print(vb.request);
    log(vb.body);
    Navigator.pop(navigatorKey.currentContext!);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      getProfileApiFunction();
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
    } else if (vb.statusCode == 401) {
      Utils.logOut();
    } else {
      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
    }
  }
}

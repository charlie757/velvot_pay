import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/screens/auth/forgot/reset_password_screen.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';
import 'package:velvot_pay/utils/enum.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../approutes/app_routes.dart';
import '../helper/app_color.dart';
import '../helper/custom_btn.dart';
import '../helper/getText.dart';
import '../helper/images.dart';
import '../helper/screen_size.dart';
import '../helper/session_manager.dart';
import '../screens/auth/signup/password_screen.dart';
import '../screens/auth/signup/personal_details_screen.dart';
import '../screens/auth/signup/set_transaction_pin_screen.dart';
import '../screens/auth/signup/verify_email_screen.dart';
import '../screens/auth/signup/verify_phone_screen.dart';
import '../utils/Constants.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;


class SignupProvider extends ChangeNotifier{
  int currentIndex = 0;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;



  final pinController = TextEditingController();
  bool isLoading = false;
  int phoneCounter = 30;
  Timer? phoneTimer;
  bool phoneResend = false;

  int emailCounter = 30;
  Timer? emailTimer;
  bool emailResend = false;

  startPhoneTimer() {
    //shows timer
    phoneCounter = 30; //time counter
    phoneTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(phoneCounter>0){
        phoneCounter--;
      }
      else{
        phoneResend=true;
        timer.cancel();
      }
      notifyListeners();
    });
  }

  startEmailTimer() {
    //shows timer
    emailCounter = 30; //time counter
    emailTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(emailCounter>0){
        emailCounter--;
      }
      else{
        emailResend=true;
        timer.cancel();
      }
      notifyListeners();
    });
  }

  updateLoading(bool value){
  isLoading = value;
  notifyListeners();
}

  updateIndex(int index){
    currentIndex = index;
    notifyListeners();
  }


  registerApiFunction(String number)async{
    Utils.hideTextField();
    updateLoading(true);
    var body = json.encode({'mobile_number': number});
    final response = await ApiService.apiMethod(
        url: ApiUrl.registerUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      String otp = response['data']!=null? response['data']['otp'].toString():'';
      AppRoutes.pushNavigation( VerifyPhoneScreen(number: number,otp:otp,isShowProgressBar: true,));
    } else {
    }
  }

  verifyOtpApiFunction(String number, String otp, String type, String route)async{
    Utils.hideTextField();
    var body = json.encode({
      "mobile_number": number,
      "type": type,
      "otp": otp,
      "device_token": "123456789",
      "device_type": Platform.isAndroid ? "ANDROID" : "IOS"
    });
    updateLoading(true);
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.verifyOtpUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      if(route=='forgot'){
        AppRoutes.pushRemoveReplacementNavigation(const ResetPasswordScreen());
        SessionManager.setToken = response['data']['api_token'];
        SessionManager.setPinSetup = false; /// make the default value false in forgot case to check user is trying to login or forgot password
      }

      else if(route =='addEmail'){
        Navigator.pop(navigatorKey.currentContext!);
        Navigator.pop(navigatorKey.currentContext!);
      }

      else {
        SessionManager.setToken = response['data']['api_token'];
        SessionManager.setUserId = response['data']['_id'];
        SessionManager.setOtpEmailVerify = response['data']['is_otp_email'];
        SessionManager.setPinSetup = response['data']['is_pin_setup'];
        SessionManager.setPasswordSetup = response['data']['is_password_setup'];
        SessionManager.setBankSetup = response['data']['is_bank_account'];
        SessionManager.setCompleteProfile =
        response['data']['is_complete_profile'];
        if (!response['data']['is_password_setup']) {
          AppRoutes.pushRemoveReplacementNavigation(const PasswordScreen());
        }
        else if (!response['data']['is_complete_profile']) {
          AppRoutes.pushRemoveReplacementNavigation(
              const PersonalDetailsScreen());
        }
        else if (!response['data']['is_pin_setup']) {
          AppRoutes.pushRemoveReplacementNavigation(
              const SetTransactionPinScreen());
        }
        else {
          AppRoutes.pushRemoveReplacementNavigation(const DashboardScreen());
        }
      }
    } else {}

  }



  verifyEmailOtpApiFunction(String email, String otp, String type)async{
    Utils.hideTextField();
    var body = json.encode({
      "mobile_number": email,
      "type": type,
      "otp": otp,
      "device_token": "123456789",
      "device_type": Platform.isAndroid ? "ANDROID" : "IOS"
    });
    updateLoading(true);
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.verifyOtpUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      // SessionManager.setToken = response['data']['api_token'];
      // SessionManager.setUserId = response['data']['_id'];
      // SessionManager.setOtpEmailVerify = response['data']['is_otp_email'];
      // SessionManager.setPinSetup = response['data']['is_pin_setup'];
      // SessionManager.setPasswordSetup = response['data']['is_password_setup'];
      // SessionManager.setBankSetup = response['data']['is_bank_account'];
      // SessionManager.setCompleteProfile = response['data']['is_complete_profile'];

    //   if(!response['data']['is_password_setup']){
    //     AppRoutes.pushRemoveReplacementNavigation(const PasswordScreen());
    //   }
    //   else if(!response['data']['is_complete_profile']){
    //     AppRoutes.pushRemoveReplacementNavigation(const PersonalDetailsScreen());
    //   }
    //   else if(response['data']['is_password_setup']){
    //
    //   }
    //
    } else {}

  }


  Future resendApiFunction(String number, String type) async {
    Utils.hideTextField();
    showLoader(navigatorKey.currentContext!);
    var body = json.encode({
      "mobile_number": number,
      "type": type,
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.resendOtpUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      // Utils.showToast(response['data']['otp'].toString());
      Utils.successSnackBar(response['message'], navigatorKey.currentState!.context);
      if(type == VerifyOtpType.REGISTER.name||type == VerifyOtpType.LOGIN.name ){
        startPhoneTimer();
      }
      else{
        startEmailTimer();
      }
    } else {}
    return response;
  }

  setPasswordApiFunction(String password)async{
    updateLoading(true);
    var body = json.encode({  "password": password,
      "password_confirmation": password});
    final response = await ApiService.apiMethod(
        url: ApiUrl.createPasswordUrl,
        body: body,
        method: checkApiMethod(httpMethod.put));
      updateLoading(false);
    if (response != null) {
      openBottomSheet(title: 'Account Secured',
          des: 'Congratulations, you have successfully secured your account',
          btnTitle: 'Continue', onTap: (){
            AppRoutes.pushRemoveReplacementNavigation(const PersonalDetailsScreen());
          });
    } else {
    }
  }

  updateProfileApiFunction(String firstName,String lastName, String email,String address) async {
    Utils.hideTextField();
  updateLoading(true);
    Map<String, String> headers = {"x-access-token": SessionManager.token};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
    request.headers.addAll(headers);
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['email'] = email;
    request.fields['address'] = address;
    // if (file != null) {
    //   final file = await http.MultipartFile.fromPath(
    //     'image',
    //     this.file!.path,
    //   );
    //   request.files.add(file);
    // }

    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    print(vb.request);
    log(vb.body);
  updateLoading(false);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      SessionManager.setToken = dataAll['data']['data']['api_token'];
      SessionManager.setUserId = dataAll['data']['data']['_id'];
      SessionManager.setCompleteProfile = dataAll['data']['data']['is_complete_profile'];
      AppRoutes.pushNavigation( VerifyEmailScreen(email: email,isProgressBar: true,
      ));
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
    } else if (vb.statusCode == 401) {
      Utils.logOut();
    } else {
      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
    }
  }

  setMPinApiFunction(String pin)async{
    updateLoading(true);
    Utils.hideTextField();
    var body = json.encode({  "pin": pin,
      });
    final response = await ApiService.apiMethod(
        url: ApiUrl.setMPinUrl,
        body: body,
        method: checkApiMethod(httpMethod.put));
    updateLoading(false);
    if (response != null) {
      openBottomSheet(title: 'Transaction Pin\nCreated',
          des: 'Congratulations, you have successfully created your transaction pin',
          btnTitle: 'Go to Dashboard', onTap: (){
        SessionManager.setPinSetup = true;
        notifyListeners();
            AppRoutes.pushRemoveReplacementNavigation(const DashboardScreen());
          });
    } else {
    }
  }


  openBottomSheet({required String title,required String des,required String btnTitle,required  Function()onTap}){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        isDismissible: false,
        shape:const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
            )
        ),
        context: navigatorKey.currentState!.context, builder: (context){
      return WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child: Container(
          padding:const EdgeInsets.only(top: 24,left: 16,right: 16,bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Images.successIcon),
              ScreenSize.height(8),
              getText(title: title,
                  textAlign: TextAlign.center,
                  size: 24, fontFamily: Constants.galanoGrotesqueMedium,
                  color: const Color(0xff26272B), fontWeight: FontWeight.w700),
              ScreenSize.height(8),
              getText(title: des,
                size: 14, fontFamily: Constants.galanoGrotesqueRegular,
                color: const Color(0xff51525C), fontWeight: FontWeight.w400,textAlign: TextAlign.center,),
              ScreenSize.height(32),
              CustomBtn(title: btnTitle, onTap: onTap)
            ],
          ),
        ),
      );
    });
  }

}
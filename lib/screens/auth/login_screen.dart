import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/login_provider.dart';
import 'package:velvot_pay/screens/auth/forgot/forgot_screen.dart';
import 'package:velvot_pay/screens/auth/signup/signup_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<LoginProvider>(context,listen: false);
    provider.resetValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SvgPicture.asset(Images.arrowBackImage),
                  //   ScreenSize.height(32),
                    getText(title: 'Welcome Back',
                        size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                        fontWeight: FontWeight.w700),
                    ScreenSize.height(7),
                    getText(title: 'Sign in to your account to continue from where you stopped',
                        size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff51525C),
                        fontWeight: FontWeight.w400),
                    ScreenSize.height(32),
                  getText(
                      title: 'Phone Number',
                      size: 14,
                      fontFamily: Constants.galanoGrotesqueMedium,
                      color: AppColor.grayIronColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(8),
                  CustomTextField(
                    hintText: 'Mobile Number',
                    controller: myProvider.phoneController,
                    textInputAction: TextInputAction.next,
                    textInputType: Platform.isAndroid? TextInputType.number:const TextInputType.numberWithOptions(signed: true, decimal: true),
                    isReadOnly: myProvider.isLoading,
                    prefixWidget: Container(
                      width: 100,
                      padding:const EdgeInsets.only(left: 13),
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.flag),
                          ScreenSize.width(4),
                          getText(title: "+234",
                              size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                              color: const Color(0xffA0A0AB), fontWeight: FontWeight.w500),
                          Icon(Icons.keyboard_arrow_down_outlined,color: const Color(0xff70707B).withOpacity(.5),)
                        ],
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Enter your number";
                      } else if (val.length < 10) {
                        return 'Number should be valid';
                      }
                    },
                  ),
                  ScreenSize.height(16),
                  getText(
                      title: 'Password',
                      size: 14,
                      fontFamily: Constants.galanoGrotesqueMedium,
                      color: AppColor.grayIronColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(8),
                  CustomTextField(
                    hintText: 'Password',
                    controller: myProvider.passwordController,
                    textInputAction: TextInputAction.done,
                    isObscureText: myProvider.isVisible,
                    isReadOnly: myProvider.isLoading,
                    suffixWidget: GestureDetector(
                      onTap: (){
                        myProvider.isVisible = !myProvider.isVisible;
                        setState(() {
                        });
                      },
                      child: SizedBox(
                        width: 40,
                        child: Icon(
                          !myProvider.isVisible?
                          Icons.visibility_outlined:Icons.visibility_off_outlined ,color:const Color(0xff70707B).withOpacity(.6),),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Enter your password";
                      } else if (!Utils.passwordValidateRegExp(val)) {
                        return 'The password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                      }
                    },
                  ),
                  ScreenSize.height(8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        openBottomSheet();
                      },
                      child: SizedBox(
                        height: 20,
                        child: getText(title: 'Forgot Password?', size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                            color: AppColor.appColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBtn(
                  title: "Sign In",
                  isLoading: myProvider.isLoading,
                  onTap: () {
                    myProvider.checkValidation(formKey);
                  }),
              ScreenSize.height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getText(title: 'Don’t have an account? ',
                      size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                      color: const Color(0xff3F3F46), fontWeight: FontWeight.w500),
                  GestureDetector(
                    onTap: (){
                      AppRoutes.pushNavigation(const SignUpScreen());
                    },
                    child: Row(
                      children: [
                        getText(title: 'Sign Up',
                            size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                            color: AppColor.appColor, fontWeight: FontWeight.w500),
                        ScreenSize.width(6),
                        SvgPicture.asset(Images.arrowForwardIcon),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ),
      );
    });
  }
  openBottomSheet(){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape:const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
            )
        ),
        context: navigatorKey.currentState!.context, builder: (context){
      return Container(
        padding:const EdgeInsets.only(top: 24,left: 16,right: 16,bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Images.logout),
            ScreenSize.height(8),
            getText(title: 'Forgot Password?',
                textAlign: TextAlign.center,
                size: 24, fontFamily: Constants.galanoGrotesqueMedium,
                color: const Color(0xff26272B), fontWeight: FontWeight.w700),
            ScreenSize.height(8),
            getText(title: 'Reset your password',
              size: 14, fontFamily: Constants.galanoGrotesqueRegular,
              color: const Color(0xff51525C), fontWeight: FontWeight.w400,textAlign: TextAlign.center,),
            ScreenSize.height(32),
            CustomBtn(title: 'Reset with Phone Number', onTap: (){
              AppRoutes.pushNavigation(const ForgotScreen(route: 'mobile',)).then((value) {
                Navigator.pop(context);
              });
            }),
            ScreenSize.height(8),
            GestureDetector(
              onTap: (){
                AppRoutes.pushNavigation(const ForgotScreen(route: 'email',)).then((value) {
                  Navigator.pop(context);
                });
              },
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.appColor)
                ),
                alignment: Alignment.center,
                child:  getText(
                    title: 'Reset with Email Address',
                    size: 16,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      );
    });
  }


}

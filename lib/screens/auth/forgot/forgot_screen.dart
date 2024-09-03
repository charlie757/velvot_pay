import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';

import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/screen_size.dart';
import '../../../provider/forgot_provider.dart';
import '../../../utils/Constants.dart';
import '../../../utils/utils.dart';

class ForgotScreen extends StatefulWidget {
  final String route;
  const ForgotScreen({required this.route});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          body: SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(Images.arrowBackImage),
                  ),
                ScreenSize.height(32),
                getText(title: 'Forgot Password',
                    size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w700),
                ScreenSize.height(7),
              widget.route=='mobile'?
              phoneNumberWidget(myProvider):
              emailWidget(myProvider),

            ],
          ),
            ),
              )),
          bottomNavigationBar: Padding(padding:const EdgeInsets.only(left: 16,right: 16,bottom: 30),
          child:   CustomBtn(
              title: "Continue",
              isLoading: myProvider.isLoading,
              onTap: () {
                if(formKey.currentState!.validate()){
                  myProvider.isLoading?null:
                  myProvider.callForgotApiFunction(controller.text, widget.route.toUpperCase());
                }
                // myProvider.checkValidation(formKey);
              }),

          ),
        );
      }
    );
  }

  phoneNumberWidget(ForgotProvider provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Enter the phone number you used in opening your account',
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
          controller: controller,
          textInputAction: TextInputAction.done,
          textInputType: Platform.isAndroid? TextInputType.number:const TextInputType.numberWithOptions(signed: true, decimal: true),
          isReadOnly: provider.isLoading,
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
        ScreenSize.height(30),
        InkWell(
          onTap: (){
            AppRoutes.pushNavigation(const ForgotScreen(route: 'email'));
          },
          child: getText(
              title: 'Reset with Email Address',
              size: 14,
              fontFamily: Constants.galanoGrotesqueMedium,
              color: AppColor.appColor,
              fontWeight: FontWeight.w500),
        ),

      ],
    );
  }

  emailWidget(ForgotProvider provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Enter the Email Address you used in opening your account',
            size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff51525C),
            fontWeight: FontWeight.w400),
        ScreenSize.height(32),
        getText(
            title: 'Email Address',
            size: 14,
            fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor,
            fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          isReadOnly: provider.isLoading,
          hintText: 'Email Address',
          textInputAction: TextInputAction.done,
          controller: controller,
          fillColor: AppColor.whiteColor,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),],
          validator: (val) {
            RegExp regExp = RegExp(Utils.emailPattern.trim());

            if (val.isEmpty) {
              return "Enter your email";
            } else if (!regExp.hasMatch(val)) {
              return "Email should be valid";
            }
          },
        ),
        ScreenSize.height(30),
        InkWell(
          onTap: (){
            AppRoutes.pushNavigation(const ForgotScreen(route: 'mobile'));
          },
          child: getText(
              title: 'Reset with Mobile Number',
              size: 14,
              fontFamily: Constants.galanoGrotesqueMedium,
              color: AppColor.appColor,
              fontWeight: FontWeight.w500),
        ),

      ],
    );
  }

}

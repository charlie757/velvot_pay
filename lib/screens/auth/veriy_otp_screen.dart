import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/auth/profile_screen.dart';
import 'package:velvot_pay/util/constaints.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 185,
                      alignment: Alignment.center,
                      child: Image.asset(Images.appHorizontalLogo)),
                ),
                ScreenSize.height(60),
                Text.rich(TextSpan(
                    text: 'Enter the 6 digit',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColor.hintTextColor,
                        fontFamily: Constaints.poppinsMedium),
                    children: [
                      TextSpan(
                          text: ' OTP',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkBlackColor,
                              fontFamily: Constaints.poppinsBold))
                    ])),
                ScreenSize.height(20),
                Text.rich(TextSpan(
                    text: 'Sent to',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.hintTextColor,
                        fontFamily: Constaints.poppinsMedium),
                    children: [
                      TextSpan(
                          text: ' +1-987-654-3210',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkBlackColor,
                              fontFamily: Constaints.poppinsBold))
                    ])),
                ScreenSize.height(12),
                otpField(context),
                ScreenSize.height(20),
                Text.rich(TextSpan(
                    text: 'Resend OTP in',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.hintTextColor,
                        fontFamily: Constaints.poppinsMedium),
                    children: [
                      TextSpan(
                          text: '  0:30',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkBlackColor,
                              fontFamily: Constaints.poppinsBold))
                    ])),
              ],
            ),
          ),
          bottomImageButtonWidget(
            btnText: 'Continue',
            onTap: () {
              AppRoutes.pushNavigation(const ProfileScreen(
                route: 'otp',
              ));
            },
          )
        ],
      )),
    );
  }

  otpField(BuildContext context) {
    return SizedBox(
      height: 48,
      child: PinCodeTextField(
        // readOnly: controller.isLoading.value,
        // controller: controller.otpController,
        cursorColor: AppColor.hintTextColor,
        autovalidateMode: AutovalidateMode.disabled,
        cursorHeight: 20,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(
            5,
          ),
          activeColor: AppColor.lightAppColor,
          disabledColor: AppColor.lightAppColor,
          selectedColor: AppColor.lightAppColor,
          inactiveColor: AppColor.lightAppColor,
          fieldHeight: 48,
          fieldWidth: 48,
          inactiveFillColor: AppColor.lightAppColor,
          selectedFillColor: Colors.white,
          activeFillColor: AppColor.lightAppColor,
        ),
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        length: 6,
        animationDuration: const Duration(milliseconds: 300),
        appContext: context,
        keyboardType: TextInputType.number,
        textStyle: TextStyle(
            color: AppColor.blackColor, fontFamily: Constaints.poppinsRegular),
        enableActiveFill: true,
        onChanged: (val) {},
        onCompleted: (result) {},
        validator: (val) {
          if (val!.isEmpty) {
            return 'Enter otp';
          } else if (val.length < 6) {
            return 'Enter otp shoulb be valid';
          }
          return null;
        },
      ),
    );
  }
}

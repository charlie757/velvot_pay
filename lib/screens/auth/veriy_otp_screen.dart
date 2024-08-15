import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/verify_otp_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String number;
  final String route;
  const VerifyOtpScreen({required this.number, required this.route});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<VerifyOtpProvider>(context, listen: false);
    provider.resetValues();
    provider.startTimer();
  }

  @override
  void dispose() {
    // Provider.of<VerifyOtpProvider>(context, listen: false).otpController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<VerifyOtpProvider>(builder: (context, myProvider, child) {
        return Form(
          key: myProvider.formKey,
          child: SafeArea(
              child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 30),
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
                        fontFamily: Constants.poppinsMedium),
                    children: [
                      TextSpan(
                          text: ' OTP',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkBlackColor,
                              fontFamily: Constants.poppinsBold))
                    ])),
                ScreenSize.height(20),
                Text.rich(TextSpan(
                    text: 'Sent to',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.hintTextColor,
                        fontFamily: Constants.poppinsMedium),
                    children: [
                      TextSpan(
                          text: ' ${widget.number}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkBlackColor,
                              fontFamily: Constants.poppinsBold))
                    ])),
                ScreenSize.height(12),
                otpField(context, myProvider),
                // ScreenSize.height(20),
                myProvider.resend
                    ? getText(
                        title: "Resend OTP",
                        size: 14,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.hintTextColor,
                        fontWeight: FontWeight.w500)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (myProvider.counter <= 0) {
                                myProvider.resendApiFunction(
                                    widget.number, widget.route);
                              }
                            },
                            child: getText(
                                title:
                                    "Resend OTP ${myProvider.counter <= 0 ? '' : "In"}",
                                size: 14,
                                fontFamily: Constants.poppinsMedium,
                                color: AppColor.hintTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                          myProvider.counter <= 0
                              ? Container()
                              : getText(
                                  title: "  0:${myProvider.counter}",
                                  size: 14,
                                  fontFamily: Constants.poppinsBold,
                                  color: AppColor.darkBlackColor,
                                  fontWeight: FontWeight.w500)
                        ],
                      ),
                const Spacer(),
                CustomBtn(
                    title: 'Continue',
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      myProvider.isLoading
                          ? null
                          : myProvider.checkValidation(
                              widget.number, widget.route);
                    })
              ],
            ),
          )),
        );
      }),
    );
  }

  otpField(BuildContext context, VerifyOtpProvider provider) {
    return SizedBox(
      // height: 48,
      child: PinCodeTextField(
        // readOnly: controller.isLoading.value,
        controller: provider.otpController,
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
            color: AppColor.blackColor, fontFamily: Constants.poppinsRegular),
        enableActiveFill: true,
        onChanged: (val) {},
        onCompleted: (result) {},
        validator: (val) {
          if (val!.isEmpty) {
            return 'Enter otp';
          } else if (val.length < 6) {
            return 'Enter otp shoulb be valid';
          }
        },
      ),
    );
  }
}

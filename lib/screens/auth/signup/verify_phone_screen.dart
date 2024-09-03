import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_otp_textfield.dart';
import 'package:velvot_pay/provider/singup_provider.dart';
import 'package:velvot_pay/screens/auth/signup/password_screen.dart';
import 'package:velvot_pay/utils/enum.dart';

import '../../../approutes/app_routes.dart';
import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/screen_size.dart';
import '../../../utils/Constants.dart';
import '../../../widget/progess_indicator.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String number;
  final String otp;
  final bool isShowProgressBar;
  final String route;
  const VerifyPhoneScreen({required this.number, this.otp='',required this.isShowProgressBar, this.route=''});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {

  final phoneOtpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<SignupProvider>(context,listen: false);
    phoneOtpController.text = widget.otp;
    provider.phoneResend=false;
    provider.startPhoneTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 16,right: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            widget.isShowProgressBar?  progressIndicator(2):Container(),
              ScreenSize.height(widget.isShowProgressBar? 14:40),
              Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(Images.arrowBackImage),
                    ),
                    ScreenSize.height(32),
                    getText(title: 'Verify Phone Number',
                        size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                        fontWeight: FontWeight.w700),
                    ScreenSize.height(7),
                    Text.rich(TextSpan(
                        text: 'A 6 digit OTP was shared to ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.grayIronColor,
                            fontFamily: Constants.galanoGrotesqueRegular),
                        children: [
                          TextSpan(
                              text: '${widget.number}, ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.appColor,
                                  fontFamily: Constants.galanoGrotesqueRegular),
                          children: [
                            TextSpan(
                              text: ' input here to continue',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                   color: AppColor.grayIronColor,
                                  fontFamily: Constants.galanoGrotesqueRegular),
                            )
                          ]
                          )
                        ])),
                    ScreenSize.height(24),
                    customOtpTextField(context,phoneOtpController),
                    ScreenSize.height(10),
                     Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (myProvider.phoneCounter <= 0) {
                              myProvider.resendApiFunction(
                                  widget.number, widget.route=='forgot'?
                                  VerifyOtpType.FORGOT_PASSWORD.name:
                              widget.route=='login'?
                              VerifyOtpType.LOGIN.name:
                                  VerifyOtpType.REGISTER.name.toString()).then((value) {
                                    if(value!=null) {
                                      phoneOtpController.text =
                                      value['data']['otp'].toString();
                                      setState(() {
                                        print(phoneOtpController.text);
                                      });
                                    }
                              });
                            }
                          },
                          child: getText(
                              title:myProvider.phoneResend
                                  ? "Resend OTP":
                              "Resend in:",
                              size: 14,
                              fontFamily: Constants.galanoGrotesqueRegular,
                              color: const Color(0xff51525C),
                              fontWeight: FontWeight.w400),
                        ),
                        myProvider.phoneCounter <= 0
                            ? Container()
                            : getText(
                            title: " 0:${myProvider.phoneCounter}",
                            size: 14,
                            fontFamily: Constants.galanoGrotesqueSemiBold,
                            color: AppColor.appColor,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ],
              ))
            ],
          ),
                ),)),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
            child: CustomBtn(
                title: "Verify",
                isLoading: myProvider.isLoading,
                onTap: () {
                  if(formKey.currentState!.validate()){
                    myProvider.isLoading?null:
                    myProvider.verifyOtpApiFunction(widget.number, phoneOtpController.text,
                        widget.route=='forgot'?
                        VerifyOtpType.FORGOT_PASSWORD.name:
                        widget.route=='login'?
                        VerifyOtpType.LOGIN.name:
                        VerifyOtpType.REGISTER.name,
                      widget.route
                    );
                  }
                }),
          ),
        );
      }
    );
  }

}

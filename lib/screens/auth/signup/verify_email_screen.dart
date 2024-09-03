import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_otp_textfield.dart';
import 'package:velvot_pay/screens/auth/signup/set_transaction_pin_screen.dart';
import 'package:velvot_pay/utils/enum.dart';

import '../../../approutes/app_routes.dart';
import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/screen_size.dart';
import '../../../provider/singup_provider.dart';
import '../../../utils/Constants.dart';
import '../../../widget/progess_indicator.dart';

class VerifyEmailScreen extends StatefulWidget {
 final String email;
 final bool isProgressBar;
 final String route;
   VerifyEmailScreen({required this.email,required this.isProgressBar,this.route=''});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  final emailOtpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<SignupProvider>(context,listen: false);
    provider.emailResend=false;
    provider.startEmailTimer();
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
                        widget.isProgressBar?
                        progressIndicator(5):Container(),
                        ScreenSize.height(widget.isProgressBar?14:40),
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
                            getText(title: 'Verify Email Address',
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
                                      text: '${widget.email}, ',
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
                            customOtpTextField(context,emailOtpController),
                            ScreenSize.height(10),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (myProvider.emailCounter <= 0) {
                                      myProvider.resendApiFunction(
                                          widget.email,
                                          widget.route=='forgot'?
                                          VerifyOtpType.FORGOT_PASSWORD.name:
                                          VerifyOtpType.UPDATE_PROFILE.name
                                          ).then((value) {
                                        if(value!=null) {
                                          setState(() {
                                          });
                                        }
                                      });
                                    }
                                  },
                                  child: getText(
                                      title:myProvider.emailResend
                                          ? "Resend OTP":
                                      "Resend in:",
                                      size: 14,
                                      fontFamily: Constants.galanoGrotesqueRegular,
                                      color: const Color(0xff51525C),
                                      fontWeight: FontWeight.w400),
                                ),
                                myProvider.emailCounter <= 0
                                    ? Container()
                                    : getText(
                                    title: " 0:${myProvider.emailCounter}",
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
                      myProvider.verifyOtpApiFunction(widget.email, emailOtpController.text,
                          widget.route=='forgot'?
                          VerifyOtpType.FORGOT_PASSWORD.name:
                          VerifyOtpType.UPDATE_PROFILE.name,
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/auth/veriy_otp_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Images.appVerticleLogo)),
                    ScreenSize.height(61),
                    getText(
                        title: 'Enter Your Mobile Number',
                        size: 16,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w500),
                    ScreenSize.height(10),
                    CustomTextField(hintText: 'Mobile Number'),
                  ],
                ),
              ),
              bottomImageButtonWidget(
                  btnText: 'Proceed',
                  onTap: () {
                    AppRoutes.pushNavigation(VerifyOtpScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

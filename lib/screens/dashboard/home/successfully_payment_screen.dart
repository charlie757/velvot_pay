import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/transcation_history_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

class SuccessfullyPaymentScreen extends StatefulWidget {
  const SuccessfullyPaymentScreen({super.key});

  @override
  State<SuccessfullyPaymentScreen> createState() =>
      _SuccessfullyPaymentScreenState();
}

class _SuccessfullyPaymentScreenState extends State<SuccessfullyPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 55, left: 10, right: 10),
          child: Column(
            children: [
              SvgPicture.asset(Images.successIcon),
              getText(
                title: 'Your Airtel recharge of\n\$500 is successfull',
                size: 20,
                fontFamily: Constants.poppinsSemiBold,
                color: AppColor.darkBlackColor,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              ScreenSize.height(20),
              getText(
                title: 'Your recharge will be applied by\n3:30pm today',
                size: 16,
                fontFamily: Constants.poppinsRegular,
                color: AppColor.darkBlackColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              ScreenSize.height(20),
              Container(
                height: 49,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.darkBlackColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: getText(
                    title: 'View Details',
                    size: 16,
                    fontFamily: Constants.poppinsMedium,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w500),
              ),
              ScreenSize.height(30),
              Image.asset(
                'assets/icons/slider_image.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              CustomBtn(
                  title: 'Done',
                  onTap: () {
                    AppRoutes.pushNavigation(const TranscationHistoryScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/successfully_payment_screen.dart';
import 'package:velvot_pay/util/constaints.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            title: 'Pay',
            onTap: () {
              Navigator.pop(context);
            }),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            payWidget(),
            bottomImageButtonWidget(
                onTap: () {
                  AppRoutes.pushNavigation(SuccessfullyPaymentScreen());
                },
                btnText: "Proceed to Pay")
          ],
        ));
  }

  payWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.lightAppColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)),
                alignment: Alignment.center,
                child: Image.asset(Images.airtelIcon),
              ),
              ScreenSize.width(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: '+234 9876543210',
                      size: 14,
                      fontFamily: Constaints.poppinsSemiBold,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                  getText(
                      title: 'Airtel Prepaid',
                      size: 14,
                      fontFamily: Constaints.poppinsSemiBold,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w500)
                ],
              )
            ],
          ),
          ScreenSize.height(13),
          viewPlanWidget()
        ],
      ),
    );
  }

  viewPlanWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.hintTextColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -2),
                color: AppColor.blackColor.withOpacity(.1),
                blurRadius: 5)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getText(
                  title: '\$499',
                  size: 25,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
              Container(
                height: 32,
                width: 98,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xff211C3A)),
                alignment: Alignment.center,
                child: getText(
                    title: 'Change Plan',
                    size: 12,
                    fontFamily: Constaints.poppinsMedium,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          ScreenSize.height(15),
          Row(
            children: [
              getText(
                  title: 'Data :',
                  size: 12,
                  fontFamily: Constaints.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: '60.0 GB Per PAck',
                  size: 14,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
              // ScreenSize.width(28),
              const Spacer(),
              getText(
                  title: 'Validity :',
                  size: 12,
                  fontFamily: Constaints.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: '28 Days',
                  size: 14,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
            ],
          ),
          ScreenSize.height(11),
          Row(
            children: [
              getText(
                  title: 'Data :',
                  size: 12,
                  fontFamily: Constaints.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: '60 GB',
                  size: 12,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w700),
            ],
          ),
          ScreenSize.height(5),
          Row(
            children: [
              getText(
                  title: 'Data :',
                  size: 12,
                  fontFamily: Constaints.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: 'Till Your Existing Pack',
                  size: 12,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w700),
            ],
          )
        ],
      ),
    );
  }
}

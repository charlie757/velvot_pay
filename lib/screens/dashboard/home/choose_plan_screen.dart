import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/pay_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_divider.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: 'Choose Your Plan',
          onTap: () {
            Navigator.pop(context);
          }),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(15);
          },
          itemCount: 6,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 40),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return planWidget();
          }),
    );
  }

  planWidget() {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushNavigation(PayScreen(
          index: 0,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.lightAppColor,
            borderRadius: BorderRadius.circular(5)),
        padding:
            const EdgeInsets.only(left: 15, top: 17, right: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              children: [
                getText(
                    title: '\$499',
                    size: 25,
                    fontFamily: Constants.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.width(35),
                Container(
                  height: 40,
                  width: 1,
                  color: AppColor.hintTextColor,
                ),
                ScreenSize.width(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: 'Data :',
                        size: 12,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.hintTextColor,
                        fontWeight: FontWeight.w400),
                    getText(
                        title: '12 GB/day',
                        size: 14,
                        fontFamily: Constants.poppinsSemiBold,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: 'Validity :',
                        size: 12,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.hintTextColor,
                        fontWeight: FontWeight.w400),
                    getText(
                        title: '28 Days',
                        size: 14,
                        fontFamily: Constants.poppinsSemiBold,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(Images.planArrowIcon)
              ],
            ),
            ScreenSize.height(15),
            customDivider(0),
            ScreenSize.height(15),
            Row(
              children: [
                getText(
                    title: 'Sms :',
                    size: 12,
                    fontFamily: Constants.poppinsMedium,
                    color: AppColor.hintTextColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.width(7),
                getText(
                    title: '100/day',
                    size: 14,
                    fontFamily: Constants.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.width(23),
                getText(
                    title: 'Calls :',
                    size: 12,
                    fontFamily: Constants.poppinsMedium,
                    color: AppColor.hintTextColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.width(7),
                getText(
                    title: 'Unlimited Calls',
                    size: 14,
                    fontFamily: Constants.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w600),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/operator_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sliderWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: 'Utility Services',
                        size: 16,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(20),
                    typesWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  typesWidget() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  customTypesContainer(
                      AppColor.dataSubsriptionColor,
                      Images.dataSubscriptionIcon,
                      'Data Subscription',
                      150, () {
                    AppRoutes.pushNavigation(const OperatorScreen());
                  }),
                  ScreenSize.height(16),
                  customTypesContainer(AppColor.electricityColor,
                      Images.electricityIcon, 'Electricity Payment', 150, () {})
                ],
              ),
            ),
            ScreenSize.width(15),
            Expanded(
                child: customTypesContainer(AppColor.educationColor,
                    Images.educationIcon, 'Educational\nPayment', 320, () {}))
          ],
        ),
        ScreenSize.height(15),
        Row(
          children: [
            Expanded(
                child: customTypesContainer(AppColor.tvSubcriptionColor,
                    Images.tvSubscriptionIcon, 'TV Subscription', 150, () {})),
            ScreenSize.width(15),
            Expanded(
                child: customTypesContainer(AppColor.insuranceColor,
                    Images.insuranceIcon, 'Insurance\nPayment', 150, () {}))
          ],
        )
      ],
    );
  }

  customTypesContainer(
      Color color, String img, String title, double height, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(img),
            ScreenSize.height(16),
            getText(
              title: title,
              size: 16,
              fontFamily: Constants.poppinsMedium,
              color: AppColor.darkBlackColor,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

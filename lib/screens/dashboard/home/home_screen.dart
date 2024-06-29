import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
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
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          headerWidget(profileProvider),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderWidget(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: 'Utility Services',
                            size: 16,
                            fontFamily: Constants.poppinsSemiBold,
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
        ],
      ),
    );
  }

  headerWidget(ProfileProvider profileProvider) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(color: Color(0xff373B58)),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.whiteColor),
                        shape: BoxShape.circle),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/icons/dummy_girl.png')),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Image.asset(Images.menuIcon),
                    ),
                  )
                ],
              ),
              ScreenSize.width(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getText(
                      title: 'Welcome back',
                      size: 12,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w400),
                  getText(
                      title: profileProvider.model != null &&
                              profileProvider.model!.data != null
                          ? profileProvider.model!.data!.firstName
                          : '',
                      size: 16,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              )
            ],
          ),
        ],
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
                    AppRoutes.pushNavigation(const OperatorScreen(
                      title: 'Select Operator',
                      index: 0,
                    ));
                  }),
                  ScreenSize.height(16),
                  customTypesContainer(AppColor.electricityColor,
                      Images.electricityIcon, 'Electricity Payment', 150, () {
                    AppRoutes.pushNavigation(const OperatorScreen(
                      title: 'Choose Electricity Bill Operator',
                      index: 1,
                    ));
                  })
                ],
              ),
            ),
            ScreenSize.width(15),
            Expanded(
                child: customTypesContainer(AppColor.educationColor,
                    Images.educationIcon, 'Educational\nPayment', 320, () {
              AppRoutes.pushNavigation(const OperatorScreen(
                title: 'Choose Educational Bill Operator',
                index: 2,
              ));
            }))
          ],
        ),
        ScreenSize.height(15),
        Row(
          children: [
            Expanded(
                child: customTypesContainer(AppColor.tvSubcriptionColor,
                    Images.tvSubscriptionIcon, 'TV Subscription', 150, () {
              AppRoutes.pushNavigation(const OperatorScreen(
                title: 'Choose TV Subcription Operator',
                index: 3,
              ));
            })),
            ScreenSize.width(15),
            Expanded(
                child: customTypesContainer(AppColor.insuranceColor,
                    Images.insuranceIcon, 'Insurance\nPayment', 150, () {
              AppRoutes.pushNavigation(const OperatorScreen(
                title: 'Choose Insurance Bill Operator',
                index: 4,
              ));
            }))
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

  drawer() {}
}

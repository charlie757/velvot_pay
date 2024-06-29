import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

import '../../utils/constants.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final numberController = TextEditingController(text: '3292349089');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(title: 'Complete Profile'),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 230),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: profileWidget(),
                  ),
                  ScreenSize.height(30),
                  getText(
                      title: 'Name',
                      size: 16,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  CustomTextField(
                    hintText: 'Full Name',
                    textInputAction: TextInputAction.next,
                  ),
                  ScreenSize.height(30),
                  getText(
                      title: 'Email Address',
                      size: 16,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  CustomTextField(
                    hintText: 'Email Address',
                    textInputAction: TextInputAction.next,
                    suffixWidget: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Images.emailVerifyIcon,
                      ),
                    ),
                  ),
                  ScreenSize.height(30),
                  getText(
                      title: 'Mobile Number',
                      size: 16,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  CustomTextField(
                    hintText: 'Mobile Number',
                    isReadOnly: true,
                    fillColor: AppColor.hintTextColor,
                    controller: numberController,
                    textInputAction: TextInputAction.next,
                    textColor: AppColor.whiteColor,
                  ),
                  ScreenSize.height(30),
                  getText(
                      title: 'Address',
                      size: 16,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  addressTextField(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomImageButtonWidget(
                  onTap: () {
                    AppRoutes.pushNavigation(const DashboardScreen());
                  },
                  btnText: 'Continue'),
            )
          ],
        ));
  }

  profileWidget() {
    return Stack(
      children: [
        Container(
          height: 96,
          width: 96,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.darkBlackColor, width: 3),
              borderRadius: BorderRadius.circular(50)),
          child: Image.asset('assets/icons/Mask.png'),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColor.darkBlackColor, width: 2)),
            alignment: Alignment.center,
            child: Image.asset(
              Images.cameraIcon,
              height: 11,
              width: 11,
            ),
          ),
        )
      ],
    );
  }

  addressTextField() {
    return TextFormField(
      autofocus: false,
      maxLines: 4,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: AppColor.whiteColor,
          fontFamily: Constants.poppinsRegular),
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
        fillColor: AppColor.lightAppColor,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        hintText: 'Type here...',
        errorStyle: TextStyle(
          color: AppColor.redColor,
        ),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.hintTextColor,
            fontFamily: Constants.poppinsRegular),
      ),
    );
  }
}

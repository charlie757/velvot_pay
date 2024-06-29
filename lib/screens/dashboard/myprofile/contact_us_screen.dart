import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/util/constaints.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Contact Us",
          onTap: () {
            Navigator.pop(context);
          }),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 20, left: 20, right: 20, bottom: 220),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: 'Name',
                    size: 16,
                    fontFamily: Constaints.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(10),
                CustomTextField(
                  hintText: 'Full Name',
                  textInputAction: TextInputAction.next,
                ),
                ScreenSize.height(20),
                getText(
                    title: 'Email Address',
                    size: 16,
                    fontFamily: Constaints.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(10),
                CustomTextField(
                  hintText: 'Email Address',
                  textInputAction: TextInputAction.next,
                ),
                ScreenSize.height(20),
                getText(
                    title: 'Mobile Number',
                    size: 16,
                    fontFamily: Constaints.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(10),
                CustomTextField(
                  hintText: 'Mobile Number',
                  textInputAction: TextInputAction.next,
                ),
                ScreenSize.height(20),
                getText(
                    title: 'How May help You?',
                    size: 16,
                    fontFamily: Constaints.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(10),
                CustomTextField(
                  hintText: 'Choose an option',
                  isReadOnly: true,
                  textInputAction: TextInputAction.next,
                  suffixWidget: Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(Images.arrowDownIcon)),
                ),
                ScreenSize.height(20),
                getText(
                    title: 'Write more about your concern',
                    size: 16,
                    fontFamily: Constaints.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(10),
                commentBox(),
                ScreenSize.height(20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomImageButtonWidget(onTap: () {}, btnText: 'Submit Now'),
          )
        ],
      ),
    );
  }

  commentBox() {
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

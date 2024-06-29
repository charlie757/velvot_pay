import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

import '../../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  final String route;
  final String number;
  const ProfileScreen({required this.route, this.number = ''});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.numberController.text = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: widget.route == 'initial' ? 'Complete Profile' : "Profile",
          isShowArrow: widget.route == 'initial' ? true : false,
          onTap: () {
            Navigator.pop(context);
          }),
      body: Consumer<ProfileProvider>(builder: (context, myProvider, child) {
        return Form(
          key: myProvider.formKey,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
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
                  controller: myProvider.nameController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your name";
                    }
                  },
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
                  controller: myProvider.emailController,
                  validator: (val) {
                    RegExp regExp = RegExp(Utils.emailPattern.trim());

                    if (val.isEmpty) {
                      return "Enter your email";
                    } else if (!regExp.hasMatch(val)) {
                      return "Email should be valid";
                    }
                  },
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
                  controller: myProvider.numberController,
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
                addressTextField(myProvider),
                ScreenSize.height(20),
                CustomBtn(
                    title: widget.route == 'initial' ? "Continue" : 'Save',
                    onTap: () {
                      myProvider.checkValidation();
                    })
              ],
            ),
          ),
        );
      }),
    );
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

  addressTextField(ProfileProvider provider) {
    return TextFormField(
      autofocus: false,
      maxLines: 4,
      controller: provider.addressController,
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
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your address";
        }
      },
    );
  }
}

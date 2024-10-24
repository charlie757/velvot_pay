import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../helper/app_color.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/network_image_helper.dart';
import '../../../helper/screen_size.dart';
import '../../../provider/profile_provider.dart';
import '../../../utils/Constants.dart';
import '../../../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<ProfileProvider>(context,listen: false);
    provider.setProfileValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context,myProvider,child){
      return  Scaffold(
        backgroundColor: AppColor.whiteF7Color,
        appBar: appBar(title: "Edit Profile",backgroundColor: AppColor.whiteF7Color),
        body: Form(
          key: myProvider.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20,left: 16,right: 16,bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileWidget(myProvider),
                ScreenSize.height(32),
                getText(
                    title: 'First Name',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  isReadOnly: myProvider.isLoading,
                  hintText: 'First Name',
                  inputFormatters: [ FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))],
                  textInputAction: TextInputAction.next,
                  controller: myProvider.firstNameController,
                  fillColor: AppColor.whiteColor,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your first name";
                    }
                  },
                ),
                ScreenSize.height(26),
                getText(
                    title: 'Last Name',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  isReadOnly: myProvider.isLoading,
                  hintText: 'Last Name',
                  inputFormatters: [ FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))],
                  textInputAction: TextInputAction.next,
                  fillColor: AppColor.whiteColor,
                  controller: myProvider.lastNameController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your last name";
                    }
                  },
                ),
                ScreenSize.height(26),
                getText(
                    title: 'Email Address',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  isReadOnly: true,
                  hintText: 'Email Address',
                  textInputAction: TextInputAction.next,
                  controller: myProvider.emailController,
                  fillColor: AppColor.whiteColor,
                  inputFormatters: [ FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))],
                  validator: (val) {
                    // RegExp regExp = RegExp(Utils.emailPattern.trim());
                    // if (val.isEmpty) {
                    //   return "Enter your email";
                    // } else if (!regExp.hasMatch(val)) {
                    //   return "Email should be valid";
                    // }
                  },
                ),
                ScreenSize.height(26),
                getText(
                    title: 'Phone Number',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  hintText: 'Mobile Number',
                  isReadOnly: true,
                  controller: myProvider.numberController,
                  textInputAction: TextInputAction.next,
                  fillColor: const Color(0xffF4F4F5),
                  prefixWidget: Container(
                    width: 100,
                    padding:const EdgeInsets.only(left: 13),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.flag),
                        ScreenSize.width(4),
                        getText(title: "+234",
                            size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                            color: const Color(0xffA0A0AB), fontWeight: FontWeight.w500),
                        Icon(Icons.keyboard_arrow_down_outlined,color: const Color(0xff70707B).withOpacity(.5),)
                      ],
                    ),
                  ),
                ),
                ScreenSize.height(26),
                getText(
                    title: 'Address',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  hintText: 'Address',
                  isReadOnly: myProvider.isLoading,
                  controller: myProvider.addressController,
                  textInputAction: TextInputAction.done,
                  fillColor: AppColor.whiteColor,
                  // validator: (val) {
                  //   if (val.isEmpty) {
                  //     return "Enter your address";
                  //   }
                  // },
                ),
                ScreenSize.height(40),
                CustomBtn(title: 'Save Changes', onTap: (){
                  myProvider.checkValidation();
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
  profileWidget(ProfileProvider provider) {
    return   Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            height: 98,
            width: 98,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: provider.file != null
                    ? Image.file(
                  File(provider.file!.path),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
                    : provider.model != null && provider.model!.data != null
                    ? NetworkImagehelper(
                  img: provider.model!.data!.imageUrl,
                  height: 98.0,
                  width: 98.0,
                )
                    : Image.asset('assets/icons/Mask.png')),
          ),
          Positioned(
            bottom: 0+11,
            right: 0,
            child: GestureDetector(
              onTap: () {
                imagePickerBottomSheet(provider);
              },
              child: SvgPicture.asset(
                Images.cameraBgSvg,
              ),
            ),
          )
        ],
      ),
    );
  }

  imagePickerBottomSheet(ProfileProvider profileProvider) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColor.whiteColor,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(
                        title: 'Profile Photo',
                        size: 17,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close))
                  ],
                ),
                ScreenSize.height(25),
                Row(
                  children: [
                    imagePickType(Icons.camera_alt_outlined, "Camera", () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.camera);
                    }),
                    ScreenSize.width(30),
                    imagePickType(Icons.image_outlined, "Gallery", () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.gallery);
                    }),
                  ],
                )
              ],
            ),
          );
        });
  }

  imagePickType(icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColor.lightAppColor,
            ),
          ),
          ScreenSize.height(5),
          getText(
              title: title,
              size: 14,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }


}

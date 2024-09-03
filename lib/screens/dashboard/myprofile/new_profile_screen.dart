import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/screens/dashboard/home/home_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/edit_profile_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/id_verification_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/pages_screen.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../apiconfig/api_url.dart';
import '../../../helper/app_color.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/network_image_helper.dart';
import '../../../helper/screen_size.dart';
import '../../../provider/profile_provider.dart';
import '../../../utils/Constants.dart';
import 'contact_us_screen.dart';
import 'faq_screen.dart';

class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    callApiFunction();
    super.initState();
  }

  callApiFunction()async{
    final provider = Provider.of<ProfileProvider>(context,listen: false);
    provider.getProfileApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    print(Constants.is401Error);
    return Scaffold(
      backgroundColor: AppColor.whiteF7Color,
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context,myProvider,child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 30,top: 50),
              child: Column(
                children: [
                  profileWidget(myProvider),
                  ScreenSize.height(32),
                  profileMenuWidget(),
                  ScreenSize.height(24),
                  policiesWidget(),
                  ScreenSize.height(24),
                  deleteAccountWidget(),
                  ScreenSize.height(24),
                  logoutWidget()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
  profileWidget(ProfileProvider provider) {
    return Column(
      children: [
        Stack(
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
                  ) : SvgPicture.asset(Images.profileIcon)),
            ),

          ],
        ),
        ScreenSize.height(8),
        getText(
            title: provider.model != null &&
                provider.model!.data != null
                ? "${provider.model!.data!.firstName.toString().isNotEmpty?provider.model!.data!.firstName.toString().capitalize():''} ${provider.model!.data!.lastName.toString().isNotEmpty?
            provider.model!.data!.lastName:''}"
                : '',
            size: 18,
            fontFamily: Constants.galanoGrotesqueMedium,
            color:const Color(0xff080B30),
            fontWeight: FontWeight.w600,textAlign: TextAlign.center,),

      ],
    );
  }

  profileMenuWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding:const EdgeInsets.only(left: 8,right: 8,top: 22,bottom: 8),
      child: Column(
        children: [
          menuWidget(Images.profileIcon, 'Edit Profile',(){
            AppRoutes.pushNavigation(const EditProfileScreen());
          }),
          ScreenSize.height(5),
         const Divider(color: Color(0xffF4F4F5),),
          ScreenSize.height(16),
          menuWidget(Images.verifySvg, 'ID verification',(){
            AppRoutes.pushNavigation(const IdVerificationScreen());
          }),
          ScreenSize.height(5),
          const Divider(color: Color(0xffF4F4F5),),
        ],
      ),
    );
  }

  policiesWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding:const EdgeInsets.only(left: 8,right: 8,top: 22,bottom: 14),
      child: Column(
        children: [
          menuWidget(Images.faqIcon, 'FAQ',(){
            AppRoutes.pushNavigation(const FaqScreen());
          }),
          ScreenSize.height(5),
          const Divider(color: Color(0xffF4F4F5),),
          ScreenSize.height(16),
          menuWidget(Images.faqIcon, 'Privacy Policy',(){
            AppRoutes.pushNavigation(PagesScreen(title: 'Privacy Policy',url: ApiUrl.privacyUrl,));
          }),
          ScreenSize.height(5),
          const Divider(color: Color(0xffF4F4F5),),
          ScreenSize.height(16),
          menuWidget(Images.faqIcon, 'About Us',(){
            AppRoutes.pushNavigation( PagesScreen(title: 'About Us',url: ApiUrl.aboutUsUrl,));
          }),
          ScreenSize.height(5),
          const Divider(color: Color(0xffF4F4F5),),
          ScreenSize.height(16),
          menuWidget(Images.contactSupport, 'Contact Support',(){
            AppRoutes.pushNavigation(ContactUsScreen(
              email: Provider.of<ProfileProvider>(context, listen: false)
                  .model!
                  .data!
                  .email,
              number: Provider.of<ProfileProvider>(context, listen: false)
                  .model!
                  .data!
                  .mobileNumber,
              name: Provider.of<ProfileProvider>(context, listen: false)
                  .model!
                  .data!
                  .firstName,
            ));
          }),
        ],
      ),
    );
  }

  deleteAccountWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding:const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
      child: menuWidget(Images.deleteAccount, 'Delete account',(){
        openBottomSheet('delete');
      }),
    );
  }

  logoutWidget(){
    return GestureDetector(
      onTap: (){
        openBottomSheet('logout');
      },
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.whiteColor,
          border: Border.all(color: const Color(0xffE4E4E7))
        ),
        child: getText(title: 'Log Out',
            size: 16, fontFamily: Constants.galanoGrotesqueMedium,
            color:const Color(0xffF03030), fontWeight: FontWeight.w500),
      ),
    );
  }

  menuWidget(String img, String title, Function()?onTap){
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(img,height: 20,width: 20,),
          ScreenSize.width(8),
          Expanded(
            child: getText(title: title,
                size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: AppColor.grayIronColor, fontWeight: FontWeight.w400),
          ),
          ScreenSize.width(4),
          SvgPicture.asset(Images.keyboardArrowRightIcon,)
        ],
      ),
    );
  }

  openBottomSheet(String route){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape:const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8),
          )
        ),
        context: context,
        builder: (context){
      return Container(
        padding:const EdgeInsets.only(top: 25,bottom: 20,left: 16,right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Images.logout),
            ScreenSize.height(17),
            getText(title:route=='delete'?"Delete Account?": 'Log Out?', size: 24, fontFamily: Constants.galanoGrotesqueSemiBold, color: AppColor.grayIronColor,
                fontWeight: FontWeight.w700),
            ScreenSize.height(8),
            getText(title:route=='delete'?"Action cannot be reversed, do you want to permanently delete your velvot account?":
            'You are about to logout of your account',
                textAlign: TextAlign.center,
                size: 14, fontFamily: Constants.galanoGrotesqueRegular, color:const Color(0xff51525C), fontWeight: FontWeight.w400),
            ScreenSize.height(32),
            Row(
              children: [
                Expanded(child: CustomBtn(title: 'Go back', onTap: (){
                  Navigator.pop(context);
                })),
                ScreenSize.width(8),
                Expanded(child: CustomBtn(title:route=='delete'?"Yes, Delete": 'Yes, Log Out',
                    btnColor: AppColor.lightRedColor,
                    onTap: (){
                      route=='delete'?
                          Provider.of<ProfileProvider>(context,listen: false).deleteAccountApiFunction():
                  Utils.logOut();
                    })),
              ],
            )
          ],
        ),
      );
        });
  }

}

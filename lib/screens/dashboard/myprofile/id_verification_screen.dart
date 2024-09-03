import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
import 'package:velvot_pay/screens/auth/signup/set_transaction_pin_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/add_email_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/edit_profile_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../helper/images.dart';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          backgroundColor: AppColor.whiteF7Color,
          appBar: appBar(title: "Become a Verified User",backgroundColor: AppColor.whiteF7Color,),
          body: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(title: 'To get the best experience from the app, verify your account',
                    size: 14, fontFamily: Constants.galanoGrotesqueRegular,
                    color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                ScreenSize.height(32),
                verificationTypes('Verify your Phone Number',
                    'Receiver OTP sent to your registered phone number to verify',0,
                    'Done'
                ),
                ScreenSize.height(16),
                verificationTypes('Secure your wallet',
                    'Create a transaction pin',1,
                    myProvider.model!=null&&myProvider.model!.data!=null&&
                    myProvider.model!.data!.isPinSetup?"Done": 'Create Pin'
                ),
                ScreenSize.height(16),
                verificationTypes('Add Email Address',
                    'Receiver OTP sent to your registered phone number to verify',2,
                    myProvider.model!=null&&myProvider.model!.data!=null&&
                    myProvider.model!.data!.isOtpEmail?'Done':  'Verify'
                ),
                ScreenSize.height(16),
                verificationTypes('Add Personal details',
                    'Receiver OTP sent to your registered phone number to verify',3,
                    myProvider.model!=null&&myProvider.model!.data!=null&&
                        myProvider.model!.data!.isCompleteProfile?'Done':  'Verify'
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  verificationTypes(String title, String des, int index, String btnTitle){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(title:title,
                    size: 16, fontFamily: Constants.galanoGrotesqueMedium,
                    color: const Color(0xff1A1A1E), fontWeight: FontWeight.w500),
                ScreenSize.height(4),
                getText(title: des,
                    size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                    color: const Color(0xff70707B), fontWeight: FontWeight.w400)
              ],
            ),
          ),
          ScreenSize.width(4),
          btnTitle=='Done'?
          doneBtn():nonVerifyBtn(btnTitle,index)
        ],
      ),
    );
  }

  doneBtn(){
    return  Container(
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff0A930A)
      ),
      padding:const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Row(
        children: [
          getText(title: 'Done',
              size: 12, fontFamily: Constants.galanoGrotesqueRegular,
              color: AppColor.whiteF7Color, fontWeight: FontWeight.w700),
          ScreenSize.width(8),
          SvgPicture.asset(Images.checkSvg)
        ],
      ),
    );
  }

  nonVerifyBtn(String title,int index){
    return  GestureDetector(
      onTap: (){
        if(index==0){
        }else if(index==1){
          AppRoutes.pushNavigation(const SetTransactionPinScreen());
        }
        else if(index==2){
          AppRoutes.pushNavigation(const AddEmailScreen()).then((value) {
            Provider.of<ProfileProvider>(context,listen: false).getProfileApiFunction();
          });
        }
        else if(index==3){
          AppRoutes.pushNavigation(const EditProfileScreen());
        }
      },
      child: Container(
        height: 38,
        // height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.appColor.withOpacity(.1)
        ),
        padding:const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: getText(title: title,
            size: 12, fontFamily: Constants.galanoGrotesqueRegular,
            color: AppColor.appColor, fontWeight: FontWeight.w700),
      ),
    );
  }
}

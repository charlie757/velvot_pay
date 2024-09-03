import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/auth/signup/verify_phone_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/progess_indicator.dart';

import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/images.dart';
import '../../../provider/singup_provider.dart';
import '../../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context,myProvider, child) {
        return Scaffold(
          body: SafeArea(child:
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 16,right: 16),
            child: Form(
              key: formKey,
              child: Column(
               children: [
                 progressIndicator(1),
                 ScreenSize.height(14),
                 Expanded(child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                       },
                       child: SvgPicture.asset(Images.arrowBackImage),
                     ),
                     ScreenSize.height(32),
                     getText(title: 'Let’s Get You Started!',
                         size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                         fontWeight: FontWeight.w700),
                     ScreenSize.height(7),
                     getText(title: 'Create your fresh account in few minutes',
                         size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff51525C),
                         fontWeight: FontWeight.w400),
                     ScreenSize.height(32),
                     getText(
                         title: 'Phone Number',
                         size: 14,
                         fontFamily: Constants.galanoGrotesqueMedium,
                         color: AppColor.grayIronColor,
                         fontWeight: FontWeight.w500),
                     ScreenSize.height(8),
                     CustomTextField(
                       hintText: 'Mobile Number',
                       controller: phoneController,
                       textInputAction: TextInputAction.done,
                       textInputType: Platform.isAndroid? TextInputType.number:const TextInputType.numberWithOptions(signed: true, decimal: true),
                       isReadOnly: myProvider.isLoading,
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
                       inputFormatters: [
                         FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
                         FilteringTextInputFormatter.digitsOnly,
                         LengthLimitingTextInputFormatter(10)
                       ],
                         validator: (val) {
                           if (val.isEmpty) {
                             return "Enter your number";
                           } else if (val.length < 10) {
                             return 'Number should be valid';
                           }
                         },
                     ),
                   ],
                 ),)
               ],
         ),
            ),
          )),
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomBtn(
                      title: "Create New Account",
                      isLoading: myProvider.isLoading,
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          myProvider.isLoading?null:
                         myProvider.registerApiFunction(phoneController.text);
                        }
                      }),
                  ScreenSize.height(16),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getText(title: 'I already have an account',
                            size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                            color: AppColor.appColor, fontWeight: FontWeight.w500),
                        ScreenSize.width(6),
                        SvgPicture.asset(Images.arrowForwardIcon),
                      ],
                    ),
                  )
                ],
              )
          ),

        );
      }
    );
  }
}

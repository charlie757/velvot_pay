import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/login_provider.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/utils/emoji_restrict.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<LoginProvider>(context,listen: false);
    provider.resetValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, myProvider, child) {
      return WillPopScope(
        onWillPop: ()async{
          exit(0);
        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 185,
                          alignment: Alignment.center,
                          child: Image.asset(Images.appHorizontalLogo)),
                    ),
                    ScreenSize.height(61),
                    getText(
                        title: 'Enter Your Mobile Number',
                        size: 16,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w500),
                    ScreenSize.height(10),
                    CustomTextField(
                      hintText: 'Mobile Number',
                      controller: myProvider.phoneController,
                      textInputAction: TextInputAction.done,
                      textInputType: Platform.isAndroid? TextInputType.number:const TextInputType.numberWithOptions(signed: true, decimal: true),
                      isReadOnly: myProvider.isLoading,
                      inputFormatters: [
                        EmojiRestrictingTextInputFormatter(),
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
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: CustomBtn(
                title: "Proceed",
                isLoading: myProvider.isLoading,
                onTap: () {
                  myProvider.checkValidation(formKey);
                }),
          ),
        ),
      );
    });
  }
}

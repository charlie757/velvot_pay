import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/provider/add_email_provider.dart';

import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/screen_size.dart';
import '../../../provider/profile_provider.dart';
import '../../../utils/Constants.dart';
import '../../../utils/utils.dart';

class AddEmailScreen extends StatefulWidget {
  const AddEmailScreen({super.key});

  @override
  State<AddEmailScreen> createState() => _AddEmailScreenState();
}

class _AddEmailScreenState extends State<AddEmailScreen> {

  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<ProfileProvider>(context,listen: false);
    provider.emailController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context,myProvider, child) {
        return Scaffold(
          body: SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,left: 16,right: 16),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(Images.arrowBackImage),
                ),
                ScreenSize.height(32),
                getText(title: 'Add Email Address',
                    size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w700),
                ScreenSize.height(7),
                getText(title: 'Enter the Email Address you to personalize your account',
                    size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff51525C),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(32),
                getText(
                    title: 'Email Address',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(8),
                CustomTextField(
                  isReadOnly: myProvider.isLoading,
                  hintText: 'Enter Email Address',
                  textInputAction: TextInputAction.done,
                  controller: myProvider.emailController,
                  // fillColor: AppColor.whiteColor,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),],
                  validator: (val) {
                    RegExp regExp = RegExp(Utils.emailPattern.trim());

                    if (val.isEmpty) {
                      return "Enter your email";
                    } else if (!regExp.hasMatch(val)) {
                      return "Email should be valid";
                    }
                  },
                ),

            ],
          ),
                ),
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
            child: CustomBtn(
                title: "Continue",
                isLoading: myProvider.isLoading,
                onTap: () {
                  if(formKey.currentState!.validate()){
                    myProvider.isLoading?null:
                    myProvider.updateProfileApiFunction('addEmail');
                  }
                  // AppRoutes.pushNavigation(const PersonalDetailsScreen());
                }),
          ),
        );
      }
    );
  }
}

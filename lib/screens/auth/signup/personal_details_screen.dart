import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/provider/singup_provider.dart';
import 'package:velvot_pay/screens/auth/signup/verify_email_screen.dart';

import '../../../approutes/app_routes.dart';
import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/screen_size.dart';
import '../../../utils/Constants.dart';
import '../../../utils/utils.dart';
import '../../../widget/progess_indicator.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,left: 16,right: 16,),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    progressIndicator(4),
                    ScreenSize.height(2),
                    Expanded(child: SingleChildScrollView(
                      padding:const EdgeInsets.only(top: 32,bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getText(title: 'Add personal Details',
                              size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                              fontWeight: FontWeight.w700),
                          ScreenSize.height(7),
                          getText(title: 'Personalize your account with your necessary details',
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
                            hintText: 'Email Address',
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            fillColor: AppColor.whiteColor,
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
                          ScreenSize.height(24),
                          getText(
                              title: 'First Name',
                              size: 14,
                              fontFamily: Constants.galanoGrotesqueMedium,
                              color: AppColor.grayIronColor,
                              fontWeight: FontWeight.w500),
                          ScreenSize.height(8),
                          CustomTextField(
                            isReadOnly: myProvider.isLoading,
                            hintText: 'Enter First Name',
                            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),],
                            textInputAction: TextInputAction.next,
                            controller: firstNameController,
                            fillColor: AppColor.whiteColor,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter your first name";
                              }
                            },
                          ),
                          ScreenSize.height(24),
                          getText(
                              title: 'Last Name',
                              size: 14,
                              fontFamily: Constants.galanoGrotesqueMedium,
                              color: AppColor.grayIronColor,
                              fontWeight: FontWeight.w500),
                          ScreenSize.height(8),
                          CustomTextField(
                            isReadOnly: myProvider.isLoading,
                            hintText: 'Enter Last Name',
                            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),],
                            textInputAction: TextInputAction.next,
                            controller: lastNameController,
                            fillColor: AppColor.whiteColor,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter your last name";
                              }
                            },
                          ),
                          ScreenSize.height(24),
                          getText(
                              title: 'Address (optional)',
                              size: 14,
                              fontFamily: Constants.galanoGrotesqueMedium,
                              color: AppColor.grayIronColor,
                              fontWeight: FontWeight.w500),
                          ScreenSize.height(8),
                          CustomTextField(
                            hintText: 'Address',
                            isReadOnly: myProvider.isLoading,
                            controller: addressController,
                            textInputAction: TextInputAction.done,
                            fillColor: AppColor.whiteColor,
                            // validator: (val) {
                            //   if (val.isEmpty) {
                            //     return "Enter your address";
                            //   }
                            // },
                          ),

                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
                child: CustomBtn(
                    title: "Next",
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      if(formKey.currentState!.validate()){
                        myProvider.isLoading?null:
                        myProvider.updateProfileApiFunction(firstNameController.text, lastNameController.text,
                            emailController.text, addressController.text);
                      }
                      // AppRoutes.pushNavigation(const VerifyEmailScreen());
                    }),
              )

        );
      }
    );
  }
}

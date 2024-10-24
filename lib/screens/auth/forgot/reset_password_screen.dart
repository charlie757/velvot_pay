import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/provider/forgot_provider.dart';
import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/getText.dart';
import '../../../helper/screen_size.dart';
import '../../../utils/Constants.dart';
import '../../../utils/utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
            body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,left: 16,right: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(title: 'Reset Password',
                            size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                            fontWeight: FontWeight.w700),
                        ScreenSize.height(7),
                        getText(title: 'Protect your account with a strong password',
                            size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff51525C),
                            fontWeight: FontWeight.w400),
                        ScreenSize.height(32),
                        getText(
                            title: 'New Password',
                            size: 14,
                            fontFamily: Constants.galanoGrotesqueMedium,
                            color: AppColor.grayIronColor,
                            fontWeight: FontWeight.w500),
                        ScreenSize.height(8),
                        CustomTextField(
                          hintText: 'Enter new password',
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          isObscureText: myProvider.isPasswordVisible,
                          isReadOnly: myProvider.isLoading,
                          suffixWidget: GestureDetector(
                            onTap: (){
                              myProvider.isPasswordVisible = !myProvider.isPasswordVisible;
                              setState(() {
                              });
                            },
                            child: SizedBox(
                              width: 40,
                              child: Icon(
                                !myProvider.isPasswordVisible?
                                Icons.visibility_outlined:Icons.visibility_off_outlined ,color:const Color(0xff70707B).withOpacity(.6),),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
                          ],
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter your password";
                            } else if (!Utils.passwordValidateRegExp(val)) {
                              return 'The password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                            }
                          },
                        ),
                        ScreenSize.height(24),
                        getText(
                            title: 'Confirm Password',
                            size: 14,
                            fontFamily: Constants.galanoGrotesqueMedium,
                            color: AppColor.grayIronColor,
                            fontWeight: FontWeight.w500),
                        ScreenSize.height(8),
                        CustomTextField(
                          hintText: 'Enter confirm password',
                          controller: confirmPasswordController,
                          textInputAction: TextInputAction.done,
                          isObscureText: myProvider.isConfirmPasswordVisible,
                          isReadOnly: myProvider.isLoading,
                          suffixWidget: GestureDetector(
                            onTap: (){
                              myProvider.isConfirmPasswordVisible = !myProvider.isConfirmPasswordVisible;
                              setState(() {
                              });
                            },
                            child: SizedBox(
                              width: 40,
                              child: Icon(
                                !myProvider.isConfirmPasswordVisible?
                                Icons.visibility_outlined:Icons.visibility_off_outlined ,color:const Color(0xff70707B).withOpacity(.6),),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
                          ],
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter your password";
                            } else if (!Utils.passwordValidateRegExp(val)) {
                              return 'The password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                            }
                            else if(passwordController.text!=confirmPasswordController.text){
                              return "Password does not match";
                            }
                          },
                        ),
                      ],
                    )
                  ),
                )),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
              child: CustomBtn(
                  title: "Reset Password",
                  isLoading: myProvider.isLoading,
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      myProvider.isLoading?null:
                      myProvider.resetPasswordApiFunction(confirmPasswordController.text);
                    }
                  }),
            )
        );
      }
    );
  }
}

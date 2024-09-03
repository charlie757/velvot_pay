import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/provider/onboarding_provider.dart';
import 'package:velvot_pay/screens/auth/login_screen.dart';
import 'package:velvot_pay/screens/auth/signup/signup_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/dot_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          backgroundColor: AppColor.darkBlueColor,
          body: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: myProvider.list.length,
                itemBuilder: (context,int itemIndex,int pageViewIndex){
                  return Image.asset(myProvider.list[itemIndex]['img'],fit: BoxFit.cover,height: double.infinity,
                    width: double.infinity,);
                },
                options: CarouselOptions(
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: 1.0,
                    height: double.infinity,
                    initialPage: 0,
                    autoPlayCurve: Curves.ease,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 400),
                    autoPlayInterval: const Duration(seconds: 4),
                    onPageChanged: (val, _) {
                      myProvider.updateIndex(val);
                    }),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.darkBlueColor,
                    borderRadius:const BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)
                    )
                  ),
                  padding:const EdgeInsets.only(left: 16,right: 16,bottom: 25,top: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getText(title: myProvider.list[myProvider.currentIndex]['title'],
                          size: 30, fontFamily: Constants.galanoGrotesqueMedium,
                          color: AppColor.whiteColor, fontWeight: FontWeight.w700,textAlign: TextAlign.center,),
                      ScreenSize.height(16),
                      getText(title: myProvider.list[myProvider.currentIndex]['des'],
                        size: 14, fontFamily: Constants.galanoGrotesqueRegular,
                        color: AppColor.whiteColor, fontWeight: FontWeight.w400,textAlign: TextAlign.center,),
                      ScreenSize.height(30),
                      DotsIndicator(dotsCount: myProvider.list.length,
                          activeDotIndex: myProvider.currentIndex,
                      ),
                      ScreenSize.height(40),
                      CustomBtn(title: 'Create Account', onTap: (){
                        SessionManager.setIsFirstTime=true;
                        setState(() {

                        });
                        AppRoutes.pushNavigation(const SignUpScreen());
                      }),
                      ScreenSize.height(16),
                      GestureDetector(
                        onTap: (){
                          SessionManager.setIsFirstTime=true;
                          setState(() {
                          });
                          AppRoutes.pushRemoveReplacementNavigation(const LoginScreen());
                          },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          child: getText(title: 'I already have an account',
                              size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                              color: AppColor.whiteColor, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),

              )
            ],
          ),
        );
      }
    );
  }

  dotsWidget(){

  }

}

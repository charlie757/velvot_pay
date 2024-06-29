import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        body: myProvider.screenList[myProvider.currentIndex],
        bottomNavigationBar: Container(
          height: 200,
          //  myProvider.currentIndex == 1 ? 0 : 200,
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              SvgPicture.asset(
                Images.bottomImage,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 79,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColor.darkBlackColor),
                    padding: const EdgeInsets.only(left: 29, right: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottomColumnWidget(Images.historyIcon, 'History', () {
                          myProvider.updateIndex(0);
                        }),
                        bottomColumnWidget(Images.profileIcon, 'My Profile',
                            () {
                          myProvider.updateIndex(2);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: centerHomeWidget(myProvider),
              )
            ],
          ),
        ),
      );
    });
  }

  centerHomeWidget(DashboardProvider provider) {
    return InkWell(
      onTap: () {
        provider.updateIndex(1);
      },
      child: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                  color: AppColor.blackColor.withOpacity(.1),
                  offset: const Offset(0, -2),
                  blurRadius: 10)
            ]),
        alignment: Alignment.center,
        child: Container(
          height: 58,
          width: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.purpleColor,
              borderRadius: BorderRadius.circular(30)),
          child: Image.asset(
            Images.homeIcon,
            height: 45,
            width: 21,
          ),
        ),
      ),
    );
  }

  bottomColumnWidget(String img, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 24,
            width: 24,
          ),
          ScreenSize.height(5),
          getText(
              title: title,
              size: 16,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.whiteColor.withOpacity(.9),
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}

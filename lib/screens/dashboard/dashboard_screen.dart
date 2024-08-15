import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen();

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    callIniFunction();
    super.initState();
  }

  callIniFunction() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.resetValues();
    profileProvider.resetValues();
    profileProvider.model = null;
    Future.delayed(Duration.zero, () {
      profileProvider.getProfileApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return WillPopScope(
        onWillPop: myProvider.onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              myProvider.screenList[myProvider.currentIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 90,
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 79,
                          width: double.infinity,
                          decoration:
                              BoxDecoration(color: AppColor.darkBlackColor),
                          padding: const EdgeInsets.only(left: 29, right: 29),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myProvider.currentIndex == 0
                                  ? const Spacer()
                                  : Container(),
                              myProvider.currentIndex != 0
                                  ? bottomColumnWidget(
                                      Images.historyIcon, 'History', () {
                                      myProvider.updateIndex(0);
                                    })
                                  : Flexible(
                                      child: Container(
                                      width: 0,
                                    )),
                              const Spacer(),
                              myProvider.currentIndex != 1
                                  ? bottomColumnWidget(Images.homeIcon, 'Home',
                                      () {
                                      myProvider.updateIndex(1);
                                    })
                                  : Container(),
                              const Spacer(),
                              myProvider.currentIndex != 2
                                  ? bottomColumnWidget(
                                      Images.profileIcon, 'My Profile', () {
                                      myProvider.updateIndex(2);
                                    })
                                  : Container(),
                              myProvider.currentIndex == 2
                                  ? const Spacer()
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 20,
                            left: myProvider.currentIndex == 1
                                ? 0
                                : myProvider.currentIndex == 0
                                    ? 20
                                    : 0,
                            right: myProvider.currentIndex == 2 ? 20 : 0),
                        alignment: myProvider.currentIndex == 1
                            ? Alignment.center
                            : myProvider.currentIndex == 0
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: myProvider.currentIndex == 1
                            ? centerBottomWidget(myProvider, Images.homeIcon, 1)
                            : myProvider.currentIndex == 2
                                ? centerBottomWidget(
                                    myProvider, Images.profileIcon, 2)
                                : centerBottomWidget(
                                    myProvider, Images.historyIcon, 0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  centerBottomWidget(DashboardProvider provider, String img, int index) {
    return InkWell(
      onTap: () {
        provider.updateIndex(index);
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
            img,
            height: 21,
            width: 21,
          ),
        ),
      ),
    );
  }

  bottomColumnWidget(String img, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
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
      ),
    );
  }
}

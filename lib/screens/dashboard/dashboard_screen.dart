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
          body: myProvider.screenList[myProvider.currentIndex],
          bottomNavigationBar: Container(
            height: 74,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  offset:const Offset(0, -1),
                  color: AppColor.blackColor.withOpacity(.1),
                  blurRadius: 2
                )
              ]
            ),
            child: Row(
              
              children: [
                bottomColumnWidget(myProvider.currentIndex==0? Images.homeColorIcon:Images.homeIcon, "Home",0,),
                bottomColumnWidget(myProvider.currentIndex==1?Images.transcationColorIcon: Images.transcationIcon , "Transactions",1,),
                bottomColumnWidget(myProvider.currentIndex==2?Images.profileColorIcon: Images.profileIcon, "Profile",2,),
              ],
            )
          ),
        ),
      );
    });
  }

  bottomColumnWidget(String img, String title,int index,) {
    return Expanded(
      child: InkWell(
        onTap: (){
          Provider.of<DashboardProvider>(context,listen: false).updateIndex(index);
        },
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                img,
                height: 24,
                width: 24,
              ),
              ScreenSize.height(5),
              getText(
                  title: title,
                  size: 12,
                  fontFamily: Constants.galanoGrotesqueSemiBold,
                  color: Provider.of<DashboardProvider>(context,listen: false).currentIndex==index?
                  AppColor.appColor:
                  AppColor.lightGrayColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
        ),
      ),
    );
  }
}

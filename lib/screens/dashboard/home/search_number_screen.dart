import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/choose_plan_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';

class SearchNumberScreen extends StatefulWidget {
  const SearchNumberScreen({super.key});

  @override
  State<SearchNumberScreen> createState() => _SearchNumberScreenState();
}

class _SearchNumberScreenState extends State<SearchNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [customSearchBarWidget(), searchResultWidget()],
          ),
        ),
      ),
    );
  }

  searchResultWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: 'Search Results',
              size: 16,
              fontFamily: Constants.poppinsSemiBold,
              color: AppColor.darkBlackColor,
              fontWeight: FontWeight.w600),
          ScreenSize.height(20),
          GestureDetector(
            onTap: () {
              AppRoutes.pushNavigation(const ChoosePlanScreen());
            },
            child: Container(
              color: AppColor.whiteColor,
              child: Row(
                children: [
                  Container(
                    height: 47,
                    width: 47,
                    decoration: BoxDecoration(
                        color: Color(0xff181D3D),
                        border: Border.all(color: AppColor.e1Color),
                        borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.center,
                    child: getText(
                        title: '98',
                        size: 18,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                  ScreenSize.width(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '9876543210',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Constants.poppinsMedium,
                              color: AppColor.darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        ScreenSize.height(5),
                        getText(
                            title: 'Tap to recharge this number',
                            size: 14,
                            fontFamily: Constants.poppinsMedium,
                            color: AppColor.purpleColor,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  customSearchBarWidget() {
    return Container(
      height: 58,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, right: 10),
      decoration: BoxDecoration(color: AppColor.lightAppColor),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Images.arrowBackImage)),
          ScreenSize.width(15),
          Expanded(
              child: TextFormField(
            style: TextStyle(
                color: AppColor.darkBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.poppinsMedium),
            decoration: const InputDecoration(border: InputBorder.none),
          ))
        ],
      ),
    );
  }
}

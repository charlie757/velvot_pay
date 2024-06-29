import 'package:flutter/material.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_divider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List historyList = [
    {
      'img': Images.airtelIcon,
      'title': 'Data Subscription',
      'sub': "Airtel Postpaid"
    },
    {
      'img': 'assets/icons/vidyat_icon.png',
      'title': 'Electricity Bill',
      'sub': "Ajmer Vidyut Vitaran Nigma Ltd"
    },
    {
      'img': Images.airtelIcon,
      'title': 'Data Subscription',
      'sub': "Airtel Postpaid"
    },
    {
      'img': 'assets/icons/vidyat_icon.png',
      'title': 'Electricity Bill',
      'sub': "Ajmer Vidyut Vitaran Nigma Ltd"
    },
    {
      'img': Images.airtelIcon,
      'title': 'Data Subscription',
      'sub': "Airtel Postpaid"
    },
    {
      'img': 'assets/icons/vidyat_icon.png',
      'title': 'Electricity Bill',
      'sub': "Ajmer Vidyut Vitaran Nigma Ltd"
    },
    {
      'img': Images.airtelIcon,
      'title': 'Data Subscription',
      'sub': "Airtel Postpaid"
    },
    {
      'img': 'assets/icons/vidyat_icon.png',
      'title': 'Electricity Bill',
      'sub': "Ajmer Vidyut Vitaran Nigma Ltd"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Transactions History', isShowArrow: false),
      body: transcationWidget(),
    );
  }

  transcationWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        itemCount: historyList.length,
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 16, bottom: 240),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 47,
                    width: 47,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.e1Color),
                        borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.center,
                    child: Image.asset(historyList[index]['img']),
                  ),
                  ScreenSize.width(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          historyList[index]['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: Constants.poppinsMedium,
                              color: AppColor.darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        ScreenSize.height(4),
                        Text(
                          historyList[index]['sub'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: Constants.poppinsMedium,
                              color: AppColor.hintTextColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  ScreenSize.width(4),
                  Column(
                    children: [
                      getText(
                          title: '\$500',
                          size: 20,
                          fontFamily: Constants.poppinsSemiBold,
                          color: AppColor.btnColor,
                          fontWeight: FontWeight.w600),
                      getText(
                          title: '15 hours ago',
                          size: 12,
                          fontFamily: Constants.poppinsRegular,
                          color: AppColor.darkBlackColor,
                          fontWeight: FontWeight.w300),
                    ],
                  )
                ],
              ),
              ScreenSize.height(17),
              customDivider(0)
            ],
          );
        });
  }
}

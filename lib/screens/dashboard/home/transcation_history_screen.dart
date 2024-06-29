import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/util/constaints.dart';
import 'package:velvot_pay/widget/custom_divider.dart';

class TranscationHistoryScreen extends StatefulWidget {
  const TranscationHistoryScreen({super.key});

  @override
  State<TranscationHistoryScreen> createState() =>
      _TranscationHistoryScreenState();
}

class _TranscationHistoryScreenState extends State<TranscationHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            color: AppColor.darkBlackColor,
          ),
          headerWidget(),
          rechargeDetailsWidget()
        ],
      ),
    );
  }

  headerWidget() {
    return Container(
      height: 53,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.purpleColor,
      ),
      padding: const EdgeInsets.only(left: 17),
      child: Row(
        children: [
          SvgPicture.asset(
            Images.arrowBackImage,
            color: AppColor.whiteColor,
          ),
          ScreenSize.width(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getText(
                  title: 'Transaction Successful',
                  size: 16,
                  fontFamily: Constaints.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600),
              getText(
                  title: '11:34pm on 16 Jul 2020',
                  size: 12,
                  fontFamily: Constaints.poppinsRegular,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w300),
            ],
          )
        ],
      ),
    );
  }

  rechargeDetailsWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 33, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: 'Recharge on',
              size: 18,
              fontFamily: Constaints.poppinsSemiBold,
              color: AppColor.darkBlackColor,
              fontWeight: FontWeight.w600),
          ScreenSize.height(21),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: const Color(0xff0DDB77),
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)),
                alignment: Alignment.center,
                child: getText(
                    title: 'DR',
                    size: 18,
                    fontFamily: Constaints.poppinsMedium,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danny Rice',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constaints.poppinsMedium,
                          color: AppColor.darkBlackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    ScreenSize.height(4),
                    getText(
                        title: '9876543210',
                        size: 14,
                        fontFamily: Constaints.poppinsRegular,
                        color: const Color(0xff747474),
                        fontWeight: FontWeight.w300)
                  ],
                ),
              ),
              getText(
                  title: '\$500',
                  size: 16,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.purpleColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          ScreenSize.height(25),
          customDivider(0)
        ],
      ),
    );
  }
}

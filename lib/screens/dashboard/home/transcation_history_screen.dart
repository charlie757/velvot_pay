import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/utils/Constants.dart';
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                color: AppColor.darkBlackColor,
              ),
              headerWidget(),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 250),
                child: Column(
                  children: [
                    rechargeDetailsWidget(),
                    ScreenSize.height(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/icons/slider_image.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                Images.bottomImage,
                fit: BoxFit.cover,
                // height: 250,
                // width: double.infinity,
              ))
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
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              Images.arrowBackImage,
              color: AppColor.whiteColor,
            ),
          ),
          ScreenSize.width(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getText(
                  title: 'Transaction Successful',
                  size: 16,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600),
              getText(
                  title: '11:34pm on 16 Jul 2020',
                  size: 12,
                  fontFamily: Constants.poppinsRegular,
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
      padding: const EdgeInsets.only(top: 33, left: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
        BoxShadow(
            offset: const Offset(0, -1),
            color: AppColor.blackColor.withOpacity(.2),
            blurRadius: 4)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: 'Recharge on',
              size: 18,
              fontFamily: Constants.poppinsSemiBold,
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
                      'Danny Rice',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.poppinsMedium,
                          color: AppColor.darkBlackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    ScreenSize.height(4),
                    getText(
                        title: '9876543210',
                        size: 14,
                        fontFamily: Constants.poppinsRegular,
                        color: const Color(0xff747474),
                        fontWeight: FontWeight.w300)
                  ],
                ),
              ),
              getText(
                  title: '\$500',
                  size: 16,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.purpleColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          ScreenSize.height(25),
          customDivider(0),
          ScreenSize.height(26),
          Row(
            children: [
              SvgPicture.asset(Images.transferIcon),
              ScreenSize.width(10),
              getText(
                  title: 'Transfer Details',
                  size: 14,
                  fontFamily: Constants.poppinsMedium,
                  color: const Color(0xff484848),
                  fontWeight: FontWeight.w400),
              const Spacer(),
              SvgPicture.asset(
                Images.arrowUpIcon,
                color: const Color(0xff484848),
              )
            ],
          ),
          ScreenSize.height(16),
          getText(
              title: 'Transaction ID',
              size: 14,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.hintTextColor,
              fontWeight: FontWeight.w300),
          getText(
              title: 'T2265688966465465465498898',
              size: 12,
              fontFamily: Constants.poppinsMedium,
              color: AppColor.darkBlackColor,
              fontWeight: FontWeight.w400),
          ScreenSize.height(15),
          getText(
              title: 'Credited to',
              size: 14,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.darkBlackColor,
              fontWeight: FontWeight.w300),
          ScreenSize.height(15),
          Row(
            children: [
              Image.asset(
                Images.creditIcon,
                height: 23,
                width: 23,
              ),
              ScreenSize.width(4),
              getText(
                  title: '**************58',
                  size: 14,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w400),
              const Spacer(),
              getText(
                  title: '\$500',
                  size: 16,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.purpleColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: getText(
                title: 'UTR: 987412548753',
                size: 13,
                fontFamily: Constants.poppinsMedium,
                color: AppColor.hintTextColor,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

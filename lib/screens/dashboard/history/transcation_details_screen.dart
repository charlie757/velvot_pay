import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/transaction_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/utils/time_format.dart';
import 'package:velvot_pay/widget/custom_divider.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final String transactionId;
     TransactionDetailsScreen({required this.transactionId});

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {

@override
  void initState() {
  callInitFunction();
    // TODO: implement initState
    super.initState();
  }

  callInitFunction(){
  final provider = Provider.of<TransactionProvider>(context,listen: false);
  Future.delayed(Duration.zero,(){
    provider.getTransactionDetailsApiFunction(widget.transactionId);
  });
  }

  @override
  Widget build(BuildContext context) {
  final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      body: Consumer<TransactionProvider>(
        builder: (context,myProvider,child) {
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                color: AppColor.darkBlackColor,
              ),
              headerWidget(myProvider),
              myProvider.transactionDetailsModel!=null&&myProvider.transactionDetailsModel!.data!=null?
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    rechargeDetailsWidget(myProvider),
                    ScreenSize.height(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: sliderWidget(dashboardProvider)
                    )
                  ],
                ),
              )):Container()
            ],
          );
        }
      ),
    );
  }

  headerWidget(TransactionProvider provider) {
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
                title:provider.transactionDetailsModel!=null&&provider.transactionDetailsModel!.data!=null&&provider.transactionDetailsModel!.data!.date!=null?
                  TimeFormat.convertToReadableFormat(provider.transactionDetailsModel!.data!.date):"",
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

  rechargeDetailsWidget(TransactionProvider provider) {
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
                    title:provider.transactionDetailsModel!.data!.number!=null?
                    provider.transactionDetailsModel!.data!.number.toString().substring(0,2):"",
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
                      provider.transactionDetailsModel!.data!.productName??"",
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
                        title: provider.transactionDetailsModel!.data!.number??"",
                        size: 14,
                        fontFamily: Constants.poppinsRegular,
                        color: const Color(0xff747474),
                        fontWeight: FontWeight.w300)
                  ],
                ),
              ),
              ScreenSize.width(5),
              getText(
                  title: '₦${ provider.transactionDetailsModel!.data!.amount??""}',
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
              title: provider.transactionDetailsModel!.data!.transactionId??"",
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
              provider.transactionDetailsModel!.data!.paymentData!=null&&provider.transactionDetailsModel!.data!.paymentData!.card!=null?
              getText(
                  title: '************${provider.transactionDetailsModel!.data!.paymentData!.card!.last4Digit??''}',
                  size: 14,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w400):Container(),
              const Spacer(),
              getText(
                  title: '₦${provider.transactionDetailsModel!.data!.amount??''}',
                  size: 16,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.purpleColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: getText(
                title: 'UTR: ${provider.transactionDetailsModel!.data!.requestId??""}',
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

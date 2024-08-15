import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/pay_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/successfully_payment_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import '../../../helper/network_image_helper.dart';

class PayScreen extends StatefulWidget {
  final String route;
  final Map data;
  final String isFromSearchNumberRoute;
  const PayScreen({required this.route,required this.data,required this.isFromSearchNumberRoute});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<PayProvider>(context,listen: false);
    provider.plugin.initialize(publicKey: ApiUrl.payStackPublicKey);

    if(widget.route=='electricity'){
     Future.delayed(Duration.zero,(){
       provider.electricityBillDetailsApiFunction(widget.data['serviceId'], widget.data['billersCode'], widget.data['variation_code']);
     });
    }
    provider.apiUrl = provider.setApiUrls(widget.route);
  }

  @override
  Widget build(BuildContext context) {
  print(widget.data);
    return Consumer<PayProvider>(
        builder: (context,myProvider,child) {
        return Scaffold(
            appBar: appBar(
                title: widget.route == 'operator' ? 'Pay' :
                    widget.route=='education'?
                    "Education Details":
                widget.route=='tv'?"TV Subscription Details":
                widget.route=='electricity'?
                "Electricity Bill Details":
                widget.route.toString().contains('insurance')?
                widget.data['operatorName']:
                widget.route=='topup'?
                    "Mobile Top up Details":
                '',
                onTap: () {
                  Navigator.pop(context);
                }),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.route == 'operator' ? dataSubscriptionWidget() :
                    widget.route=='electricity'?
                    electricityBillWidget(myProvider):
                        widget.route=='education'? educationSubscriptionWidget():
                    widget.route=='tv'?tvSubscriptionWidget():
                        widget.route=='insurance-third party'?
                        thirdPartyInsuranceWidget(myProvider):
                        widget.route=='insurance-personal'?
                            personalInsuranceWidget(myProvider):
                            widget.route=='insurance-health'?
                            healthInsuranceWidget(myProvider):
                                widget.route=='topup'?
                                    mobileTopUpWidget():
                        Container(),
                  ],
                ),
            ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 40),
          child: CustomBtn(
              title: 'Proceed to Pay',
              onTap: () async{
                if(widget.route=='insurance-health') {
                  myProvider.convertFileToBase64(
                      widget.data['billerData']['Passport_Photo']);
                }
                myProvider.payStackApiFunction(double.parse(widget.data!['amount'].toString()), widget.data,widget.route, widget.isFromSearchNumberRoute);

              }),
        )
        );
      }
    );
  }

  dataSubscriptionWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.lightAppColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: widget.data!=null?
                      widget.data['number']??'':'',
                      size: 14,
                      fontFamily: Constants.poppinsSemiBold,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                  getText(
                      title: widget.data!=null?
                      widget.data['operatorName']??"":"",
                      size: 14,
                      fontFamily: Constants.poppinsSemiBold,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w500)
                ],
              )
            ],
          ),
          ScreenSize.height(13),
          viewDataPlanWidget()
        ],
      ),
    );
  }

  mobileTopUpWidget(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.lightAppColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(20),
              getText(
                  title: widget.data!=null?
                  widget.data['operatorName']??"":"",
                  size: 14,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w500)
            ],
          ),
          ScreenSize.height(13),
          Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Mobile Number',
                    widget.data['phone']??'',
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),

               ],
            ),
          )
        ],
      ),
    );
  }

  viewDataPlanWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.hintTextColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -2),
                color: AppColor.blackColor.withOpacity(.1),
                blurRadius: 5)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getText(
                  title: '₦${widget.data!=null?widget.data['amount']:""}',
                  size: 25,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 32,
                  width: 98,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xff211C3A)),
                  alignment: Alignment.center,
                  child: getText(
                      title: 'Change Plan',
                      size: 12,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          ScreenSize.height(15),
          Row(
            children: [
              getText(
                  title: 'Data :',
                  size: 12,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: '${widget.data!=null?widget.data['data']:""} Per PAck',
                  size: 14,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
              // ScreenSize.width(28),
              const Spacer(),
              // getText(
              //     title: 'Validity :',
              //     size: 12,
              //     fontFamily: Constants.poppinsMedium,
              //     color: AppColor.whiteColor,
              //     fontWeight: FontWeight.w400),
              // ScreenSize.width(7),
              // getText(
              //     title: widget.data!=null?widget.data['amount']:"",
              //     size: 14,
              //     fontFamily: Constants.poppinsSemiBold,
              //     color: AppColor.darkBlackColor,
              //     fontWeight: FontWeight.w600),
            ],
          ),
          ScreenSize.height(11),
          Row(
            children: [
              getText(
                  title: 'Data :',
                  size: 12,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: widget.data!=null?widget.data['data']:"",
                  size: 12,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w700),
            ],
          ),
          ScreenSize.height(5),
          Row(
            children: [
              getText(
                  title: 'Data :',
                  size: 12,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.width(7),
              getText(
                  title: 'Till Your Existing Pack',
                  size: 12,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w700),
            ],
          )
        ],
      ),
    );
  }

  tvSubscriptionWidget(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.lightAppColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(20),
              getText(
                  title: widget.data!=null?
                  widget.data['operatorName']??"":"",
                  size: 14,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w500)
            ],
          ),
          ScreenSize.height(13),
          Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Plan Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),
                ScreenSize.height(16),
                customRowWidget(
                    'Plan Name',
                    widget.data['planName']??'',
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'TV Number',
                    widget.data['billerData']['tvBillerNumber']??'' ,
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
              ],
            ),
          )
        ],
      ),
    );
  }


  educationSubscriptionWidget(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.lightAppColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(20),
              getText(
                  title: widget.data!=null?
                  widget.data['operatorName']??"":"",
                  size: 14,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w500)
            ],
          ),
          ScreenSize.height(13),
          Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Plan Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),
                ScreenSize.height(16),
                customRowWidget(
                    'Plan Name',
                    widget.data['planName']??'',
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Institute Number',
                    widget.data['billerData']['instituteNumber']??'',
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
              ],
            ),
          )
        ],
      ),
    );
  }


  electricityBillWidget(PayProvider provider) {
    return provider.electricityPlanModel!=null&&provider.electricityPlanModel!.data!=null?
    Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
          color: AppColor.lightAppColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Text(
                    widget.data!=null?
                    widget.data['operatorName']??"":"",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.poppinsSemiBold,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          ScreenSize.height(15),
           Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Bill Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),
                ScreenSize.height(16),
                customRowWidget(
                    'Name',
                    provider.electricityPlanModel!.data!.customerName??"",
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Customer ID',
                    provider.electricityPlanModel!.data!.customerDistrict??"-",
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Address',
                    provider.electricityPlanModel!.data!.address??"-",
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget('Status', 'Unpaid', 12, AppColor.redColor,
                    FontWeight.w400, Constants.poppinsRegular),
              ],
            ),
          )
        ],
      ),
    ):Container();
  }

  thirdPartyInsuranceWidget(PayProvider provider) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
          color: AppColor.lightAppColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Text(
                  widget.data!=null?
                  widget.data['operatorName']??"":"",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.poppinsSemiBold,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          ScreenSize.height(15),
          Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Vehicle Number', widget.data['billerData']['Plate_Number'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Owner Name', widget.data['billerData']['Insured_Name'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Engine Number', widget.data['billerData']['Engine_Number'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'chassis Number', widget.data['billerData']['Chasis_Number'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Vehicle Maker', widget.data['billerData']['Vehicle_Make'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),ScreenSize.height(16),
                customRowWidget(
                    'Vehicle Color', widget.data['billerData']['Vehicle_Color'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),ScreenSize.height(16),
                customRowWidget(
                    'Vehicle Model', widget.data['billerData']['Vehicle_Model'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),ScreenSize.height(16),
                customRowWidget(
                    'Vehicle purchased year', widget.data['billerData']['Year_of_Make'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),ScreenSize.height(16),
                customRowWidget(
                    'Address', widget.data['billerData']['Contact_Address'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Bill Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),
              ],
            ),
          )
        ],
      ),
    );
  }

  personalInsuranceWidget(PayProvider provider) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
          color: AppColor.lightAppColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Text(
                  widget.data!=null?
                  widget.data['operatorName']??"":"",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.poppinsSemiBold,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          ScreenSize.height(15),
          Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Full Name', widget.data['billerData']['full_name'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Mobile Number', widget.data['billerData']['phone'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Address', widget.data['billerData']['address'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Business Occupation', widget.data['billerData']['business_occupation'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Date of birth', widget.data['billerData']['dob'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Bill Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),
              ],
            ),
          )
        ],
      ),
    );
  }

  healthInsuranceWidget(PayProvider provider) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
          color: AppColor.lightAppColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.data!=null?
                      widget.data['operatorImage']??'':'',
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Text(
                  widget.data!=null?
                  widget.data['operatorName']??"":"",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.poppinsSemiBold,
                      color: AppColor.darkBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          ScreenSize.height(15),
          Container(
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRowWidget(
                    'Full Name', widget.data['billerData']['full_name'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Mobile Number', widget.data['billerData']['phone'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Date of birth', widget.data['billerData']['date_of_birth'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Hospital', widget.data['billerData']['selected_hospital'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Address', widget.data['billerData']['address'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Remark', widget.data['billerData']['extra_info'],
                    14,
                    AppColor.darkBlackColor,
                    FontWeight.w400,
                    Constants.poppinsRegular),
                ScreenSize.height(16),
                customRowWidget(
                    'Bill Amount',
                    '₦${widget.data['amount']??""}',
                    16,
                    AppColor.darkBlackColor,
                    FontWeight.w600,
                    Constants.poppinsSemiBold),
                ScreenSize.height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(
                      title: 'Photo :',
                      size: 12,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w400),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:  Image.file(File(widget.data['billerData']['Passport_Photo']),fit: BoxFit.cover,
                      height: 75,width: 75,
                    ),)
                ],
              )
              ],
            ),
          )
        ],
      ),
    );
  }

  customRowWidget(String title, String subTitle, double fontSize, Color color,
      FontWeight fontWeight, String fontFamily) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getText(
            title: '$title :',
            size: 12,
            fontFamily: Constants.poppinsMedium,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w400),
       ScreenSize.width(35),
       Expanded(child:  Align(
         alignment: Alignment.centerRight,
         child: Text(subTitle,
         // maxLines: 1,
        // overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: color,
            fontWeight: fontWeight
        ),
    )
       ))
      ],
    );
  }

  totalAmountPayableBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColor.whiteColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    getText(
                        title: 'Total Payable',
                        size: 18,
                        fontFamily: Constants.poppinsSemiBold,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w600),
                    const Spacer(),
                    getText(
                        title: '\$500',
                        size: 20,
                        fontFamily: Constants.poppinsSemiBold,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.width(25),
                    const Icon(Icons.close),
                  ],
                ),
              ],
            ),
          );
        });
  }

}

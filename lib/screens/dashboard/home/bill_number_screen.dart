import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/pay_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

class BillNumberScreen extends StatefulWidget {
  final int index;
  const BillNumberScreen({required this.index});

  @override
  State<BillNumberScreen> createState() => _BillNumberScreenState();
}

class _BillNumberScreenState extends State<BillNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          title: widget.index == 1
              ? 'Electricity Bill Number'
              : widget.index == 3
                  ? "TV Subscription Bill Number"
                  : "Insurance Payment",
          onTap: () {
            Navigator.pop(context);
          }),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 240),
            child: Column(
              children: [
                formWidget(),
                ScreenSize.height(15),
                desclimierWidget()
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: bottomImageButtonWidget(
                  onTap: () {
                    AppRoutes.pushNavigation(const PayScreen(
                      index: 1,
                    ));
                  },
                  btnText: 'Continue'))
        ],
      ),
    );
  }

  formWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.lightAppColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      child: Column(
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
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/icons/jaipur_image.png')),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Text(
                  'Jaipur Vidyut Vitaran Nigam Ltd',
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
          ScreenSize.height(11),
          widget.index == 1
              ? electriityWidget()
              : widget.index == 3
                  ? tvSubscriptionWidget()
                  : insuranceWidget()
        ],
      ),
    );
  }

  electriityWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: AppColor.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(hintText: 'Enter Your Meter Number'),
          ScreenSize.height(7),
          getText(
              title: 'Please enter a valid 12 digit Meter Number',
              size: 11,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w400),
          ScreenSize.height(12),
          CustomTextField(hintText: 'Enter Mobile Number'),
        ],
      ),
    );
  }

  tvSubscriptionWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: AppColor.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(hintText: 'Enter Your Tv Subscription Number'),
        ],
      ),
    );
  }

  insuranceWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: AppColor.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hintText: 'Enter Your Vehicle Number',
            textInputAction: TextInputAction.next,
          ),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Your Vehicle Owner Name',
              textInputAction: TextInputAction.next),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Engine Number',
              textInputAction: TextInputAction.next),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Chasis Number',
              textInputAction: TextInputAction.next),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Maker',
              textInputAction: TextInputAction.next),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Color',
              textInputAction: TextInputAction.next),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Model',
              textInputAction: TextInputAction.next),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Your Address',
              textInputAction: TextInputAction.done),
        ],
      ),
    );
  }

  desclimierWidget() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.lightAppColor,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(20),
      child: getText(
          title:
              'Pay ${widget.index == 1 ? "electricity bill" : widget.index == 3 ? "TV Subscription bill" : "Insurance bill"} safely, conveniently & easily. You can pay anytime and anyere!',
          size: 14,
          fontFamily: Constants.poppinsRegular,
          color: AppColor.darkBlackColor,
          fontWeight: FontWeight.w400),
    );
  }
}

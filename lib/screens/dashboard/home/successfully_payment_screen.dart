import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/screens/dashboard/dashboard_screen.dart';
import 'package:velvot_pay/screens/dashboard/transaction/transcation_receipt_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

import '../../../provider/transaction_provider.dart';

class SuccessfullyPaymentScreen extends StatefulWidget {
  final String amount;
  final String operatorName;
  final String transactionId;
  final String isFromSearchNumberRoute;
  final String route;
  SuccessfullyPaymentScreen({required this.amount,required this.operatorName,required this.transactionId,required this.route,
  required this.isFromSearchNumberRoute
  });

  @override
  State<SuccessfullyPaymentScreen> createState() =>
      _SuccessfullyPaymentScreenState();
}

class _SuccessfullyPaymentScreenState extends State<SuccessfullyPaymentScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 35, left: 10, right: 10,bottom: 30),
            child: Column(
              children: [
                SvgPicture.asset(Images.successIcon),
                ScreenSize.height(10),
                getText(
                  title: 'Your ${widget.operatorName} recharge of\n₦${widget.amount} is successfully',
                  size: 20,
                  fontFamily: Constants.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                ScreenSize.height(20),
                getText(
                  title: 'Your recharge will be applied by\n${DateFormat('hh:mm a').format(DateTime.now())} today',
                  size: 16,
                  fontFamily: Constants.poppinsRegular,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                ScreenSize.height(20),
                GestureDetector(
                  onTap: (){
                    AppRoutes.pushNavigation( TransactionReceiptScreen(transactionId: widget.transactionId,));
                  },
                  child: Container(
                    height: 49,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.darkBlackColor,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: getText(
                        title: 'View Details',
                        size: 16,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ScreenSize.height(30),
                // sliderWidget(dashboardProvider)
              ],
            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.only(left: 10,bottom: 30,right: 10),
          child: CustomBtn(
              title: 'Done',
              onTap: () {
                if(widget.route=='operator'){
                  if(widget.isFromSearchNumberRoute.isNotEmpty)
                    {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                }
                else if(widget.route=='electricity'){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                else if(widget.route=='education'||widget.route=='tv'||widget.route.contains('insurance')){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                else if(widget.route=='topup'){
                 if(widget.isFromSearchNumberRoute.isNotEmpty){
                  print('sdfsd');
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else {
                   Navigator.pop(context);
                   Navigator.pop(context);
                   Navigator.pop(context);
                   Navigator.pop(context);
                 } }
                else{
                  Navigator.pop(context);
                }
              }),
        ),
      ),
    );
  }
}

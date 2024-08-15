import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/network_image_helper.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/history/transcation_details_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/utils/time_format.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_divider.dart';

import '../../../provider/transaction_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen();

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<TransactionProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      provider.callTransactionApiFunction();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Transactions History', isShowArrow: false),
      body: Consumer<TransactionProvider>(builder: (context,myProvider,child){
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification){
              if (scrollNotification is ScrollStartNotification) {
              } else if (scrollNotification is ScrollUpdateNotification) {

              } else if (scrollNotification is ScrollEndNotification) {
                if(scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent - 40){
                  myProvider.callTransactionPaginationApiFunction();
                }
              }
              return true;
            },
            child: !myProvider.isLoading?
            myProvider.transactionList.isNotEmpty?
            transactionWidget(myProvider):
                Center(
                  child: getText(title: 'No Transactions',
                      size: 14, fontFamily: Constants.poppinsMedium, color: AppColor.redColor,
                      fontWeight: FontWeight.w500),
                )
                :
            Container(),
          );
        }
      ),
    );
  }

  transactionWidget(TransactionProvider provider) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        itemCount: provider.transactionList.length,
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 16, bottom: 120),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var model = provider.transactionList[index];
          return GestureDetector(
            onTap: () {
              AppRoutes.pushNavigation(TransactionDetailsScreen(transactionId: model.sId,));
            },
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
                          borderRadius: BorderRadius.circular(25)),
                      alignment: Alignment.center,
                      child: NetworkImagehelper(
                        img: model.operator!.image,
                      ),
                    ),
                    ScreenSize.width(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title??'',
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
                            model.type??"",
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
                            title: '₦${model.amount??''}',
                            size: 20,
                            fontFamily: Constants.poppinsSemiBold,
                            color: AppColor.btnColor,
                            fontWeight: FontWeight.w600),
                        getText(
                            title:model.date!=null? TimeFormat.getCommentTime(model.date):'',
                            size: 12,
                            fontFamily: Constants.poppinsRegular,
                            color: AppColor.darkBlackColor,
                            fontWeight: FontWeight.w300),
                      ],
                    )
                  ],
                ),
                ScreenSize.height(17),
                customDivider(0),
                provider.transactionList.length==index+1&& provider.scrollLoading?
                Container(
                  height: 60,
                    alignment: Alignment.center,
                    child:const CircularProgressIndicator()):Container()
              ],
            ),
          );
        });
  }
}

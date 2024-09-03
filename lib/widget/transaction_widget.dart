
import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/screens/dashboard/transaction/transcation_receipt_screen.dart';

import '../helper/app_color.dart';
import '../helper/getText.dart';
import '../helper/images.dart';
import '../helper/network_image_helper.dart';
import '../helper/screen_size.dart';
import '../utils/Constants.dart';
import '../utils/time_format.dart';

transactionWidget(var model,){
  return GestureDetector(
    onTap: (){
      AppRoutes.pushNavigation(TransactionReceiptScreen(transactionId: model.sId));
    },
    child: Row(
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              border: Border.all(color: AppColor.e1Color),
              borderRadius: BorderRadius.circular(20)
          ),
          alignment: Alignment.center,
          child:model.operator!=null? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: NetworkImagehelper(
              img: model.operator!.image,width: 34.0,height: 34.0,
            ),
          ):Image.asset(Images.vpLogo),
        ),
        ScreenSize.width(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: getText(title: model.transactionType.toString()=='1'? 'Deposit of ₦${model.amount}':
                    model.title,
                        size: 14, fontFamily: Constants.galanoGrotesqueSemiBold, color:const Color(0xff3F3F46), fontWeight: FontWeight.w500),
                  ),
                  ScreenSize.width(4),
                  getText(title: '${model.transactionType.toString()=='2'?'-':''}₦${model.amount}',
                      size: 14, fontFamily: Constants.galanoGrotesqueSemiBold, color:
                      model.transactionType.toString()=='2'?
                      AppColor.lightRedColor:
                      const Color(0xff3F3F46), fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text( model.transactionType.toString()=='1'? 'You have added ₦${model.amount} on your wallet':
                  model.type,maxLines: 1,overflow: TextOverflow.ellipsis, style: TextStyle(
                      fontSize: 12, fontFamily: Constants.galanoGrotesqueRegular, color:const Color(0xffA0A0AB), fontWeight: FontWeight.w400))),
                ScreenSize.width(4),
                  getText(title: model.date!=null? TimeFormat.getCommentTime(model.date):'',
                      size: 10, fontFamily: Constants.galanoGrotesqueRegular, color:const Color(0xff979C9E), fontWeight: FontWeight.w400),
                ],
              )
            ],
          ),
        ),

      ],
    ),
  );
}

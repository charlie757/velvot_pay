import 'dart:io';
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/transaction_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/utils/time_format.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_divider.dart';
import 'package:velvot_pay/widget/slider_widget.dart';
import 'package:widgets_to_image/widgets_to_image.dart';


class TransactionReceiptScreen extends StatefulWidget {
  final String transactionId;
  TransactionReceiptScreen({required this.transactionId});

  @override
  State<TransactionReceiptScreen> createState() =>
      _TransactionReceiptScreenState();
}

class _TransactionReceiptScreenState extends State<TransactionReceiptScreen> {

@override
  void initState() {
  callInitFunction();
    // TODO: implement initState
    super.initState();
  }
WidgetsToImageController controller = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;

  callInitFunction(){
  final provider = Provider.of<TransactionProvider>(context,listen: false);
  Future.delayed(Duration.zero,(){
    provider.getTransactionDetailsApiFunction(widget.transactionId);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteF7Color,
      appBar: appBar(title: 'Transaction Receipt',backgroundColor: AppColor.whiteF7Color),
      body: Consumer<TransactionProvider>(
        builder: (context,myProvider,child) {
          return myProvider.transactionDetailsModel!=null&&myProvider.transactionDetailsModel!.data!=null?  Padding(padding:const EdgeInsets.only(left: 16,right: 16,top: 20),
          child: receiptWidget(myProvider),
          ):Container();
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 30),
        child: CustomBtn(title: "Share Receipt",onTap: ()async{
          bytes = await controller.capture();
          await Share.shareXFiles(
            [XFile.fromData(bytes!, name: 'receipt.png', mimeType: 'image/png')],
            text: 'Check out your receipt',
          );
        },),
      ),
    );
  }

  receiptWidget(TransactionProvider provider){
  var model = provider.transactionDetailsModel!.data;
  return WidgetsToImage(
    controller: controller,
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      padding:const EdgeInsets.only(top: 24,left: 16,right: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Images.successIcon),
            ScreenSize.height(32),
            menuRowWidget(title: 'Recipent Mobile',subTitle: model!.requestId!=null&&model!.requestId.toString().isNotEmpty?model!.requestId.toString():'NA', ),
            ScreenSize.height(24),
            menuRowWidget(title: 'Data Bundle',subTitle: model!.planName!=null&&model!.planName.toString().isNotEmpty?model!.planName.toString():"NA",),
            ScreenSize.height(24),
            menuRowWidget(title: 'Transaction type',subTitle: model!.transactionsType.toString()=='1'?"Deposit":"Credit",),
            ScreenSize.height(24),
            menuRowWidget(title: 'Payment Method',subTitle: model!.paymentMethod!=null&&model!.paymentMethod.toString().isNotEmpty?model!.paymentMethod:'NA'),
            ScreenSize.height(24),
            menuRowWidget(title: 'Transaction ID',subTitle: model!.transactionId!=null&&model!.transactionId.toString().isNotEmpty?model!.transactionId:'-'),
            ScreenSize.height(24),
            menuRowWidget(title: 'Transaction Date',subTitle:model!.date!=null? TimeFormat.convertTransaction(model!.date):"NA"),
            ScreenSize.height(24),
            menuRowWidget(title: 'Status',subTitle: '', ),
            ScreenSize.height(24),
          ],
        ),
      ),
    ),
  );
  }

  menuRowWidget({required String title, required String subTitle, }){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getText(title: title,
          size: 12, fontFamily: Constants.galanoGrotesqueRegular, color: const  Color(0xff7F808C), fontWeight: FontWeight.w400),
        ScreenSize.width(4),
      title.toString().toLowerCase()=='status'?
          Row(
            children: [
              SvgPicture.asset(Images.successIcon,height: 16,width: 16,),
              ScreenSize.width(5),
              getText(title: 'Successful',
                  size: 12, fontFamily: Constants.galanoGrotesqueSemiBold, color : AppColor.greenColor, fontWeight: FontWeight.w700),

            ],
          ):
      Expanded(
        child: Text( subTitle,
         maxLines: 1,
         textAlign: TextAlign.right,
         overflow: TextOverflow.ellipsis,
         style: TextStyle(   fontSize: 12, fontFamily: Constants.galanoGrotesqueSemiBold, color : AppColor.grayIronColor, fontWeight: FontWeight.w700),
        )),
    ],
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
              // provider.transactionDetailsModel!.data!.paymentData!=null&&provider.transactionDetailsModel!.data!.paymentData!.card!=null?
              // getText(
              //     title: '************${provider.transactionDetailsModel!.data!.paymentData!.card!.last4Digit??''}',
              //     size: 14,
              //     fontFamily: Constants.poppinsMedium,
              //     color: AppColor.hintTextColor,
              //     fontWeight: FontWeight.w400):Container(),
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

// static Future<String> shareScreenShort(String title, {required GlobalKey previewContainer, int originalSize = 1600}) async {
//   try {
//     RenderRepaintBoundary boundary = previewContainer.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     double pixelRatio = originalSize / MediaQuery.of(previewContainer.currentContext!).size.width;
//     ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();
//
//     String filePathAndName = Service.documentDirectoryPath + '/images/$title.png';
//     File imgFile = File(filePathAndName);
//     await imgFile.writeAsBytes(pngBytes);
//     await Share.shareXFiles(
//       [XFile(imgFile.path)],
//       sharePositionOrigin: boundary.localToGlobal(Offset.zero) & boundary.size,
//       text: title,
//     );
//
//     return "success";
//   } catch (ex) {
//     return ex.toString();
//   }
// }

}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/screens/dashboard/transaction/download_statement.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_radio_button.dart';

import '../../../provider/transaction_provider.dart';
import '../../../utils/utils.dart';
import '../../../widget/transaction_widget.dart';

class TransactionScreen extends StatefulWidget {
   TransactionScreen();

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<TransactionProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      provider.currentFilterIndex=-1;
      provider.callTransactionApiFunction(true,'');
    });
  }
  @override
  Widget build(BuildContext context) {
    print(SessionManager.token);
    return Scaffold(
      // backgroundColor: AppColor.whiteF7Color,
      appBar: appBar(title: 'Transactions History', isShowArrow: false,
      // backgroundColor: AppColor.whiteF7Color,
      actions: [
        Padding(padding:const EdgeInsets.only(
          right: 16
        ),child: GestureDetector(
            onTap: (){
              AppRoutes.pushNavigation(const DownloadStatement());
            },
            child: SvgPicture.asset(Images.downloadSvg)),)
       ]),
      body: Consumer<TransactionProvider>(builder: (context,myProvider,child){
          return Column(
            children: [
              searchWidget(),
            Expanded(child: !myProvider.isLoading?
            myProvider.model!=null&&myProvider.model!.data!=null&&myProvider.model!.data!.isNotEmpty?
            transactions(myProvider):
            Center(
              child: getText(title: 'No Transactions',
                  size: 14, fontFamily: Constants.poppinsMedium, color: AppColor.redColor,
                  fontWeight: FontWeight.w500),
            ):
            Container())
            ],
          );
        }
      ),
    );
  }

  searchWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: Row(
        children: [
          Expanded(child: CustomSearchBar(hintText: 'Search transactions',
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
          ],
          onChanged: (val){
            Provider.of<TransactionProvider>(context,listen: false).callTransactionApiFunction(false, 'keyword=$val');
          },
          )),
          ScreenSize.width(8),
          GestureDetector(
            onTap: (){
              filterBottomSheet();
            },
            child: Container(
              height: 50,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffD1D1D6)),
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFAFAFA)
              ),
              child: SvgPicture.asset(Images.filterSvg),
            ),
          )
        ],
      ),
    );
  }

  transactions(TransactionProvider provider) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(22);
        },
        itemCount: provider.model!.data!.length,
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var model = provider.model!.data![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(title: model.sId, size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                  color: const Color(0xff51525C), fontWeight: FontWeight.w500),
              ScreenSize.height(16),
              ListView.separated(
                separatorBuilder: (context,s){
                  return ScreenSize.height(16);
                },
                shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: model.items!.length,
                  itemBuilder: (context,i){
                  var model1 = model.items![i];
                return transactionWidget(model1);
              })
              // transactionUi()
            ],
          );
        });
  }

  filterBottomSheet(){
    final provider = Provider.of<TransactionProvider>(context,listen: false);
    showModalBottomSheet(context: context,
        backgroundColor: AppColor.whiteColor,
        shape:const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))
        ),
        builder: (context){
      return StatefulBuilder(
        builder: (context,state) {
          return Container(
            padding:const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(title: 'Filter', size: 20, fontFamily: Constants.galanoGrotesqueMedium,
                        color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                   InkWell(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child:  Icon(Icons.close,color: AppColor.blackColor,),
                   )
                  ],
                ),
                ScreenSize.height(25),
                ListView.builder(
                    itemCount: Constants.serviceList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      provider.updateCurrentFilterIndex(index);
                      provider.callTransactionApiFunction(true,'type=${Constants.serviceList[index]['value']}');
                      state((){});
                    },
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          customRadioButton(provider.currentFilterIndex==index? true:false),
                          ScreenSize.width(15),
                          getText(title: Constants.serviceList[index]['title'], size: 14,
                              fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          );
        }
      );
        });
  }

}

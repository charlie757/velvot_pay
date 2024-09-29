import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../helper/app_color.dart';
import '../../../../../helper/custom_btn.dart';
import '../../../../../helper/custom_search_bar.dart';
import '../../../../../helper/getText.dart';
import '../../../../../helper/images.dart';
import '../../../../../helper/network_image_helper.dart';
import '../../../../../helper/screen_size.dart';
import '../../../../../model/saved_buy_subscription_transaction_model.dart';
import '../../../../../utils/Constants.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widget/appBar.dart';

class EducationSavedTransactionScreen extends StatefulWidget {
  SavedTransactionModel? model;
  EducationSavedTransactionScreen({required this.model});

  @override
  State<EducationSavedTransactionScreen> createState() => _EducationSavedTransactionScreenState();
}

class _EducationSavedTransactionScreenState extends State<EducationSavedTransactionScreen> {

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteF7Color,
      appBar: appBar(title: "Saved Transactions",backgroundColor: AppColor.whiteF7Color,),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchWidget(),
            ScreenSize.height(25),
            widget.model!=null&&widget.model!.data!=null&&widget.model!.data!.isNotEmpty?
            Container(
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffF4F4F5))
              ),

              child: ListView.separated(
                  separatorBuilder: (context,sp){
                    return ScreenSize.height(16);
                  },
                  itemCount: widget.model!.data!.length,
                  padding:const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context,index){
                    var model = widget.model!.data![index];
                    return GestureDetector(
                      onTap: (){
                        selectedIndex = index;
                        setState(() {

                        });
                      },
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
                        decoration: BoxDecoration(
                            color: AppColor.whiteF7Color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color:selectedIndex==index?
                            AppColor.appColor:
                            const Color(0xffF4F4F5))
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.request!=null&& model.request!.operator!!=null&&model.request!.operator!.image!=null?
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15) ,
                                child:NetworkImagehelper(
                                  img: model.request!.operator!.image,
                                  height: 29.0,
                                  width: 29.0,
                                )
                            ):Container(),
                            ScreenSize.width(4),
                            Expanded(
                              child:model.request!=null? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text( model.request!.planName??'',
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12, fontFamily: Constants.galanoGrotesqueMedium,
                                              color: const Color(0xff51525C), fontWeight: FontWeight.w500)),
                                      ScreenSize.width(8),
                                      getText(title: '₦${model.amount??''}',
                                          size: 10, fontFamily: Constants.galanoGrotesqueMedium,
                                          color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                  getText(title: model.request!.phone??"",
                                      size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                                      color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                                  getText(title: 'Result Checker Pin',
                                      size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                                      color: const Color(0xff51525C), fontWeight: FontWeight.w600),
                                ],
                              ):Container(),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ):Container(
                height: 400,
                alignment: Alignment.center,
                child: getText(title: 'No Saved Transactions Yet',
                    size: 14, fontFamily: Constants.poppinsMedium, color: AppColor.redColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 25),
        child: CustomBtn(title: "Proceed to Payment", onTap: (){
        }),
      ),
    );
  }

  searchWidget(){
    return Row(
      children: [
        Expanded(child: CustomSearchBar(hintText: 'Search...',
          isSearchIconColor: true,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
          ],
          onChanged: (val){
            // Provider.of<TransactionProvider>(context,listen: false).callTransactionApiFunction(false, 'keyword=$val');
          },
        )),
        ScreenSize.width(8),
        GestureDetector(
          onTap: (){
            // filterBottomSheet();
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
    );
  }
}

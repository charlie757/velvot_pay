import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/model/saved_buy_subscription_transaction_model.dart';
import 'package:velvot_pay/provider/insurance_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/service/insurance/insurance_details_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/insurance/insurance_saved_transaction_screen.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../../../approutes/app_routes.dart';
import '../../../../../helper/app_color.dart';
import '../../../../../helper/getText.dart';
import '../../../../../helper/images.dart';
import '../../../../../helper/network_image_helper.dart';
import '../../../../../helper/screen_size.dart';
import '../../../../../provider/service_provider.dart';
import '../../../../../utils/Constants.dart';

class InsuranceOperatorScreen extends StatefulWidget {
  const InsuranceOperatorScreen({super.key});

  @override
  State<InsuranceOperatorScreen> createState() => _InsuranceOperatorScreenState();
}

class _InsuranceOperatorScreenState extends State<InsuranceOperatorScreen> {

  List savedTransactionList = ['','',''];
  final formKey = GlobalKey<FormState>();

  callInitFunction()async{
    final provider = Provider.of<InsuranceProvider>(context,listen: false);
    final serviceProvider = Provider.of<ServiceProvider>(context,listen: false);
    provider.resetValues();
    Future.delayed(Duration.zero,(){
      provider.callOperatorListApiFunction();
      serviceProvider.savedTransactionApiFunction('INSURANCE-DATA');
    });
  }

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  int currentIndex = 0;
  int pinLength = 6;
  @override
  void initState() {
    super.initState();
    callInitFunction();
    for (int i = 0; i < pinLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void onNumberSelected(String number) {
    if (currentIndex < pinLength) {
      controllers[currentIndex].text = number;
      currentIndex++;
      if (currentIndex < pinLength) {
        focusNodes[currentIndex].requestFocus();
      }
    }
    String currentPin = controllers.map((controller) => controller.text).join();
    if (currentPin.length == pinLength) {
      print("currentPin...$currentPin");
    }
  }

  void onDelete() {
    if (currentIndex > 0) {
      currentIndex--;
      controllers[currentIndex].clear();
      focusNodes[currentIndex].requestFocus();
    }
  }




  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return Consumer<InsuranceProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          backgroundColor: AppColor.whiteF7Color,
          appBar: appBar(title: "Insurance Payment",backgroundColor: AppColor.whiteF7Color,),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 30),
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                savedTransactionWidget(serviceProvider),
                // ScreenSize.height(24),
                // CustomSearchBar(hintText: 'Search...',
                // isSearchIconColor: true,
                // ),
                ScreenSize.height(24),
                myProvider.model!=null&& myProvider.model!.data!=null?
                ListView.separated(
                  separatorBuilder: (context,index){
                    return ScreenSize.height(16);
                  },
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myProvider.model!.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                    var model = myProvider.model!.data![index];
                    return GestureDetector(
                      onTap: (){
                        myProvider.currentOperatorIndex = index;
                        AppRoutes.pushNavigation( InsuranceDetailsScreen(title: model.title,index: index,));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffFCFCFC),
                          borderRadius: BorderRadius.circular(8),
                          border:  Border.all(color: const Color(0xffF4F4F5))
                        ),
                        padding:const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              // padding:const EdgeInsets.only(right: 15,left: 15),
                              height: 29,
                              width: 29,
                              alignment: Alignment.center,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: NetworkImagehelper(
                                    img: model.image,
                                    height: 24.0,
                                    width:24.0,
                                  )),
                            ),
                            ScreenSize.width(8),
                            Expanded(
                              child: Text( model.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                  fontSize: 14, fontFamily: Constants.galanoGrotesqueRegular,
                                  color: const Color(0xff3F3F46), fontWeight: FontWeight.w400)),
                            ),
                            ScreenSize.width(4),
                            SvgPicture.asset(Images.arrowRightIcon,color: const Color(0xff3F3F46),)
                          ],
                        ),
                      ),
                    );
                }):Container()
              ],
            ),
          ),
        );
      }
    );
  }


  savedTransactionWidget(ServiceProvider serviceProvider){
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE4E4E7))
      ),
      padding:const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Row(
              children: [
                getText(title: 'Saved Transactions',
                    size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                const Spacer(),
                InkWell(
                  onTap: (){
                    AppRoutes.pushNavigation( InsuranceSavedTransactionScreen(model: serviceProvider.savedTransactionModel!,));
                  },
                  child: getText(title: 'See All',
                      size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                      color: AppColor.appColor, fontWeight: FontWeight.w400),
                ),
                ScreenSize.width(8),
                SvgPicture.asset(Images.arrowForwardIcon)
              ],
            ),
          ),
          ScreenSize.height(16),
          serviceProvider.savedTransactionModel!=null&&serviceProvider.savedTransactionModel!.data!=null?
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: serviceProvider.savedTransactionModel!.data!.map((e) {
                return Container(
                  margin:const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xffFAFAFA),
                      border: Border.all(color: const Color(0xffF4F4F5))
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    children: [
                      e.request!=null&&e.request!.operator!=null&& e.request!.operator!.image!=null?
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15) ,
                          child:NetworkImagehelper(
                            img: e.request!.operator!.image,
                            height: 29.0,
                            width: 29.0,
                          )
                      ):Container(),
                      ScreenSize.width(4),
                      e.request!=null?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getText(title:e.request!.operator!=null? e.request!.operator!.title??"":"",
                              size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                              color: const Color(0xff51525C), fontWeight: FontWeight.w500),
                          getText(title: e.request!.phone??"",
                              size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                              color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                          getText(title: '₦${e.amount??""}',
                              size: 12, fontFamily: Constants.galanoGrotesqueSemiBold,
                              color: const Color(0xff51525C), fontWeight: FontWeight.w600),
                        ],
                      ):Container()
                    ],
                  ),
                );
              }).toList(),
            ),
          ):Container()
        ],
      ),
    );
  }

}

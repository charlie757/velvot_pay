import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/buy_subscription_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/service/subscription/buy_saved_transaction_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/service/subscription/contact_number_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../../../helper/network_image_helper.dart';
import '../../../../../helper/session_manager.dart';
import '../../../../../provider/service_provider.dart';
import '../../../../../widget/custom_radio_button.dart';
import '../../../../../widget/row_column_confirmation_widget.dart';

class BuySubscriptionScreen extends StatefulWidget {
  const BuySubscriptionScreen({super.key});

  @override
  State<BuySubscriptionScreen> createState() => _BuySubscriptionScreenState();
}

class _BuySubscriptionScreenState extends State<BuySubscriptionScreen> {

  bool isCheckBox= false;

  final formKey = GlobalKey<FormState>();

  final pinController = TextEditingController();

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



  callInitFunction()async{
    final provider = Provider.of<BuySubscriptionProvider>(context,listen: false);
    final serviceProvider = Provider.of<ServiceProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      provider.resetValues();
      if(SessionManager.savedDataNumber.isNotEmpty){
        provider.numberController.text = SessionManager.savedDataNumber;
      }
      provider.callOperatorListApiFunction();
      serviceProvider.savedTransactionApiFunction('MOBILE-DATA');
    });
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return Consumer<BuySubscriptionProvider>(
      builder: (context,myProvider, child) {
        return Scaffold(
          appBar: appBar(title: 'Buy Mobile Data'),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 30),
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  savedTransactionWidget(serviceProvider),
                  ScreenSize.height(24),
                  numberWidget(myProvider),
                  ScreenSize.height(40),
                  tabBarWidget(myProvider),
                  ScreenSize.height(20),
                  myProvider.currentTabBarIndex==0?
                  hotPlanWidget(myProvider):
                  planWidget(myProvider, myProvider.currentTabBarIndex==1?myProvider.dailyPlans:
                  myProvider.currentTabBarIndex==2?myProvider.weeklyPlans:
                  myProvider.currentTabBarIndex==3?myProvider.biWeeklyPlans:
                  myProvider.currentTabBarIndex==4?myProvider.monthlyPlans:[]),
                ],
              ),
            ),
          ),
          bottomNavigationBar:  Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 15),
            child: CustomBtn(title: "Proceed to Payment", onTap: (){
              if(formKey.currentState!.validate()){
                if(myProvider.currentSelectedData!=-1){
                  SessionManager.setSavedDataNumber = myProvider.numberController.text;
                  confirmationBottomSheet(myProvider);
                }
                else{
                  Utils.showToast('Select your data plan');
                }
              }

              // confirmationBottomSheet();
              // mPinBottomSheet();
            }),
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
                    AppRoutes.pushNavigation( BuySavedTransactionScreen(model: serviceProvider.savedTransactionModel??null,));
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
                      e.request!=null&&e.request!.operator!=null?
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
                          getText(title: e.request!.phone??"",
                              size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                              color: const Color(0xff51525C), fontWeight: FontWeight.w500),
                          getText(title: e.request!.planName??'',
                              size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                              color: const Color(0xff51525C), fontWeight: FontWeight.w400),
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


  numberWidget(BuySubscriptionProvider provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Enter Mobile Number',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(hintText: 'Enter mobile number',
        controller: provider.numberController,
        fillColor: AppColor.whiteColor,
          borderRadius: 8,
          borderColor: const Color(0xffD1D1D6),
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          prefixWidget: GestureDetector(
            onTap: (){
              Utils.hideTextField();
              operatorBottomSheet(provider);
            },
            child: Container(
              width: 75,
              padding:const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  provider.model!=null&&provider.model!.data!=null?
                  Container(
                    height: 29,
                    width: 29,
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        border: Border.all(color: AppColor.e1Color),
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: NetworkImagehelper(
                          img: provider.model!.data![provider.currentOperatorIndex].image,
                          height: 47.0,
                          width: 47.0,
                        )),
                  ):Container(),
                  ScreenSize.width(4),
                  SvgPicture.asset(Images.arrowUpIcon)
                ],
              ),
            ),
          ),
          validator: (val) {
            if (val.isEmpty) {
              return "Enter your number";
            } else if (val.length < 10) {
              return 'Number should be valid';
            }
          },
        ),
        ScreenSize.height(12),
        Row(
          children: [
           GestureDetector(
             onTap: (){
               isCheckBox=!isCheckBox;
               SessionManager.setSavedDataNumber = provider.numberController.text;
               setState(() {
               });
             },
             child: Row(
               children: [
                 customCheckBox(AppColor.whiteColor),
                 ScreenSize.width(8),
                 getText(title: 'Save Phone Number', size: 12,
                     fontFamily: Constants.galanoGrotesqueRegular,
                     color: const Color(0xff3F3F46), fontWeight: FontWeight.w400),
               ],
             ),
           ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                AppRoutes.pushNavigation(const ContactNumberScreen()).then((value) {
                  print(value);
                  if(value!=null){
                    print(value);
                    provider.numberController.text = value;
                    setState(() {
                    });
                  }
                });
              },
              child: getText(title: 'Select from contact', size: 12,
                  fontFamily: Constants.galanoGrotesqueMedium,
                  color: AppColor.appColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),

      ],
    );
  }


  tabBarWidget(BuySubscriptionProvider provider){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rowColumnForTabBarWidget('Hot',0),
        rowColumnForTabBarWidget('Daily',1),
        rowColumnForTabBarWidget('Weekly',2),
        rowColumnForTabBarWidget('2-weeks',3),
        rowColumnForTabBarWidget('Monthly',4),
      ],
    );
  }



  rowColumnForTabBarWidget(String title,int index){
    return GestureDetector(
      onTap: (){
        Provider.of<BuySubscriptionProvider>(context,listen: false).currentSelectedData=-1;
        Provider.of<BuySubscriptionProvider>(context,listen: false).updateTabBarIndex(index);
        setState(() {
        });
      },
      child: SizedBox(
        height: 23,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getText(title: title, size: 12,
                fontFamily:
                index ==Provider.of<BuySubscriptionProvider>(context,listen: false).currentTabBarIndex?Constants.galanoGrotesqueMedium:
                Constants.galanoGrotesqueRegular, color:
                index ==Provider.of<BuySubscriptionProvider>(context,listen: false).currentTabBarIndex?
                    AppColor.appColor:
                const Color(0xff3F3F46), fontWeight:
                index ==Provider.of<BuySubscriptionProvider>(context,listen: false).currentTabBarIndex?
                    FontWeight.w700:
                FontWeight.w400),
          ScreenSize.height(5),
          index ==Provider.of<BuySubscriptionProvider>(context,listen: false).currentTabBarIndex?
          Container(
              height: 1,
              width: 40,
              decoration:const BoxDecoration(
                color: AppColor.appColor,
              ),
            ):Container()
          ],
        ),
      ),
    );
  }

  customCheckBox(Color color){
    return Container(
      height: 20,width: 20,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: color ==AppColor.whiteColor?  const Color(0xffD1D1D6):AppColor.appColor,),
        borderRadius: BorderRadius.circular(4)
      ),
      alignment: Alignment.center,
      child:const Icon(Icons.check,color: AppColor.whiteColor,size: 15,),
    );
  }

  hotPlanWidget(BuySubscriptionProvider provider,){
    return provider.dataModel!=null&&provider.dataModel!.data!=null&&
        provider.dataModel!.data!.varations!=null? GridView.builder(
      itemCount: provider.dataModel!.data!.varations!.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8
      ),
      itemBuilder: (context,index) {
        var model = provider.dataModel!.data!.varations![index];
        return GestureDetector(
          onTap:(){
           provider.savedDataList.clear();
            provider.currentSelectedData = index;
           provider.savedDataList.add(
                {'variation_code': model.variationCode,
                  'name': model.name,
                  'price': model.price,
                  'data': model.dataT,
                  'time': model.time,
                  'variation_amount': model.variationAmount,
                  'fixedPrice': model.fixedPrice}
              );
            setState(() {

            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color:
              provider.currentSelectedData ==index?
                  AppColor.appColor:
              const Color(0xffE4E4E7)),
              color: const Color(0xffF4F4F5),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getText(title: model.dataT??'',
                    size: 16, fontFamily: Constants.galanoGrotesqueMedium,
                    color: const Color(0xff3F3F46), fontWeight: FontWeight.w700),
                ScreenSize.height(3),
                getText(title: model.time??'',
                    size: 10, fontFamily: Constants.galanoGrotesqueRegular,
                    color: const Color(0xff3F3F46), fontWeight: FontWeight.w400),
                ScreenSize.height(2),
                getText(title: '₦${model.price??''}',
                    size: 10, fontFamily: Constants.galanoGrotesqueRegular,
                    color: const Color(0xff3F3F46), fontWeight: FontWeight.w400),
              ],
            ),
          ),
        );
      }
    ):Container();
  }

  planWidget(BuySubscriptionProvider provider, List list ){
    return list.isNotEmpty? GridView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
        ),
        itemBuilder: (context,index) {
          var model = list[index];
          return GestureDetector(
            onTap:(){
              provider.savedDataList.clear();
              provider.currentSelectedData = index;
              provider.savedDataList.add(
                  {'variation_code': model['variation_code'],
                    'name': model['name'],
                    'price': model['price'],
                    'data': model['data'],
                    'time': model['time'],
                    'variation_amount': model['variation_amount'],
                    'fixedPrice': model['fixedPrice']}
                );
              setState(() {

              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color:
                  provider.currentSelectedData ==index?
                  AppColor.appColor:
                  const Color(0xffE4E4E7)),
                  color: const Color(0xffF4F4F5),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getText(title: model['data']??'',
                      size: 16, fontFamily: Constants.galanoGrotesqueMedium,
                      color: const Color(0xff3F3F46), fontWeight: FontWeight.w700),
                  ScreenSize.height(3),
                  getText(title: model['time']??'',
                      size: 10, fontFamily: Constants.galanoGrotesqueRegular,
                      color: const Color(0xff3F3F46), fontWeight: FontWeight.w400),
                  ScreenSize.height(2),
                  getText(title: '₦${model['price']??''}',
                      size: 10, fontFamily: Constants.galanoGrotesqueRegular,
                      color: const Color(0xff3F3F46), fontWeight: FontWeight.w400),
                ],
              ),
            ),
          );
        }
    ):Container();
  }

  operatorBottomSheet(BuySubscriptionProvider provider){
      showModalBottomSheet(context: context,
          backgroundColor: AppColor.whiteColor,
          isScrollControlled: true,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8)
              )
          ),
          builder: (context){
            return StatefulBuilder(
                builder: (context,state) {
                  return Container(
                    padding:const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getText(title: 'Choose your Operator',
                                size: 17, fontFamily: Constants.poppinsMedium,
                                color: AppColor.blackColor, fontWeight: FontWeight.w500),
                            GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close,color: AppColor.blackColor,))
                          ],
                        ),
                        ScreenSize.height(25),
                        provider.model!=null&&provider.model!.data!=null?
                       ListView.separated(
                         separatorBuilder: (context,sp){
                           return ScreenSize.height(15);
                         },
                           itemCount: provider.model!.data!.length,
                           shrinkWrap: true,
                           itemBuilder: (context,index){
                             var model = provider.model!.data![index];
                         return  GestureDetector(
                           onTap: (){
                             provider.currentOperatorIndex=index;
                             Navigator.pop(context);
                            provider.getDataSubscriptionPlanApiFunction(model!.serviceID);
                             state((){});
                             setState(() {
                             });
                           },
                           child: Row(
                             children: [
                               Container(
                                 height: 47,
                                 width: 47,
                                 decoration: BoxDecoration(
                                     color: AppColor.whiteColor,
                                     border: Border.all(color: AppColor.e1Color),
                                     borderRadius: BorderRadius.circular(25)),
                                 alignment: Alignment.center,
                                 child: ClipRRect(
                                     borderRadius: BorderRadius.circular(25),
                                     child: NetworkImagehelper(
                                       img: model.image,
                                       height: 47.0,
                                       width: 47.0,
                                     )),
                               ),
                               ScreenSize.width(14),
                               Expanded(
                                 child: Text(
                                   model.title,
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(
                                       fontSize: 18,
                                       fontFamily: Constants.poppinsMedium,
                                       color: const Color(0xff484848),
                                       fontWeight: FontWeight.w500),
                                 ),
                               ),
                               ScreenSize.width(4),
                               SvgPicture.asset(Images.keyboardArrowRightIcon)
                             ],
                           ),
                         );
                       }):Container()
                      ],
                    ),
                  );
                }
            );
          });


  }

  confirmationBottomSheet(BuySubscriptionProvider provider,){
    showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.whiteColor
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8)
          )
        ),
        context: context,
        builder: (context){
          return Container(
            // color: AppColor.whiteColor,
            padding:const EdgeInsets.only(top: 30,left: 16,right: 16,bottom: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Images.logout),
                ScreenSize.height(16),
                getText(title: 'Are you sure?', size: 20,
                    fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w700),
                ScreenSize.height(4),
                getText(title: 'Confirm your details before proceeding',
                    size: 14, fontFamily: Constants.galanoGrotesqueRegular,
                    color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                ScreenSize.height(24),
                rowColumnForConfirmationWidget('Phone', provider.numberController.text),
                ScreenSize.height(16),
                rowColumnForConfirmationWidget('Tarrif', provider.savedDataList[0]['name']),
                ScreenSize.height(16),
                  rowColumnForConfirmationWidget('Transfer Amount', '₦${provider.savedDataList[0]['price']}'),
                ScreenSize.height(16),
                rowColumnForConfirmationWidget('Additional Fee', '₦${provider.dataModel!.data!.convinienceFee??''}'),
                ScreenSize.height(24),
                Container(
                  height: 1,
                  color:  Color(0xff7F808C33).withOpacity(.2),
                ),
                ScreenSize.height(24),
                rowColumnForConfirmationWidget('Total Payment', '₦${provider.savedDataList[0]['price']}'),
                ScreenSize.height(24),
                CustomBtn(title: "Confirm", onTap: (){
                  Navigator.pop(context);
                  mPinBottomSheet(provider);
                }),
                ScreenSize.height(16),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,alignment: Alignment.center,
                    child: getText(title: 'Go back',
                        size: 16, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          );
        });
  }

mPinBottomSheet(BuySubscriptionProvider provider){
 showModalBottomSheet(
   // isDismissible: false,
     isScrollControlled: true,
     backgroundColor: AppColor.whiteColor,
     shape: const OutlineInputBorder(
         borderSide: BorderSide(
             color: AppColor.whiteColor
         ),
         borderRadius: BorderRadius.only(
             topRight: Radius.circular(8),
             topLeft: Radius.circular(8)
         )
     ),
     context: context, builder: (context){
   return StatefulBuilder(
     builder: (context,state) {
       return WillPopScope(
         onWillPop: ()async{
           return  true;
         },
         child: Container(
           decoration:const BoxDecoration(
             color: AppColor.whiteColor,
             borderRadius: BorderRadius.only(
                 topRight: Radius.circular(8),
                 topLeft: Radius.circular(8)
             )
           ),
           padding:const EdgeInsets.only(top: 24,left: 16,right: 16,bottom: 20),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               getText(title: "Enter Pin", size: 16,
                   fontFamily: Constants.galanoGrotesqueMedium,
                   color: const Color(0xff080B30), fontWeight: FontWeight.w500),
               ScreenSize.height(24),
               SizedBox(
                 child:   Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: List.generate(pinLength, (index) {
                     print(index);
                     return pinTextField(index);
                   }),
                 ),
               ),
               ScreenSize.height(30),
               GridView.builder(
                   itemCount: 12,
                   shrinkWrap: true,
                   gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                       mainAxisSpacing: 12,
                       crossAxisSpacing: 12,
                       childAspectRatio: 16/10
                   ),
                   itemBuilder: (context,index){
                     return index==9?
                     Container():
                     index==11?
                     GestureDetector(
                       onTap: onDelete,
                       child: Container(
                         alignment: Alignment.center,
                         child: SvgPicture.asset(Images.cancelSvg),
                       ),
                     ):
                     GestureDetector(
                       onTap: (){
                         String number = index == 10 ? '0' : (index + 1).toString();
                         onNumberSelected(number);
                         state((){});
                         setState(() {
                         });
                       },
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: const Color(0xffF4F4F5),
                         ),
                         alignment: Alignment.center,
                         child: getText(title:index==10?'0': (index+1).toString(),
                             size: 24, fontFamily: Constants.galanoGrotesqueMedium,
                             color: const Color(0xff26272B), fontWeight: FontWeight.w500),
                       ),
                     );
                   }),
               ScreenSize.height(20),
               CustomBtn(title: 'Continue', onTap: (){
                 String pin = controllers.map((controller) => controller.text).join().toString();
                 if(pin.length<6){
                   Utils.showToast('Set your pin');
                 }
                 else{
                   provider.checkPinApiFunction(pin);
                 }
               })
             ],
           ),
         ),
       );
     }
   );
 });
}


  pinTextField(index){
    return Container(
      height: 16,width: 16,
      margin:const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        readOnly: true,
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.none, // Disable keyboard
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: AppColor.grayIronColor,
            fontFamily: Constants.galanoGrotesqueRegular),

        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: controllers[index].text.isNotEmpty? const Color(0xff131316): const Color(0xffF4F4F5),
          border: OutlineInputBorder(
              borderSide:const BorderSide(color:  Color(0xffF4F4F5), width: 1),
              borderRadius: BorderRadius.circular(100)),
          enabledBorder: OutlineInputBorder(
              borderSide:const BorderSide(color:  Color(0xffF4F4F5), width: 1),
              borderRadius: BorderRadius.circular(100)),
          focusedBorder: OutlineInputBorder(
              borderSide:const BorderSide(color: AppColor.appColor, width: 1),
              borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }


}

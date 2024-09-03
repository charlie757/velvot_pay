import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/provider/electricity_provider.dart';
import 'package:velvot_pay/provider/service_provider.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';
import '../../../../../approutes/app_routes.dart';
import '../../../../../helper/app_color.dart';
import '../../../../../helper/getText.dart';
import '../../../../../helper/images.dart';
import '../../../../../helper/network_image_helper.dart';
import '../../../../../helper/screen_size.dart';
import '../../../../../utils/Constants.dart';
import '../../../../../widget/custom_radio_button.dart';
import '../../../../../widget/row_column_confirmation_widget.dart';
import 'electricity_saved_transaction_screen.dart';

class BuyElectricityScreen extends StatefulWidget {
  const BuyElectricityScreen({super.key});

  @override
  State<BuyElectricityScreen> createState() => _BuyElectricityScreenState();
}

class _BuyElectricityScreenState extends State<BuyElectricityScreen> {

  List savedTransactionList = ['',''];
  final formKey = GlobalKey<FormState>();

  callInitFunction()async{
    final provider = Provider.of<ElectricityProvider>(context,listen: false);
    final serviceProvider = Provider.of<ServiceProvider>(context,listen: false);
    provider.resetValues();
    Future.delayed(Duration.zero,(){
      provider.callOperatorListApiFunction();
      serviceProvider.savedTransactionApiFunction('ELECTRICITY-BILL-PAYMENT');
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
    return Consumer<ElectricityProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          backgroundColor: AppColor.whiteF7Color,
          appBar: appBar(title: 'Buy Electricity',backgroundColor: AppColor.whiteF7Color,),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 25),
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  savedTransactionWidget(serviceProvider),
                  ScreenSize.height(24),
                  getText(title: 'Select Provider',
                      size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                      color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                  ScreenSize.height(8),
                  CustomTextField(hintText: 'Select provider',
                  fillColor: const Color(0xffF9FAFB),
                    borderColor: const Color(0xffD1D1D6),
                    isReadOnly: true,
                    controller: myProvider.providerController,
                    borderRadius: 8,
                    suffixWidget: Container(
                      width: 20,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(Images.arrowUpIcon),
                    ),
                    onTap: (){
                      operatorBottomSheet(myProvider);
                    },
                    prefixWidget: myProvider.currentOperatorIndex!=-1?
                      Container(
                        // padding:const EdgeInsets.only(right: 15,left: 15),
                        height: 29,
                        width: 29,
                        alignment: Alignment.center,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: NetworkImagehelper(
                              img: myProvider.model!.data![myProvider.currentOperatorIndex].image,
                              height: 24.0,
                              width:24.0,
                            )),
                      ):null,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Select provider';
                      }
                    },
                  ),
                  ScreenSize.height(24),
                  getText(title: 'Meter Type',
                      size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                      color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                  ScreenSize.height(8),
                  CustomTextField(hintText: 'Select meter type',
                    controller: myProvider.meterTypeController,
                    isReadOnly: true,
                    fillColor: const Color(0xffF9FAFB),
                    borderColor: const Color(0xffD1D1D6),
                    borderRadius: 8,
                    suffixWidget: Container(
                      width: 20,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(Images.arrowUpIcon),
                    ),
                    onTap: (){
                    if(myProvider.providerController.text.isNotEmpty){
                      meterTypeBottomSheet(myProvider);
                    }
                    else{
                      Utils.errorSnackBar('Select provider', context);
                    }

                    },
                    validator: (val){
                    if(val.isEmpty){
                      return 'Select meter type';
                    }
                    },
                  ),
                  ScreenSize.height(24),
                  getText(title: 'Meter Number',
                      size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                      color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                  ScreenSize.height(8),
                  CustomTextField(hintText: 'Enter meter number',
                    controller: myProvider.meterNumberController,
                    fillColor: const Color(0xffF9FAFB),
                    borderColor: const Color(0xffD1D1D6),
                    borderRadius: 8,
                    isReadOnly: true,
                    // onChanged: (val){
                    // if(val.length==10){
                    //   myProvider.electricityBillDetailsApiFunction();
                    // }
                    // },
                    // validator: (val) {
                    //   if (val.isEmpty) {
                    //     return "Enter your number";
                    //   } else if (val.length < 10) {
                    //     return 'Number should be valid';
                    //   }
                    // },
                  ),
                  myProvider.electricityPlanModel!=null&& myProvider.electricityPlanModel!.data!=null?
                  Container(
                    margin:const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffE4E4E7),
                      borderRadius: BorderRadius.circular(32)
                    ),
                    padding:const EdgeInsets.symmetric(horizontal: 14,vertical: 4),
                    child: getText(title:
                    myProvider.electricityPlanModel!.data!.customerName??'',
                        size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                        color: const Color(0xff3F3F46), fontWeight: FontWeight.w400),
                  ):Container(),
                  ScreenSize.height(24),
                  Row(
                    children: [
                      getText(title: 'Amount',
                          size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                          color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                      getText(title: ' (₦)',
                          size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                          color: AppColor.grayIronColor, fontWeight: FontWeight.w700),
                    ],
                  ),
                  ScreenSize.height(8),
                  CustomTextField(hintText: 'Enter amount',
                    controller: myProvider.amountController,
                    isReadOnly: true,
                    fillColor: const Color(0xffF9FAFB),
                    borderColor: const Color(0xffD1D1D6),
                    textInputType: TextInputType.number,
                    borderRadius: 8,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val){
                      int amount =val.isNotEmpty? int.parse(val.toString()):0;
                      if(val.isEmpty){
                        return 'Enter your amount';
                      }
                      else if (amount < 50 || amount > 1000) {
                        return 'Amount should be between 50 and 1000';
                      }
                    },
                  ),
                  ScreenSize.height(24),
                  CustomBtn(title: 'Proceed to Payment', onTap: (){
                    if(formKey.currentState!.validate()){

                      confirmationBottomSheet(myProvider);
                    }
                  })
                ],
              ),
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
                    AppRoutes.pushNavigation( ElectricitySavedTransactionScreen(model: serviceProvider.savedTransactionModel!=null?serviceProvider.savedTransactionModel!:null,));
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15) ,
                          child:NetworkImagehelper(
                            img: e.request!.operator!.image,
                            height: 29.0,
                            width: 29.0,
                          )
                      ), ScreenSize.width(4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(
                          children: [
                            Text( e.request!.operator!.title,
                                style: TextStyle(
                                fontSize: 12, fontFamily: Constants.galanoGrotesqueMedium,
                                color: const Color(0xff51525C), fontWeight: FontWeight.w500)),
                            ScreenSize.width(8),
                            getText(title: e.request!.operator!.type??'',
                                size: 10, fontFamily: Constants.galanoGrotesqueRegular,
                                color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                          ],
                        ),
                          getText(title: e.request!.phone,
                              size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                              color: const Color(0xff51525C), fontWeight: FontWeight.w400),
                          getText(title: '₦${e.amount}',
                              size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                              color: AppColor.grayIronColor, fontWeight: FontWeight.w700),
                        ],
                      )
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
  operatorBottomSheet(ElectricityProvider provider){
    showModalBottomSheet(context: context,
        // isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
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
                  height: MediaQuery.of(context).size.height*0.9,
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
                      Expanded(
                        child: ListView.separated(
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
                                  provider.providerController.text = model.title;
                                  Navigator.pop(context);
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
                            }),
                      ):Container()
                    ],
                  ),
                );
              }
          );
        });


  }
  meterTypeBottomSheet(ElectricityProvider provider){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
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
                  padding:const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getText(title: 'Meter Type',
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
                      GestureDetector(
                        onTap: (){
                          provider.updateBillTypeIndex(0);
                          provider.meterTypeController.text = 'Prepaid';
                          provider.meterNumberController.text = '1111111111111';
                          provider.amountController.text = '1000';
                          Navigator.pop(context);
                          provider.electricityBillDetailsApiFunction();
                          state((){});
                        },
                        child: Container(
                          // color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadioButton(provider.selectedBillTypeIndex==0?true:false,),
                              ScreenSize.width(10),
                              Text('Prepaid',
                                  style: TextStyle(
                                    fontFamily:Constants.poppinsMedium,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    color: AppColor.blackColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      ScreenSize.height(10),
                      GestureDetector(
                        onTap: (){
                          provider.updateBillTypeIndex(1);
                          provider.meterTypeController.text = 'Postpaid';
                          provider.meterNumberController.text = '1010101010101';
                          provider.amountController.text = '1000';
                          Navigator.pop(context);
                          provider.electricityBillDetailsApiFunction();
                          state((){});
                        },
                        child: SizedBox(
                          // color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadioButton(provider.selectedBillTypeIndex==1?true:false,),
                              ScreenSize.width(10),
                              Text("Postpaid",
                                  style: TextStyle(
                                    fontFamily:Constants.poppinsMedium,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    color: AppColor.blackColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        });
  }


  confirmationBottomSheet(ElectricityProvider provider,){
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
                rowColumnForConfirmationWidget('Name', provider.electricityPlanModel!.data!.customerName??""),
                ScreenSize.height(16),
                rowColumnForConfirmationWidget('Meter No', provider.meterNumberController.text),
                ScreenSize.height(16),
                rowColumnForConfirmationWidget('Meter Type', provider.meterTypeController.text),
                ScreenSize.height(16),
                rowColumnForConfirmationWidget('Transfer Amount', '₦${provider.amountController.text}'),
                ScreenSize.height(16),
                rowColumnForConfirmationWidget('Additional Fee', '₦0'),
                ScreenSize.height(24),
                Container(
                  height: 1,
                  color:  Color(0xff7F808C33).withOpacity(.2),
                ),
                ScreenSize.height(24),
                rowColumnForConfirmationWidget('Total Payment', '₦${provider.amountController.text}'),
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


  mPinBottomSheet(ElectricityProvider provider){
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

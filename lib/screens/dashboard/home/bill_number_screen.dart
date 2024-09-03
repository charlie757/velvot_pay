import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/bill_number_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/pay_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/utils/uppercase_text_formatter.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';
import '../../../helper/network_image_helper.dart';
import '../../../widget/custom_radio_button.dart';

class BillNumberScreen extends StatefulWidget {
  final String route;
  final String? serviceId;
  final String? operatorName;
  final  String? operatorImage;
  final String? minimiumAmount;
  final String? maximumAmount;
  final String? number;
  final String? isFromSearchNumberRoute;
  BillNumberScreen({required this.route, this.serviceId, this.operatorName, this.operatorImage,this.minimiumAmount,this.maximumAmount,this.number,
  this.isFromSearchNumberRoute
  });

  @override
  State<BillNumberScreen> createState() => _BillNumberScreenState();
}

class _BillNumberScreenState extends State<BillNumberScreen> {
@override
  void initState() {
    // TODO: implement initState
  callInitFunction();
    super.initState();
  }

  callInitFunction(){
  final provider = Provider.of<BillNumberProvider>(context,listen: false);
  provider.resetValues();
  if(widget.route=='topup'){
    provider.controller1.text = widget.number!??'';
  }
  if(widget.route=='insurance-health'){
    Future.delayed(Duration.zero,(){
      provider.getHospitalApiFunction();
    });
  }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BillNumberProvider>(builder: (context,myProvider,child){
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBar(
              title: widget.route == 'electricity'
                  ? 'Electricity Bill Number'
                  :widget.route=='education'?
              "Education Bill Number":
              widget.route =='tv'
                      ? "TV Subscription Bill Number"
                      :widget.route.contains('insurance')? "Insurance Payment":
              widget.route=='topup'?"Mobile Top up": "",
              onTap: () {
                Navigator.pop(context);
              }),
          body:  Form(
            key: myProvider.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 30),
              child: Column(
                children: [
                  formWidget(myProvider),
                  ScreenSize.height(15),
                  desclimierWidget(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 10,right:10,bottom: 20),
            child: CustomBtn(title: "Continue",
                onTap: (){
              myProvider.checkValidation(widget.serviceId.toString(),widget.operatorName.toString(),widget.operatorImage.toString(),
                  widget.minimiumAmount??'',widget.maximumAmount??'',
                  widget.route, widget.isFromSearchNumberRoute??'');
                }),
          ),
        );
      }
    );
  }

  formWidget(BillNumberProvider provider) {
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
                  color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(25)),
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: NetworkImagehelper(
                      img: widget.operatorImage,
                      height: 47.0,
                      width: 47.0,
                    )),
              ),
              ScreenSize.width(14),
              Expanded(
                child: Text(
                  widget.operatorName.toString(),
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
          widget.route == 'electricity'
              ? electriityWidget(provider)
              :widget.route=='education'?
          instituteWidget(provider):
          widget.route == 'tv'
                  ? tvSubscriptionWidget(provider)
                  : widget.route=='insurance-third party'?
          insuranceWidget(provider):widget.route=='insurance-personal'?
              personalInsuranceWidget(provider):
              widget.route=='insurance-health'?
          healthInsuranceWidget(provider):
              widget.route =='topup'?
              mobileTopUpWidget(provider):
              Container()
        ],
      ),
    );
  }

  electriityWidget(BillNumberProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: AppColor.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(hintText: 'Enter Your Amount',controller: provider.amountController,
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (val){
              if(val.isEmpty){
                return "Enter your amount";
              }
            },
          ),
          ScreenSize.height(12),
          CustomTextField(hintText: 'Enter Your Meter Number',controller: provider.meterNumberController,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(13)
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter your meter number";
            }
          },
          ),
          // ScreenSize.height(7),
          // getText(
          //     title: 'Please enter a valid 12 digit Meter Number',
          //     size: 11,
          //     fontFamily: Constants.poppinsRegular,
          //     color: AppColor.whiteColor,
          //     fontWeight: FontWeight.w400),
          ScreenSize.height(12),
          CustomTextField(hintText: 'Select your bill type',
            controller: provider.typeController,
            suffixWidget:const Icon(Icons.keyboard_arrow_down),
            isReadOnly: true,
            validator: (val){
              if(val.isEmpty){
                return "Select your bill type";
              }
            },
            onTap: (){
              billTypeBottomSheet(provider);
            },),
        ],
      ),
    );
  }

  tvSubscriptionWidget(BillNumberProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: AppColor.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(hintText: 'Enter Your Tv Subscription Number',controller: provider.tVController,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter the number";
            }
          },),
        ],
      ),
    );
  }

instituteWidget(BillNumberProvider provider){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
        color: AppColor.hintTextColor,
        borderRadius: BorderRadius.circular(5)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(hintText: 'Enter Your Institute Number',controller: provider.instituteController,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter the institute number";
            }
            else if(val.length<10){
              return "Enter digit should be 10";
            }
          },),
      ],
    ),
  );
}

mobileTopUpWidget(BillNumberProvider provider){
return Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  decoration: BoxDecoration(
      color: AppColor.hintTextColor,
      borderRadius: BorderRadius.circular(5)),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomTextField(
        hintText: 'Enter Your Mobile Number',
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.number,
        isReadOnly: true,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
        ],
        controller: provider.controller1,
        validator: (val){
          if(val.isEmpty){
            return "Enter your mobile number";
          }
          else if (val.length < 10) {
            return 'Number should be valid';
          }
        },
      ),
      ScreenSize.height(12),
      CustomTextField(
        hintText: 'Enter Amount',
        textInputAction: TextInputAction.done,
        controller: provider.controller2,
        textInputType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (val){
          if(val.isEmpty){
            return "Enter amount";
          }
          int amount = int.parse(val);
          if (amount < int.parse(widget.minimiumAmount.toString()) || amount > int.parse(widget.maximumAmount.toString())) {
            return "Enter amount should be between ${widget.minimiumAmount.toString()} and ${widget.maximumAmount.toString()}";
          }
        },),
    ],
  ),
);
}

  insuranceWidget(BillNumberProvider provider) {
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
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.deny(
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
              // FilteringTextInputFormatter.allow(Utils.alphanumericRegex)
            ],
            controller: provider.controller1,
            validator: (val){
              if(val.isEmpty){
                return "Enter your vehicle number";
              }
            },
          ),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Owner Name',
              textInputAction: TextInputAction.next,
            controller: provider.controller2,
            validator: (val){
            if(val.isEmpty){
              return "Enter your owner name";
            }
          },),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Engine Number',
              textInputAction: TextInputAction.next,
            controller: provider.controller3,
            validator: (val){
            if(val.isEmpty){
              return "Enter engine number";
            }
          },),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Chassis Number',
              textInputAction: TextInputAction.next,
            controller: provider.controller4,
            validator: (val){
              if(val.isEmpty){
                return "Enter chassis number";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Maker',
              textInputAction: TextInputAction.next,
            controller: provider.controller5,
            validator: (val){
              if(val.isEmpty){
                return "Enter vehicle maker";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Color',
              textInputAction: TextInputAction.next,controller: provider.controller6,
            validator: (val){
              if(val.isEmpty){
                return "Enter vehicle color";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Vehicle Model',
              textInputAction: TextInputAction.next,
            controller: provider.controller7,
            validator: (val){
              if(val.isEmpty){
                return "Enter vehicle model";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
            hintText: 'Enter vehicle purchased year',
            textInputAction: TextInputAction.next,
            controller: provider.controller8,
            validator: (val){
              if(val.isEmpty){
                return "Enter vehicle year";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
              hintText: 'Enter Your Address',
              textInputAction: TextInputAction.done,
            controller: provider.controller9,
            validator: (val){
              if(val.isEmpty){
                return "Enter your address";
              }
            },),
        ],
      ),
    );
  }

  personalInsuranceWidget(BillNumberProvider provider){
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: AppColor.hintTextColor,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: 'Enter Your Full Name',
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
              ],
              controller: provider.controller1,
              validator: (val){
                if(val.isEmpty){
                  return "Enter full name";
                }
              },
            ),
            ScreenSize.height(12),
            CustomTextField(
              hintText: 'Enter Your Mobile Number',
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
              controller: provider.controller2,
              validator: (val){
                if(val.isEmpty){
                  return "Enter mobile number";
                }
              },),
            ScreenSize.height(12),
            CustomTextField(
              hintText: 'Enter Your Address',
              textInputAction: TextInputAction.next,
              controller: provider.controller3,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
              ],
              validator: (val){
                if(val.isEmpty){
                  return "Enter address";
                }
              },),
            ScreenSize.height(12),
            CustomTextField(
              hintText: 'Enter Your Business Occupation',
              textInputAction: TextInputAction.next,
              controller: provider.controller4,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
              ],
              validator: (val){
                if(val.isEmpty){
                  return "Enter business occupation";
                }
              },),
            ScreenSize.height(12),
            CustomTextField(
              hintText: 'Select Your DOB',
              textInputAction: TextInputAction.next,
              isReadOnly: true,
              controller: provider.controller5,
              validator: (val){
                if(val.isEmpty){
                  return "Select DOB";
                }
              },onTap: (){
              provider.datePicker().then((value) {
                if(value!=null){
                  var day, month, year;
                  day = value.day < 10 ? '0${value.day}' : value.day;
                  month = value.month < 10
                      ? '0${value.month}'
                      : value.month;
                  year = value.year;
                  provider.controller5.text="${value.year}-$month-$day";
                }
              });
            },),
            ],
        ),
      );

  }
  healthInsuranceWidget(BillNumberProvider provider){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: AppColor.hintTextColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hintText: 'Enter Your Full Name',
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            ],
            controller: provider.controller1,
            validator: (val){
              if(val.isEmpty){
                return "Enter full name";
              }
            },
          ),
          ScreenSize.height(12),
          CustomTextField(
            hintText: 'Enter Your Mobile Number',
            textInputAction: TextInputAction.next,
            controller: provider.controller2,
            textInputType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            ],
            validator: (val){
              if(val.isEmpty){
                return "Enter mobile number";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
            hintText: 'Enter Your Address',
            textInputAction: TextInputAction.next,
            controller: provider.controller3,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            ],
            validator: (val){
              if(val.isEmpty){
                return "Enter address";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
            hintText: 'Select Your DOB',
            textInputAction: TextInputAction.next,
            isReadOnly: true,
            controller: provider.controller4,
            validator: (val){
              if(val.isEmpty){
                return "Select DOB";
              }
            },onTap: (){
            provider.datePicker().then((value) {
              if(value!=null){
                var day, month, year;
                day = value.day < 10 ? '0${value.day}' : value.day;
                month = value.month < 10
                    ? '0${value.month}'
                    : value.month;
                year = value.year;
                provider.controller4.text="${value.year}-$month-$day";
              }
            });
          },),
          ScreenSize.height(12),
          CustomTextField(
            isReadOnly: true,
            hintText: 'Select hospital',
            onTap: (){
              hospitalBottomSheet(provider);
            },
            textInputAction: TextInputAction.next,
            controller: provider.controller5,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            ],
            validator: (val){
              if(val.isEmpty){
                return "Select hospital";
              }
            },),
          ScreenSize.height(12),
          CustomTextField(
            hintText: 'Enter your description',
            textInputAction: TextInputAction.next,
            controller: provider.controller6,
            maxLines: 4,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
            ],
            validator: (val){
              if(val.isEmpty){
                return "Enter your description";
              }
            },),
          ScreenSize.height(12),
          getText(title: 'Passport Photo',
              size: 14, fontFamily: Constants.poppinsRegular,
              color: AppColor.blackColor, fontWeight: FontWeight.w400),
          ScreenSize.height(6),
          GestureDetector(
            onTap: (){
              imagePickerBottomSheet(provider);
            },
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child:provider.file!=null?
               ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child:  Image.file(File(provider.file!.path),fit: BoxFit.cover,),):
              const Icon(Icons.add),
            ),
          ),

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
              'Pay ${widget.route == 'electricity' ? "electricity bill" :widget.route=='education'?"Institute bill": widget.route == 'tv' ? "TV Subscription bill" :widget.route == 'insurance'? "Insurance bill":
              widget.route == 'topup'?"Mobile Top up bill":''
              } safely, conveniently & easily. You can pay anytime and anyere!',
          size: 14,
          fontFamily: Constants.poppinsRegular,
          color: AppColor.darkBlackColor,
          fontWeight: FontWeight.w400),
    );
  }


  billTypeBottomSheet(BillNumberProvider provider){
    showModalBottomSheet(context: context,
        backgroundColor: AppColor.whiteColor,
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15)
            )
        ),
        builder: (context){
          return StatefulBuilder(
            builder: (context,state) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius:const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)
                    )
                ),
                padding:const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(title: 'Bill Type',
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
                        provider.typeController.text = 'Prepaid';
                        Navigator.pop(context);
                        state((){});
                      },
                      child: Container(
                        color: AppColor.whiteColor,
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
                        provider.typeController.text = 'Postpaid';
                        Navigator.pop(context);
                        state((){});
                      },
                      child: Container(
                        color: AppColor.whiteColor,
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


  imagePickerBottomSheet(BillNumberProvider profileProvider) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColor.whiteColor,
        builder: (context) {
          return Container(
            padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(
                        title: 'Profile Photo',
                        size: 17,
                        fontFamily: Constants.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close))
                  ],
                ),
                ScreenSize.height(25),
                Row(
                  children: [
                    imagePickType(Icons.camera_alt_outlined, "Camera", () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.camera);
                    }),
                    ScreenSize.width(30),
                    imagePickType(Icons.image_outlined, "Gallery", () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.gallery);
                    }),
                  ],
                )
              ],
            ),
          );
        });
  }

  imagePickType(icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.hintTextColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColor.lightAppColor,
            ),
          ),
          ScreenSize.height(5),
          getText(
              title: title,
              size: 14,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }

  hospitalBottomSheet(BillNumberProvider provider){
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15)
          )
      ),
      context: context, builder: (context){
    return Container(
      height: MediaQuery.of(context).size.height*.9,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius:const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15)
          )
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getText(title: 'Select Hospital',
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
          // CustomTextField(hintText: 'Search hospital...',
          //   onChanged: (val){
          //     if(val.isEmpty){
          //       provider.noDataFound=false;
          //       // myProvider.isSearch=false;
          //       provider.searchList.clear();
          //       setState(() {
          //       });
          //     }
          //     else{
          //       provider.searchFunction(val);
          //     }
          //
          //   },
          // ),
          // ScreenSize.height(10),
          Expanded(
            child:provider.noDataFound?
            Container(
              height: 100,
              alignment: Alignment.center,
              child: getText(title: "No data found", size: 15,
                  fontFamily: Constants.poppinsMedium, color: AppColor.redColor, fontWeight: FontWeight.w400),
            ):
            ListView.separated(
                separatorBuilder: (context,sp){
                  return ScreenSize.height(20);
                },
                itemCount:
                provider.hospitalModel!.data!.length,
                padding:const EdgeInsets.only(bottom: 20),
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var model =  provider.hospitalModel!.data![index];
                  return GestureDetector(
                    onTap: (){
                      provider.changeHospital(model.value, model.label, index);
                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding:const EdgeInsets.only(top: 8),
                          child: customRadioButton(provider.selectedHospitalIndex==index?true:false,),
                        ),
                        ScreenSize.width(10),
                        Flexible(
                          child: getText(title: model.label,
                              size: 16,
                              fontFamily: Constants.poppinsRegular,
                              color: AppColor.blackColor, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  });
  }

}

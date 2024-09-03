import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/provider/insurance_provider.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../helper/app_color.dart';
import '../../../../../helper/custom_textfield.dart';
import '../../../../../helper/getText.dart';
import '../../../../../helper/images.dart';
import '../../../../../helper/screen_size.dart';
import '../../../../../utils/Constants.dart';
import '../../../../../utils/uppercase_text_formatter.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widget/custom_radio_button.dart';
import '../../../../../widget/row_column_confirmation_widget.dart';

class InsuranceDetailsScreen extends StatefulWidget {
  final String title;
  final int index;
  const InsuranceDetailsScreen({required this.title, required this.index});

  @override
  State<InsuranceDetailsScreen> createState() => _InsuranceDetailsScreenState();
}

class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> {

  final formKey = GlobalKey<FormState>();

  callInitFunction(){
    final provider = Provider.of<InsuranceProvider>(context,listen: false);
    provider.clearControllers();
    if(widget.index==1){
      Future.delayed(Duration.zero,(){
        provider.getHospitalApiFunction();
      });
    }
  }

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  int currentIndex = 0;
  int pinLength = 6;

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    for (int i = 0; i < pinLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }

    super.initState();
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

    return Consumer<InsuranceProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          appBar: appBar(title: widget.title),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.index==0?insuranceWidget(myProvider):
                      widget.index==1?healthInsuranceWidget(myProvider):
                  personalInsuranceWidget(myProvider)
                 ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(padding:const EdgeInsets.only(left: 16,right: 16,bottom: 25),
          child: CustomBtn(title: "Proceed to Payment", onTap: (){
            if(formKey.currentState!.validate()){
              if(widget.index==1){
                if(myProvider.file==null){
                  Utils.errorSnackBar('Please upload passport photo', context);
                }
                else{
                  confirmationBottomSheet(myProvider);
                }
              }
              else{
                confirmationBottomSheet(myProvider);
              }
            }
          }),
          ),
        );
      }
    );
  }

  healthInsuranceWidget(InsuranceProvider myProvider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Full Name',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Full Name',
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          controller: myProvider.controller1,
          validator: (val){
            if(val.isEmpty){
              return "Enter full name";
            }
          },
        ),
        ScreenSize.height(24),
        getText(title: 'Phone Number',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Mobile Number',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          controller: myProvider.controller2,
          validator: (val){
            if(val.isEmpty){
              return "Enter mobile number";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Address',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Address',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          controller: myProvider.controller3,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter address";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Select Hospital',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          isReadOnly: true,
          hintText: 'Select hospital',
          onTap: (){
            hospitalBottomSheet(myProvider);
          },
          textInputAction: TextInputAction.next,
          controller: myProvider.controller4,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          suffixWidget: Container(
            width: 20,
            alignment: Alignment.center,
            child: SvgPicture.asset(Images.arrowUpIcon),
          ),
          validator: (val){
            if(val.isEmpty){
              return "Select hospital";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'DOB',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Select Your DOB',
          textInputAction: TextInputAction.done,

          isReadOnly: true,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          controller: myProvider.controller5,
          validator: (val){
            if(val.isEmpty){
              return "Select DOB";
            }
          },onTap: (){
          myProvider.datePicker().then((value) {
            if(value!=null){
              var day, month, year;
              day = value.day < 10 ? '0${value.day}' : value.day;
              month = value.month < 10
                  ? '0${value.month}'
                  : value.month;
              year = value.year;
              myProvider.controller5.text="${value.year}-$month-$day";
            }
          });
        },),
        ScreenSize.height(24),
        getText(title: 'Description',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter your description',
          textInputAction: TextInputAction.next,
          controller: myProvider.controller6,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          maxLines: 4,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter your description";
            }
          },),
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
            else if (amount < 50) {
              return 'Amount should be greater than 50';
            }
          },
        ),
        ScreenSize.height(24),
        getText(title: 'Passport Photo',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        GestureDetector(
          onTap: (){
            imagePickerBottomSheet(myProvider);
          },
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                border: Border.all(color: const Color(0xffD1D1D6)),
                borderRadius: BorderRadius.circular(10)
            ),
            child:myProvider.file!=null?
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:  Image.file(File(myProvider.file!.path),fit: BoxFit.cover,),):
            const Icon(Icons.add),
          ),
        ),
      ],
    );

  }


  personalInsuranceWidget(InsuranceProvider myProvider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Full Name',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Full Name',
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          controller: myProvider.controller1,
          validator: (val){
            if(val.isEmpty){
              return "Enter full name";
            }
          },
        ),
        ScreenSize.height(24),
        getText(title: 'Phone Number',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Mobile Number',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          controller: myProvider.controller2,
          validator: (val){
            if(val.isEmpty){
              return "Enter mobile number";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Address',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Address',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          controller: myProvider.controller3,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter address";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Business Occupation',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Business Occupation',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          controller: myProvider.controller4,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji)),
          ],
          validator: (val){
            if(val.isEmpty){
              return "Enter business occupation";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'DOB',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Select Your DOB',
          textInputAction: TextInputAction.done,
          isReadOnly: true,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          controller: myProvider.controller5,
          validator: (val){
            if(val.isEmpty){
              return "Select DOB";
            }
          },onTap: (){
          myProvider.datePicker().then((value) {
            if(value!=null){
              var day, month, year;
              day = value.day < 10 ? '0${value.day}' : value.day;
              month = value.month < 10
                  ? '0${value.month}'
                  : value.month;
              year = value.year;
              myProvider.controller5.text="${value.year}-$month-$day";
            }
          });
        },),
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
            else if (amount < 50) {
              return 'Amount should be greater than 50';
            }
          },
        ),
      ],
    );
  }

  insuranceWidget(InsuranceProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Vehicle Number',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Vehicle Number',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
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
        ScreenSize.height(24),
        getText(title: 'Owner Name',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Vehicle Owner Name',
          textInputAction: TextInputAction.next,
          controller: provider.controller2,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          validator: (val){
            if(val.isEmpty){
              return "Enter your owner name";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Engine Number',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Engine Number',
          textInputAction: TextInputAction.next,
          controller: provider.controller3,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          validator: (val){
            if(val.isEmpty){
              return "Enter engine number";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Chassis Number',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Chassis Number',
          textInputAction: TextInputAction.next,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          controller: provider.controller4,
          validator: (val){
            if(val.isEmpty){
              return "Enter chassis number";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Vehicle Maker',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Vehicle Maker',
          textInputAction: TextInputAction.next,
          controller: provider.controller5,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          validator: (val){
            if(val.isEmpty){
              return "Enter vehicle maker";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Vehicle Color',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Vehicle Color',
          textInputAction: TextInputAction.next,controller: provider.controller6,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          validator: (val){
            if(val.isEmpty){
              return "Enter vehicle color";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Vehicle Model',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Vehicle Model',
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          textInputAction: TextInputAction.next,
          controller: provider.controller7,
          validator: (val){
            if(val.isEmpty){
              return "Enter vehicle model";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Vehicle Purchased Year',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter vehicle purchased year',
          textInputAction: TextInputAction.next,
          controller: provider.controller8,
          textInputType: TextInputType.number,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          validator: (val){
            if(val.isEmpty){
              return "Enter vehicle year";
            }
          },),
        ScreenSize.height(24),
        getText(title: 'Address',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(8),
        CustomTextField(
          hintText: 'Enter Your Address',
          textInputAction: TextInputAction.next,
          controller: provider.controller9,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
          validator: (val){
            if(val.isEmpty){
              return "Enter your address";
            }
          },),
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
          controller: provider.amountController,
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
            else if (amount < 50) {
              return 'Amount should be greater than 50';
            }
          },
        ),
      ],
    );
  }


  hospitalBottomSheet(InsuranceProvider provider){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8)
            )
        ),
        context: context, builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height*.9,
        decoration:const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius:const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8)
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
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color:
                            provider.selectedHospitalIndex==index?
                            AppColor.appColor:
                            const Color(0xffD1D1D6),)
                        ),
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
                      ),
                    );
                  }),
            )
          ],
        ),
      );
    });
  }



  imagePickerBottomSheet(InsuranceProvider provider) {
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
                      provider.imagePicker(ImageSource.camera);
                    }),
                    ScreenSize.width(30),
                    imagePickType(Icons.image_outlined, "Gallery", () {
                      Navigator.pop(context);
                      provider.imagePicker(ImageSource.gallery);
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

  confirmationBottomSheet(InsuranceProvider provider,){
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
            // height: MediaQuery.of(context).size.height*0.9,
            child: SingleChildScrollView(
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
                 widget.index==0?
                    provider.thirdPartyDetailsWidget():
                     widget.index==1?
                     provider.healthDetailsWidget():
                     provider. personalDetailsWidget(),
                  ScreenSize.height(24),
                  Container(
                    height: 1,
                    color: const Color(0xff7F808C33).withOpacity(.2),
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
            ),
          );
        });
  }



  mPinBottomSheet(InsuranceProvider provider){
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

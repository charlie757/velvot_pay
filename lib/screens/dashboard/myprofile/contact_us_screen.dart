import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/main.dart';
import 'package:velvot_pay/provider/contact_us_provider.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/bottom_image_button_widget.dart';

import '../../../widget/custom_radio_button.dart';

class ContactUsScreen extends StatefulWidget {
  final String number;
  final String email;
  final String name;
  const ContactUsScreen(
      {required this.number, required this.email, required this.name});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<ContactUsProvider>(context, listen: false);
    provider.resetValue();
    provider.emailController.text = widget.email;
    provider.numberController.text = widget.number;
    provider.nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Contact Us",
          ),
      body: Consumer<ContactUsProvider>(builder: (context, myProvider, child) {
        return Form(
          key: myProvider.formKey,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: 'Name',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  hintText: 'Full Name',
                  controller: myProvider.nameController,
                  textInputAction: TextInputAction.next,
                  isReadOnly: true,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your name";
                    }
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: 'Email Address',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  hintText: 'Email Address',
                  controller: myProvider.emailController,
                  isReadOnly: true,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your email";
                    }
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: 'Mobile Number',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(
                  hintText: 'Mobile Number',
                  controller: myProvider.numberController,
                  isReadOnly: true,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your number";
                    }
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: 'How may we help you?',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
            CustomTextField(
                    hintText: 'Choose category',
                    isReadOnly: true,
                    controller: myProvider.topicController,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      optionBottomSheet(myProvider);
                      // myProvider.tooltipController.toggle();
                    },
                    suffixWidget: Container(
                        width: 30,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Images.arrowUpIcon)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Select your category";
                      }
                    },
                  ),
                ScreenSize.height(20),
                getText(
                    title: 'Description',
                    size: 14,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(6),
                CustomTextField(hintText: 'Enter your message',
                  controller: myProvider.messageController,
                  maxLines: 4,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your message";
                    }
                  },
                ),
                ScreenSize.height(30),
                CustomBtn(
                    title: "Submit Now",
                    onTap: () {
                      myProvider.checkValidation();
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
  topicWidget(ContactUsProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 40),
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -1),
                color: AppColor.blackColor.withOpacity(.1),
                blurRadius: 7)
          ]),
      child: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(10);
          },
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(top: 15, left: 15, bottom: 20, right: 15),
          itemCount: provider.topicList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                provider.topicController.text = provider.topicList[index];
                setState(() {});
                // provider.tooltipController.hide();
              },
              child: SizedBox(
                height: 30,
                child: getText(
                    title: provider.topicList[index],
                    size: 15,
                    fontFamily: Constants.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
              ),
            );
          }),
    );
  }

  optionBottomSheet(ContactUsProvider provider){
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
                          getText(title: 'Option',
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
                      ListView.separated(
                        separatorBuilder: (context,sp){
                          return ScreenSize.height(10);
                        },
                          itemCount: provider.topicList.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            provider.updateOptions(index);
                            provider.topicController.text = provider.topicList[index];
                            Navigator.pop(context);
                            state((){});
                          },
                          child: Container(
                            color: AppColor.whiteColor,
                            height: 30,
                            child: Row(
                              children: [
                                customRadioButton(provider.selectedOption==index?true:false,),
                                ScreenSize.width(10),
                                Text(provider.topicList[index],
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

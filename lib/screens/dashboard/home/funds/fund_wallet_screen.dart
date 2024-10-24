import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/wallet_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../../apiconfig/api_url.dart';
import '../../../../provider/profile_provider.dart';

class FundWalletScreen extends StatefulWidget {
  const FundWalletScreen({super.key});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction()async{;
    final provider = Provider.of<WalletProvider>(context,listen: false);
    provider.resetValues();
        Future.delayed(Duration.zero,(){
          provider.fetchBankApiFunction();
        });
    provider.plugin.initialize(publicKey: ApiUrl.payStackPublicKey);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          backgroundColor: AppColor.whiteF7Color,
          appBar: appBar(title: "Fund your wallet",backgroundColor: AppColor.whiteF7Color),
          body: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 15),
            child: Column(
              children: [
                bankTransferWidget(myProvider),
                ScreenSize.height(24),
                debitCardWidget(myProvider)
              ],
            ),
          ),
        );
      }
    );
  }
  bankTransferWidget(WalletProvider provider){
    final profileProvider = Provider.of<ProfileProvider>(context);
    return GestureDetector(
      onTap: (){
        if(profileProvider.model!=null&&profileProvider.model!.data!=null&&!profileProvider.model!.data!.isOtpEmail){
          Utils.errorSnackBar("Please verify your email id", context);
        }
        else{
          if(!profileProvider.model!.data!.isBankAccount){
            provider.createBankApiFunction();
          }
          else{
           provider. isCollapsed = !provider. isCollapsed;
          }
        }
        setState(() {
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color:const Color(0xffE4E4E7))
        ),
        padding:const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(Images.bankTransfer,height: 32,width: 32,),
                ScreenSize.width(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(title: 'Bank transfer',
                          size: 16, fontFamily: Constants.galanoGrotesqueMedium, color:const Color(0xff26272B),
                          fontWeight: FontWeight.w700),
                      ScreenSize.height(4),
                      getText(title: 'Send money from your bank app',
                          size: 14, fontFamily: Constants.galanoGrotesqueRegular, color:const Color(0xff70707B),
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                SvgPicture.asset(!provider. isCollapsed?Images.arrowDownIcon: Images.keyboardArrowDown)
              ],
            ),
            ScreenSize.height(8),
            provider. isCollapsed?
            bankDetails(provider):Container()
          ],
        ),
      ),
    );
  }

  bankDetails(WalletProvider provider){
    return provider.model!=null&&provider.model!.data!=null? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffFCFCFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffF4F4F5))
          ),
          padding:const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(title: 'Account Details', size: 14,
                  fontFamily: Constants.galanoGrotesqueMedium,
                  color: const Color(0xff51525C), fontWeight: FontWeight.w600),
              ScreenSize.height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(title: 'Bank Name', size: 14,
                      fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff7F808C),
                      fontWeight: FontWeight.w400),
                  ScreenSize.width(8),
                  Expanded(
                    child: getText(title: provider.model!.data!.bankName??'', size: 14,
                        fontFamily: Constants.galanoGrotesqueSemiBold, color: AppColor.grayIronColor,
                        fontWeight: FontWeight.w600,textAlign: TextAlign.end,),
                  ),
                ],
              ),
              ScreenSize.height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(title: 'Account Name', size: 14,
                      fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff7F808C),
                      fontWeight: FontWeight.w400),
                  ScreenSize.width(8),
                  Expanded(
                    child: getText(title: provider.model!.data!.accountHolderName??'', size: 14,
                      fontFamily: Constants.galanoGrotesqueSemiBold, color: AppColor.grayIronColor,
                      fontWeight: FontWeight.w600,textAlign: TextAlign.end,),
                  ),
                ],
              ),
              ScreenSize.height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(title: 'Account Number', size: 14,
                      fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff7F808C),
                      fontWeight: FontWeight.w400),
                  // const Spacer(),
                  ScreenSize.width(8),
                 Expanded(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       getText(title: provider.model!.data!.accountNumber??'', size: 14,
                         fontFamily: Constants.galanoGrotesqueSemiBold, color: AppColor.grayIronColor,
                         fontWeight: FontWeight.w600,textAlign: TextAlign.end,),
                       ScreenSize.width(8),
                       GestureDetector(
                         onTap: (){
                           Clipboard.setData(ClipboardData(
                               text: provider.model!.data!.accountNumber));
                           // Fluttertoast.showToast(
                           //     msg: 'Copied', gravity: ToastGravity.CENTER);
                         },
                         child: SvgPicture.asset(Images.copySvg),
                       )
                     ],
                   ),
                 )
                ],
              ),
            ],
          ),
        ),
        ScreenSize.height(8),
        getText(title: 'This can take up to 10 - 15mins before the money will reflect',
            size: 10, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xffA0A0AB), fontWeight: FontWeight.w400)
      ],
    ):Container();
  }

  debitCardWidget(WalletProvider provider){
    return GestureDetector(
      onTap: (){
        provider.resetValues();
        addAmountBottomSheet(provider);
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color:const Color(0xffE4E4E7))
        ),
        padding:const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
        child: Row(
          children: [
            Image.asset(Images.debitCard,height: 32,width: 32,),
            ScreenSize.width(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(title: 'Debit card',
                      size: 16, fontFamily: Constants.galanoGrotesqueMedium, color:const Color(0xff26272B),
                      fontWeight: FontWeight.w700),
                  ScreenSize.height(4),
                  getText(title: 'Deposit money using debit card',
                      size: 14, fontFamily: Constants.galanoGrotesqueRegular, color:const Color(0xff70707B),
                      fontWeight: FontWeight.w400),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  addAmountBottomSheet(WalletProvider provider){
    showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
        shape:const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )
        ),
        context: context, builder: (context){
      return Form(
        key: provider.formKey,
        child: Padding(
          padding:  EdgeInsets.only(left: 16,right: 16,top: 24,bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding:const EdgeInsets.only(bottom: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Images.logout),
                ScreenSize.height(8),
                getText(title: 'Fund by Debit Card',
                    size: 24, fontFamily: Constants.galanoGrotesqueSemiBold,
                    color: AppColor.grayIronColor, fontWeight: FontWeight.w700),
                ScreenSize.height(4),
                getText(title: 'Input the amount to fund your wallet with',
                    size: 14, fontFamily: Constants.galanoGrotesqueRegular,
                    color:const Color(0xff51525C), fontWeight: FontWeight.w400),
                ScreenSize.height(24),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      border: Border.all(color: const Color(0xffE4E4E7)),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding:const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          getText(title: 'Amount ',
                              size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                              color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                          getText(title: '(₦)',
                              size: 14, fontFamily: Constants.galanoGrotesqueMedium,
                              color: AppColor.grayIronColor, fontWeight: FontWeight.w700),
                        ],
                      ),
                      ScreenSize.height(8),
                      CustomTextField(hintText: 'Enter amount',
                        controller: provider.amountController,
                        borderRadius: 8,
                        borderColor:const Color(0xffD1D1D6),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val){
                          print(val);
                          if(val.isEmpty){
                            return "Enter amount";
                          }
                          else if (int.parse(val) < 100) {
                            return "Enter amount should be greater than 100";
                          }
                        },
                      ),

                    ],
                  ),
                ),
                ScreenSize.height(32),
                CustomBtn(title: 'Confirm', onTap: (){
                  provider.checkValidation();
                }),
                ScreenSize.height(20),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: getText(title: "Go back",
                        size: 16, fontFamily: Constants.galanoGrotesqueMedium,
                        color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

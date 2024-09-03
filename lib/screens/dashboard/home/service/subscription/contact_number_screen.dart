import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../../../helper/app_color.dart';
import '../../../../../helper/getText.dart';
import '../../../../../helper/screen_size.dart';
import '../../../../../provider/buy_subscription_provider.dart';
import '../../../../../utils/Constants.dart';
import '../../../../../utils/utils.dart';

class ContactNumberScreen extends StatefulWidget {
  const ContactNumberScreen({super.key});

  @override
  State<ContactNumberScreen> createState() => _ContactNumberScreenState();
}

class _ContactNumberScreenState extends State<ContactNumberScreen> {

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }


  callInitFunction(){
    final dataSubscriptionProvider = Provider.of<BuySubscriptionProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      dataSubscriptionProvider.isSearchEnable=false;
      dataSubscriptionProvider.searchList.clear();
      dataSubscriptionProvider.fetchContacts();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BuySubscriptionProvider>(
      builder: (context,myProvider,child) {
        print(myProvider.searchList.length);

        return Scaffold(
          appBar: appBar(title: 'Contacts'),
          body: Column(
            children: [
              Padding(padding:const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(hintText: 'Search by number or name...',
              fillColor: AppColor.whiteColor,
                inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9 ]+$'))],
                onChanged: (val){
                if(val.isEmpty){
                  myProvider.isSearchEnable=false;
                  myProvider.noDataFound=false;
                  myProvider.unknownNumber='';
                  myProvider.searchList.clear();
                  setState(() {
                  });
                }
                else{
                  myProvider.isSearchEnable=true;
                  myProvider.searchList.clear();
                  myProvider.searchFunction(val);
                }
                },
              ),
              ),
              ScreenSize.height(6),
              Expanded(
                child: myProvider.noDataFound?
                Center(
                  child: getText(title: 'No contact found',
                      size: 14, fontFamily: Constants.poppinsMedium, color: AppColor.redColor,
                      fontWeight: FontWeight.w500),
                ):
                ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.height(15);
                    },
                    itemCount:myProvider.isSearchEnable?myProvider.searchList.length: myProvider.contactList.length,
                    shrinkWrap: true,
                    padding:
                    const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
                    itemBuilder: (context, index) {
                      final contact =myProvider.isSearchEnable?myProvider.searchList[index]: myProvider.contactList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context,contact.phones.isNotEmpty? contact.phones.first.number??'':"");
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 47,
                                      width: 47,
                                      decoration: BoxDecoration(
                                          color: AppColor.btnColor,
                                          border: Border.all(color: AppColor.e1Color),
                                          borderRadius: BorderRadius.circular(25)),
                                      alignment:contact.photo!=null?null: Alignment.center,
                                      child:contact.photo!=null? ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child:Image.memory(contact.photo!,fit: BoxFit.cover,),
                                      ):
                                      getText(
                                          title:contact.displayName.isNotEmpty? Utils.getInitials(contact.displayName):'',
                                          size: 18,
                                          fontFamily: Constants.poppinsMedium,
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    ScreenSize.width(14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.displayName??"Unknown",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Constants.poppinsMedium,
                                                color: AppColor.hintTextColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          ScreenSize.height(5),
                                          getText(
                                              title:contact.phones.isNotEmpty? contact.phones.first.number??'':"",
                                              size: 14,
                                              fontFamily: Constants.poppinsMedium,
                                              color: AppColor.darkBlackColor,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ScreenSize.height(12),
                              // customDivider(60)
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }
    );
  }
}

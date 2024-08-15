import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/data_subscription_provider.dart';
import 'package:velvot_pay/provider/operator_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/choose_plan_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/search_number_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/utils/utils.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_divider.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

import 'bill_number_screen.dart';

class DataSubscriptionScreen extends StatefulWidget {
  String serviceId;
  String operatorName;
  String operatorImage;
  final String route;
  final String? minimiumAmount;
  final String? maximumAmount;
  DataSubscriptionScreen({required this.serviceId,required this.operatorName,required this.operatorImage, required this.route,
    this.minimiumAmount,this.maximumAmount
  });

  @override
  State<DataSubscriptionScreen> createState() => _DataSubscriptionScreenState();
}

class _DataSubscriptionScreenState extends State<DataSubscriptionScreen> {

  @override
  void initState() {
    // TODO: implement initState
    // fetchContacts();
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final dataSubscriptionProvider = Provider.of<DataSubscriptionProvider>(context,listen: false);
      Future.delayed(Duration.zero,(){
        dataSubscriptionProvider.fetchContacts();
      });
  }



  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    // final dataSubscriptionProvider = Provider.of<DataSubscriptionProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          title: 'Data Subscription',
          onTap: () {
            Navigator.pop(context);
          }),
      body: Consumer<DataSubscriptionProvider>(
          builder: (context,myProvider,child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dashboardProvider.bannerModel != null &&
                      dashboardProvider.bannerModel!.data != null
                      ? sliderWidget(dashboardProvider)
                      : Container(),
                  ScreenSize.height(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomSearchBar(
                      hintText: 'Search by Number or Name',
                      isReadOnly: true,
                      onTap: () {
                        AppRoutes.pushNavigation(SearchNumberScreen(serviceId: widget.serviceId,operatorName: widget.operatorName,operatorImage: widget.operatorImage,
                        route: widget.route,
                          minimiumAmount: widget.minimiumAmount,
                          maximumAmount: widget.maximumAmount,
                        ));
                      },
                    ),
                  ),
                  ScreenSize.height(30),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: getText(
                        title: 'All Contacts',
                        size: 16,
                        fontFamily: Constants.poppinsSemiBold,
                        color: AppColor.darkBlackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  numbersWidget(myProvider)
                ],
              ),
            );
          }
      ),
    );
  }

  numbersWidget(DataSubscriptionProvider provider) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        itemCount:provider.contactList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding:
        const EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 30),
        itemBuilder: (context, index) {
          Contact contact =provider. contactList[index];
          return GestureDetector(
            onTap: () {
              widget.route=='topup'?
              AppRoutes.pushNavigation(BillNumberScreen(
                route: widget.route,
                serviceId: widget.serviceId,
                operatorName: widget.operatorName,operatorImage: widget.operatorImage,
                maximumAmount: widget.maximumAmount,
                minimiumAmount:widget. minimiumAmount,
                number: contact.phones.first.number??'',
              )):
              AppRoutes.pushNavigation(ChoosePlanScreen(serviceId: widget.serviceId,number: contact.phones.first.number??'',
              operatorImage: widget.operatorImage,operatorName: widget.operatorName,route: widget.route,isFromSearchNumberRoute: '',
              ));
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
                  customDivider(60)
                ],
              ),
            ),
          );
        });
  }
}

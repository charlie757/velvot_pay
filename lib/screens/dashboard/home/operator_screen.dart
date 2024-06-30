import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/network_image_helper.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/operator_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/bill_number_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/data_subscription_screen.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

class OperatorScreen extends StatefulWidget {
  final String title;
  final int index;
  const OperatorScreen({required this.title, required this.index});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<OperatorProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      String apiUrl = widget.index == 0
          ? ApiUrl.dataSubscriptionOperatorListUrl
          : widget.index == 1
              ? ApiUrl.electricityOperatorListUrl
              : widget.index == 2
                  ? ApiUrl.educationalOperatorListUrl
                  : widget.index == 3
                      ? ApiUrl.tvOperatorListUrl
                      : widget.index == 4
                          ? ApiUrl.insuranceOperatorListUrl
                          : '';
      provider.callOperatorListApiFunction(apiUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: appBar(
          title: widget.title,
          onTap: () {
            Navigator.pop(context);
          }),
      body: Consumer<OperatorProvider>(builder: (context, myProvider, child) {
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
                  hintText: 'Search by Operator',
                  isReadOnly: false,
                  onTap: () {},
                ),
              ),
              ScreenSize.height(30),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: getText(
                    title: 'Choose your Operator',
                    size: 16,
                    fontFamily: Constants.poppinsSemiBold,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w600),
              ),
              myProvider.model != null && myProvider.model!.data != null
                  ? operatorTypesWidget(myProvider)
                  : Container()
            ],
          ),
        );
      }),
    );
  }

  operatorTypesWidget(OperatorProvider provider) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.model!.data!.length,
        padding:
            const EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 30),
        itemBuilder: (context, index) {
          return InkWell(
            hoverColor: AppColor.hintTextColor.withOpacity(.1),
            focusColor: AppColor.hintTextColor.withOpacity(.1),
            highlightColor: AppColor.hintTextColor.withOpacity(.1),
            onTap: () {
              widget.index == 0
                  ? AppRoutes.pushNavigation(const DataSubscriptionScreen())
                  : AppRoutes.pushNavigation(BillNumberScreen(
                      index: widget.index,
                    ));
            },
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
                            border: Border.all(color: AppColor.e1Color),
                            borderRadius: BorderRadius.circular(25)),
                        alignment: Alignment.center,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: NetworkImagehelper(
                              img: provider.model!.data![index].image,
                              height: 47.0,
                              width: 47.0,
                            )),
                      ),
                      ScreenSize.width(14),
                      Expanded(
                        child: Text(
                          provider.model!.data![index].title ?? '',
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
                ),
                ScreenSize.height(12),
                Container(
                  margin: const EdgeInsets.only(left: 60),
                  color: AppColor.hintTextColor.withOpacity(.3),
                  height: 1,
                )
              ],
            ),
          );
        });
  }
}

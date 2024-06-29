import 'package:flutter/material.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/search_number_screen.dart';
import 'package:velvot_pay/util/constaints.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/custom_divider.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

class DataSubscriptionScreen extends StatefulWidget {
  const DataSubscriptionScreen({super.key});

  @override
  State<DataSubscriptionScreen> createState() => _DataSubscriptionScreenState();
}

class _DataSubscriptionScreenState extends State<DataSubscriptionScreen> {
  List numberList = [
    {
      'sn': 'SK',
      'name': 'Sunil Kumar Saini',
      'number': '+234 9876543210',
      'color': '0xff181D3D'
    },
    {
      'sn': 'DS',
      'name': 'Daarsat Sharma',
      'number': '+234 9876543210',
      'color': 0xff13D3CE
    },
    {
      'sn': 'VS',
      'name': 'Varsha Sharma',
      'number': '+234 9876543210',
      'color': 0xff7358F6
    },
    {
      'sn': 'VS',
      'name': 'Varun Sharma',
      'number': '+234 9876543210',
      'color': 0xff7358F6
    },
    {
      'sn': 'SS',
      'name': 'Shyam Sharma',
      'number': '+234 9876543210',
      'color': 0xff5A9E39
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: 'Data Subscription',
          onTap: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sliderWidget(),
            ScreenSize.height(20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CustomSearchBar(
                hintText: 'Search by Number or Name',
                isReadOnly: true,
                onTap: () {},
              ),
            ),
            ScreenSize.height(30),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: getText(
                  title: 'All Contacts',
                  size: 16,
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
            ),
            numbersWidget()
          ],
        ),
      ),
    );
  }

  numbersWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        itemCount: numberList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 30),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('object');
              AppRoutes.pushNavigation(SearchNumberScreen());
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
                              color: Color(int.parse(
                                  numberList[index]['color'].toString())),
                              border: Border.all(color: AppColor.e1Color),
                              borderRadius: BorderRadius.circular(25)),
                          alignment: Alignment.center,
                          child: getText(
                              title: numberList[index]['sn'],
                              size: 18,
                              fontFamily: Constaints.poppinsMedium,
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                        ScreenSize.width(14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                numberList[index]['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Constaints.poppinsMedium,
                                    color: AppColor.hintTextColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              ScreenSize.height(5),
                              getText(
                                  title: numberList[index]['number'],
                                  size: 14,
                                  fontFamily: Constaints.poppinsMedium,
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

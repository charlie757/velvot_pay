import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_search_bar.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/screens/dashboard/home/bill_number_screen.dart';
import 'package:velvot_pay/screens/dashboard/home/data_subscription_screen.dart';
import 'package:velvot_pay/util/constaints.dart';
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
  List electiricyList = [
    {
      'img': 'assets/icons/vidyat_icon.png',
      'text': 'Ajmer Vidyut Vitaran Nigam Ltd',
    },
    {
      'img': 'assets/icons/besl_image.png',
      'text': 'BESL Bharatpur Electricity Service Ltd',
    },
    {
      'img': 'assets/icons/jaipur_image.png',
      'text': 'Jaipur Vidyut Vitaran Nigam Ltd',
    },
    {
      'img': 'assets/icons/vidyat_icon.png',
      'text': 'Ajmer Vidyut Vitaran Nigam Ltd',
    },
  ];

  List operatorList = [
    {
      'img': Images.airtelIcon,
      'text': 'Airtel Prepaid',
    },
    {
      'img': Images.jioIcon,
      'text': 'Jio Prepaid',
    },
    {
      'img': Images.airtelIcon,
      'text': 'Airtel Prepaid',
    },
    {
      'img': Images.jioIcon,
      'text': 'Jip Prepaid',
    },
    {
      'img': Images.airtelIcon,
      'text': 'Airtel Prepaid',
    },
    {
      'img': Images.jioIcon,
      'text': 'Jip Prepaid',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: widget.title,
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
                  fontFamily: Constaints.poppinsSemiBold,
                  color: AppColor.darkBlackColor,
                  fontWeight: FontWeight.w600),
            ),
            operatorTypesWidget(
                widget.index == 0 ? operatorList : electiricyList)
          ],
        ),
      ),
    );
  }

  operatorTypesWidget(List list) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
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
                            child: Image.asset(list[index]['img'])),
                      ),
                      ScreenSize.width(14),
                      Expanded(
                        child: Text(
                          list[index]['text'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: Constaints.poppinsMedium,
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

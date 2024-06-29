import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List faqList = [
    {
      'title': 'How to register',
      'sub':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet'
    },
    {
      'title': 'How to register',
      'sub':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet'
    },
    {
      'title': 'How to register',
      'sub':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet'
    },
    {
      'title': 'How to register',
      'sub':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet'
    },
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Faq's",
          onTap: () {
            Navigator.pop(context);
          }),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(10);
          },
          itemCount: faqList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectedIndex = index;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.e1Color),
                    borderRadius: BorderRadius.circular(4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                            title: faqList[index]['title'],
                            size: 16,
                            fontFamily: Constants.poppinsMedium,
                            color: selectedIndex == index
                                ? AppColor.purpleColor
                                : AppColor.darkBlackColor,
                            fontWeight: FontWeight.w400),
                        SvgPicture.asset(selectedIndex == index
                            ? Images.arrowUpIcon
                            : Images.arrowRightIcon)
                      ],
                    ),
                    ScreenSize.height(selectedIndex == index ? 16 : 0),
                    selectedIndex == index
                        ? getText(
                            title:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet',
                            size: 14,
                            fontFamily: Constants.poppinsRegular,
                            color: const Color(0xff616161),
                            fontWeight: FontWeight.w300)
                        : Container()
                  ],
                ),
              ),
            );
          }),
    );
  }
}

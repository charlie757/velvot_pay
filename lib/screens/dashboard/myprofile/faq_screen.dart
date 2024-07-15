import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/pages_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/conver_html.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen();

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  int selectedIndex = 0;

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<PagesProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.callFaqApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Faq's",
          onTap: () {
            Navigator.pop(context);
          }),
      body: Consumer<PagesProvider>(builder: (context, myProvider, child) {
        return myProvider.model != null && myProvider.model!.data != null
            ? ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.height(10);
                },
                itemCount: myProvider.model!.data!.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 30),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                     myProvider.model!.data![index].title ??
                                        "",
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: Constants.poppinsMedium,
                                    color: selectedIndex == index
                                        ? AppColor.purpleColor
                                        : AppColor.darkBlackColor,
                                    fontWeight: FontWeight.w400)),
                              ),
                              SvgPicture.asset(selectedIndex == index
                                  ? Images.arrowUpIcon
                                  : Images.arrowRightIcon)
                            ],
                          ),
                          ScreenSize.height(selectedIndex == index ? 16 : 0),
                          selectedIndex == index
                              ? convertHtmlWidget(
                                  myProvider.model!.data![index].description)
                              // getText(
                              //     title:
                              //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet',
                              //     size: 14,
                              //     fontFamily: Constants.poppinsRegular,
                              //     color: const Color(0xff616161),
                              //     fontWeight: FontWeight.w300)
                              : Container()
                        ],
                      ),
                    ),
                  );
                })
            : Container();
      }),
    );
  }
}

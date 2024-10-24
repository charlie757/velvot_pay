import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
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
          title: "FAQs",
      ),
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
                          border: Border.all(color:const Color(0xffF4F4F5)),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
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
                                    fontSize: 14,
                                    fontFamily: Constants.galanoGrotesqueMedium,
                                    color: AppColor.appColor,
                                    fontWeight: FontWeight.w500)),
                              ),
                              SvgPicture.asset(selectedIndex == index
                                  ? Images.arrowDownIcon
                                  : Images.arrowUpIcon)
                            ],
                          ),
                          ScreenSize.height(selectedIndex == index ? 16 : 0),
                          selectedIndex == index
                              ? convertHtmlWidget(
                                  myProvider.model!.data![index].description,12, FontWeight.w400)
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

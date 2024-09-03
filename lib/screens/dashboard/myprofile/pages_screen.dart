import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/pages_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:velvot_pay/widget/conver_html.dart';

class PagesScreen extends StatefulWidget {
  String title;
  String url;
   PagesScreen({required this.title,required this.url});
  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<PagesProvider>(context, listen: false)
          .callPrivacyApiFunction(widget.url);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: widget.title,
          onTap: () {
            Navigator.pop(context);
          }),
      body: Consumer<PagesProvider>(builder: (context, myProvider, child) {
        return myProvider.policyModel != null &&
                myProvider.policyModel!.data != null
            ? SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,bottom: 30
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: myProvider.policyModel!.data!.title,
                        size: 16,
                        fontFamily: Constants.galanoGrotesqueSemiBold,
                        color: const Color(0xff70707B),
                        fontWeight: FontWeight.w400),
                    ScreenSize.height(15),
                    convertHtmlWidget(myProvider.policyModel!.data!.content,14, FontWeight.w500)
                  ],
                ),
              )
            : Container();
      }),
    );
  }
}

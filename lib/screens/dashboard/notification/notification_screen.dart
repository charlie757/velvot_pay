import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/notification_provider.dart';
import 'package:velvot_pay/widget/appBar.dart';

import '../../../helper/app_color.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/network_image_helper.dart';
import '../../../utils/Constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<NotificationProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      provider.callNotificationApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Notifications'),
      body: Consumer<NotificationProvider>(
        builder: (context,myProvider,child) {
          return myProvider.model!=null&&myProvider.model!.data!=null&&
              (myProvider.model!.data!.item!.isNotEmpty)?
          ListView.separated(
            separatorBuilder: (context,sp){
              return ScreenSize.height(22);
            },
              itemCount: myProvider.model!.data!.item!.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding:const EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 20),
              itemBuilder: (context,index){
                var model = myProvider.model!.data!.item![index];
                return Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    getText(title: model.sId, size: 12, fontFamily: Constants.galanoGrotesqueRegular,
                        color: const Color(0xff51525C), fontWeight: FontWeight.w500),
                    ScreenSize.height(16),
                    ListView.separated(
                      separatorBuilder: (context,sp1){
                        return ScreenSize.height(16);
                      },
                        itemCount: model.items!.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context,j){
                        var model1 = model.items![j];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    border: Border.all(color: AppColor.e1Color),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                alignment: Alignment.center,
                                child:model1.image!=null? ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: NetworkImagehelper(
                                    img: model1.image,width: 48.0,height: 48.0,
                                  ),
                                ):Image.asset(Images.vpLogo),
                              ),
                              ScreenSize.width(16),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(title: model1.title,
                                      size: 12, fontFamily: Constants.galanoGrotesqueSemiBold, color:
                                      const Color(0xff1A1A1E), fontWeight: FontWeight.w600),
                                  ScreenSize.height(4),
                                  getText(title: model1.description,
                                      size: 12, fontFamily: Constants.galanoGrotesqueRegular, color:
                                      const Color(0xff70707B), fontWeight: FontWeight.w400),
                                ],
                              ))
                            ],
                          )
                        ],
                      );
                    })
                  ],
                );
          }):!myProvider.isLoading? noNotificationWidget():Container();
        }
      ),
    );
  }

  noNotificationWidget(){
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,width: 40,
            decoration: BoxDecoration(
                color: AppColor.appColor.withOpacity(.10),
                shape: BoxShape.circle
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(Images.notificationIcon,color: AppColor.appColor,),
          ),
          ScreenSize.height(8),
          getText(title: 'Nothing Yet',
              size: 16, fontFamily: Constants.galanoGrotesqueMedium,
              color:const Color(0xff1A1A1E), fontWeight: FontWeight.w700),
          ScreenSize.height(4),
          getText(title: 'You have no notifications',
              size: 12, fontFamily: Constants.galanoGrotesqueRegular,
              color: const Color(0xff70707B), fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/approutes/app_routes.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/network_image_helper.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
import 'package:velvot_pay/provider/transaction_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/funds/fund_wallet_screen.dart';
import 'package:velvot_pay/screens/dashboard/notification/notification_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widget/transaction_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    final transactionProvider = Provider.of<TransactionProvider>(context,listen: false);
    Future.delayed(Duration.zero, () {
      provider.dashboardApiFunction();
      // transactionProvider.callTransactionApiFunction(false,'');
      // provider.getBannerApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.whiteF7Color,
      appBar: customAppBar(profileProvider),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
        child: Column(
          children: [
            recentTransactionWidget(dashboardProvider),
            ScreenSize.height(20),
            GestureDetector(
                onTap: (){
                  dashboardProvider.serviceNavigateRoutes(0);
                },
                child: Image.asset(Images.electricityImage)),
            ScreenSize.height(8),
            Row(
              children: [
                servicesWidget(title: Constants.serviceList[1]['title'],img: Constants.serviceList[1]['img'],index: 1),
                ScreenSize.width(8),
                  servicesWidget(title: Constants.serviceList[2]['title'],img: Constants.serviceList[2]['img'],index: 2),
              ],
            ),
            ScreenSize.height(8),
            Row(
              children: [
                servicesWidget(title: Constants.serviceList[3]['title'],img: Constants.serviceList[3]['img'],index: 3),
                ScreenSize.width(8),
                servicesWidget(title: Constants.serviceList[4]['title'],img: Constants.serviceList[4]['img'],index: 4),
              ],
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     padding: const EdgeInsets.only(top: 20, bottom: 100),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         // dashboardProvider.bannerModel != null &&
            //         //         dashboardProvider.bannerModel!.data != null
            //         //     ? sliderWidget(dashboardProvider)
            //         //     : Container(),
            //         Padding(
            //           padding:
            //               const EdgeInsets.only(left: 20, right: 20, top: 30),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               getText(
            //                   title: 'Utility Services',
            //                   size: 16,
            //                   fontFamily: Constants.poppinsSemiBold,
            //                   color: AppColor.darkBlackColor,
            //                   fontWeight: FontWeight.w600),
            //               ScreenSize.height(20),
            //               // typesWidget(dashboardProvider)
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  recentTransactionWidget(DashboardProvider provider){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      // padding:const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          walletWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(title: 'Recent', size: 14, fontFamily: Constants.galanoGrotesqueSemiBold, color: AppColor.grayIronColor, fontWeight: FontWeight.w600),
               GestureDetector(
                 onTap: (){
                   Provider.of<DashboardProvider>(context,listen: false).updateIndex(1);
                 },
                 child: Row(
                   children: [
                     getText(title: 'See All', size: 12, fontFamily: Constants.galanoGrotesqueRegular, color: AppColor.appColor, fontWeight: FontWeight.w400),
                     ScreenSize.width(4),
                     SvgPicture.asset(Images.arrowForwardIcon)
                   ],
                 ),
               )
              ],
            ),
          ),
          ScreenSize.height(12),
          provider.dashboardModel!=null&&provider.dashboardModel!.data!=null&&provider.dashboardModel!.data!.transaction!.isNotEmpty?
      ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(16);
          },
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.dashboardModel!.data!.transaction!.length,
          padding:
          const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var model1 = provider.dashboardModel!.data!.transaction![index];
            return transactionWidget(model1);
          }):Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: getText(title: 'No Transactions',
                  size: 12, fontFamily: Constants.poppinsMedium, color: AppColor.redColor,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  walletWidget(){
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return SizedBox(
      height: 152,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:const BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12)
            ),
            child: SvgPicture.asset(Images.walletBgSvg,fit: BoxFit.cover,),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap:(){
                    if(SessionManager.viewBalance==true) {
                      SessionManager.setViewBalance = false;
                    }
                    else{
                      SessionManager.setViewBalance = true;
                    }
                    setState(() {

                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getText(title: "Available Balance",
                          size: 14, fontFamily: Constants.galanoGrotesqueMedium, color:  AppColor.whiteF7Color, fontWeight: FontWeight.w400),
                       ScreenSize.width(4),
                      Icon(
                        SessionManager.viewBalance?Icons.visibility_off_sharp:
                        Icons.visibility_outlined,color: AppColor.whiteF7Color,)
                    ],
                  ),
                ),
                ScreenSize.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getText(title: '₦ ',
                        size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.whiteF7Color, fontWeight: FontWeight.w400),
                    getText(title:dashboardProvider.dashboardModel!=null&&dashboardProvider.dashboardModel!.data!=null&&dashboardProvider.dashboardModel!.data!.walletAmount.toString().isNotEmpty?
                    SessionManager.viewBalance?Utils.maskAllDigits(dashboardProvider.dashboardModel!.data!.walletAmount.toString()): dashboardProvider.dashboardModel!.data!.walletAmount.toString():
                    SessionManager.viewBalance?Utils.maskAllDigits('0'): '0',textAlign: TextAlign.center, size:SessionManager.viewBalance?26: 36, fontFamily: Constants.galanoGrotesqueBold, color:  AppColor.whiteF7Color, fontWeight: FontWeight.w600)
                  ],
                ),
                ScreenSize.height(8),
                InkWell(
                  onTap: (){
                    AppRoutes.pushNavigation(const FundWalletScreen()).then((value) {
                      dashboardProvider.dashboardApiFunction();
                    });
                  },
                  child: Container(
                    height: 33,width: 113,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.whiteF7Color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const  Icon(Icons.add,color: AppColor.appColor,),
                        ScreenSize.width(4),
                        getText(title: 'Fund Wallet',
                            size: 12, fontFamily: Constants.galanoGrotesqueSemiBold,
                            color: AppColor.appColor, fontWeight: FontWeight.w600)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  servicesWidget({required String title,required String img,required int index}){
    return Expanded(
      child: GestureDetector(
        onTap: (){
          Provider.of<DashboardProvider>(context,listen: false).serviceNavigateRoutes(index);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.whiteColor,
            border: Border.all(color:const Color(0xffE4E4E7))
          ),
          padding:const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Container(
                height: 40,width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.appColor.withOpacity(.1)
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(img,height: 24,width:24),
              ),
              ScreenSize.height(8),
              getText(title: title,
                  size: 14, fontFamily: Constants.galanoGrotesqueMedium, color:const Color(0xff3F3F46),
                  fontWeight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }

  // typesWidget(DashboardProvider provider) {
  //   return GridView.builder(
  //       shrinkWrap: true,
  //       itemCount: provider.serviceList.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 15,
  //         childAspectRatio: 1/1.1
  //   ),
  //       itemBuilder: (context,index){
  //         return customTypesContainer(provider.serviceList[index]['color'],
  //             provider.serviceList[index]['img'], provider.serviceList[index]['title'], 150, () {
  //           provider.serviceNavigateRoutes(index);
  //             });
  //   });
  // }

  customTypesContainer(
      Color color, String img, String title, double height, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(img),
            ScreenSize.height(16),
            getText(
              title: title,
              size: 16,
              fontFamily: Constants.poppinsMedium,
              color: AppColor.darkBlackColor,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  AppBar customAppBar(ProfileProvider profileProvider){
    return AppBar(
      backgroundColor: AppColor.whiteF7Color,
      title: Row(
        children: [
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border:
                  Border.all(width: 2, color: AppColor.whiteColor),
                  shape: BoxShape.circle),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileProvider.model != null &&
                      profileProvider.model!.data != null
                      ? NetworkImagehelper(
                    img: profileProvider.model!.data!.imageUrl,
                    height: 40.0,
                    width: 40.0,
                  )
                      : SvgPicture.asset(Images.profileIcon))
          ),
          ScreenSize.width(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getText(
                    title: 'Welcome back',
                    size: 12,
                    fontFamily: Constants.galanoGrotesqueRegular,
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w400),
                getText(
                    title: profileProvider.model != null &&
                        profileProvider.model!.data != null
                        ? "${profileProvider.model!.data!.firstName.toString().isNotEmpty?profileProvider.model!.data!.firstName.toString().capitalize():''} ${profileProvider.model!.data!.lastName.toString().isNotEmpty?
                    profileProvider.model!.data!.lastName:''}"
                        : '',
                    size: 16,
                    fontFamily: Constants.galanoGrotesqueMedium,
                    color: AppColor.grayIronColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(padding:const EdgeInsets.only(right: 15),child: InkWell(
            onTap: (){
              AppRoutes.pushNavigation(const NotificationScreen());
            },
            child: SvgPicture.asset(Images.notificationIcon)),)
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

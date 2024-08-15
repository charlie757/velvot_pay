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
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
import 'package:velvot_pay/screens/dashboard/home/operator_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/contact_us_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/faq_screen.dart';
import 'package:velvot_pay/screens/dashboard/myprofile/pages_screen.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/widget/custom_divider.dart';
import 'package:velvot_pay/widget/slider_widget.dart';

import '../../../apiconfig/api_url.dart';
import '../../../helper/custom_btn.dart';
import '../../../utils/utils.dart';
import '../../../widget/general_dialog_box.dart';

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
    Future.delayed(Duration.zero, () {
      provider.getBannerApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      key: drawerKey,
      drawer: drawer(profileProvider),
      body: Column(
        children: [
          headerWidget(profileProvider),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dashboardProvider.bannerModel != null &&
                          dashboardProvider.bannerModel!.data != null
                      ? sliderWidget(dashboardProvider)
                      : Container(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: 'Utility Services',
                            size: 16,
                            fontFamily: Constants.poppinsSemiBold,
                            color: AppColor.darkBlackColor,
                            fontWeight: FontWeight.w600),
                        ScreenSize.height(20),
                        typesWidget(dashboardProvider)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  headerWidget(ProfileProvider profileProvider) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(color: Color(0xff373B58)),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  drawerKey.currentState!.openDrawer();
                },
                child: Stack(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
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
                              : Image.asset('assets/icons/dummy_girl.png'))
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 17,
                        width: 17,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Image.asset(Images.menuIcon),
                      ),
                    )
                  ],
                ),
              ),
              ScreenSize.width(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getText(
                      title: 'Welcome back',
                      size: 12,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w400),
                  getText(
                      title: profileProvider.model != null &&
                              profileProvider.model!.data != null
                          ? profileProvider.model!.data!.firstName
                              .toString()
                              .capitalize()
                          : '',
                      size: 16,
                      fontFamily: Constants.poppinsMedium,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  typesWidget(DashboardProvider provider) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: provider.serviceList.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 15,
          childAspectRatio: 1/1.1
    ),
        itemBuilder: (context,index){
          return customTypesContainer(provider.serviceList[index]['color'],
              provider.serviceList[index]['img'], provider.serviceList[index]['title'], 150, () {
            provider.serviceNavigateRoutes(index);
              });
    });
    //   Column(
    //   children: [
    //     Row(
    //       children: [
    //         Expanded(
    //           child: Column(
    //             children: [
    //               customTypesContainer(
    //                   AppColor.dataSubsriptionColor,
    //                   Images.dataSubscriptionIcon,
    //                   'Data Subscription',
    //                   150, () {
    //                 AppRoutes.pushNavigation(const OperatorScreen(
    //                   title: 'Select Operator',
    //                   route: 'operator',
    //                 ));
    //               }),
    //               ScreenSize.height(16),
    //               customTypesContainer(AppColor.electricityColor,
    //                   Images.electricityIcon, 'Electricity Payment', 150, () {
    //                 AppRoutes.pushNavigation(const OperatorScreen(
    //                   title: 'Choose Electricity Bill Operator',
    //                   route: 'electricity',
    //                 ));
    //               })
    //             ],
    //           ),
    //         ),
    //         ScreenSize.width(15),
    //         Expanded(
    //             child: customTypesContainer(AppColor.educationColor,
    //                 Images.educationIcon, 'Educational\nPayment', 320, () {
    //           AppRoutes.pushNavigation(const OperatorScreen(
    //             title: 'Choose Educational Bill Operator',
    //             route: 'education',
    //           ));
    //         }))
    //       ],
    //     ),
    //     ScreenSize.height(15),
    //     Row(
    //       children: [
    //         Expanded(
    //             child: customTypesContainer(AppColor.tvSubcriptionColor,
    //                 Images.tvSubscriptionIcon, 'TV Subscription', 150, () {
    //           AppRoutes.pushNavigation(const OperatorScreen(
    //             title: 'Choose TV Subcription Operator',
    //             route: 'tv',
    //           ));
    //         })),
    //         ScreenSize.width(15),
    //         Expanded(
    //             child: customTypesContainer(AppColor.insuranceColor,
    //                 Images.insuranceIcon, 'Insurance\nPayment', 150, () {
    //           AppRoutes.pushNavigation(const OperatorScreen(
    //             title: 'Choose Insurance Bill Operator',
    //             route: 'insurance',
    //           ));
    //         }))
    //       ],
    //     )
    //   ],
    // );
  }

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

  drawer(ProfileProvider provider) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 100),
      color: AppColor.whiteColor,
      child: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                Images.profileBackImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 230,
              ),
              Positioned(
                bottom: 0 + 25,
                left: 10,
                right: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: AppColor.whiteColor),
                              shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: provider.model != null &&
                                      provider.model!.data != null
                                  ? NetworkImagehelper(
                                      img: provider.model!.data!.imageUrl,
                                      height: 80.0,
                                      width: 80.0,
                                    )
                                  : Image.asset('assets/icons/dummy_girl.png')),
                        ),
                        ScreenSize.width(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(provider.model != null &&
                                provider.model!.data != null
                                ? provider.model!.data!.firstName
                                .toString()
                                .capitalize()
                                : "",
                            maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 18,
                                  fontFamily: Constants.poppinsSemiBold,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            ScreenSize.height(5),
                            getText(
                                title: provider.model != null &&
                                        provider.model!.data != null
                                    ? provider.model!.data!.mobileNumber
                                    : "",
                                size: 18,
                                fontFamily: Constants.poppinsLight,
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w400),
                          ],
                        )
                      ],
                    ),
                    ScreenSize.height(15),
                    Text(provider.model != null &&
                        provider.model!.data != null
                        ? provider.model!.data!.email
                        : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontFamily: Constants.poppinsLight,
                          fontWeight: FontWeight.w300
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
          ScreenSize.height(15),
          customRowWidgetForDrawer(Images.userIcon, 'My Profile', 0),
          ScreenSize.height(14),
          customRowWidgetForDrawer(
              Images.faqIcon, 'Frequently Asked Questions', 1),
          ScreenSize.height(14),
          customRowWidgetForDrawer(
              Images.privacyPolicyIcon, 'Privacy Policy', 2),
          ScreenSize.height(14),
          customRowWidgetForDrawer(Images.contactUsIcon, 'Contact us', 3),
          ScreenSize.height(14),
          customRowWidgetForDrawer(
              Images.privacyPolicyIcon, 'About Us', 4),
          ScreenSize.height(14),
          customRowWidgetForDrawer(Images.logoutIcon, 'Logout', 5),
          const Spacer(),
          getText(
              title: 'App Version 1.01',
              size: 12,
              fontFamily: Constants.poppinsRegular,
              color: AppColor.hintTextColor,
              fontWeight: FontWeight.w300)
        ],
      ),
    );
  }

  customRowWidgetForDrawer(String img, String title, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Provider.of<DashboardProvider>(context, listen: false)
                  .updateIndex(2);
              break;
            case 1:
              AppRoutes.pushNavigation(const FaqScreen());
              break;
            case 2:
              AppRoutes.pushNavigation(PagesScreen(title: 'Privacy Policy',url: ApiUrl.privacyUrl,));
              break;
            case 3:
              AppRoutes.pushNavigation(ContactUsScreen(
                email: Provider.of<ProfileProvider>(context, listen: false)
                    .model!
                    .data!
                    .email,
                number: Provider.of<ProfileProvider>(context, listen: false)
                    .model!
                    .data!
                    .mobileNumber,
                name: Provider.of<ProfileProvider>(context, listen: false)
                    .model!
                    .data!
                    .firstName,
              ));
              break;
            case 4:
              AppRoutes.pushNavigation( PagesScreen(title: 'About Us',url: ApiUrl.aboutUsUrl,));
              break;
            case 5:
              logoutDialogBox(context);
              break;

          }
        },
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  img,
                  height: 24,
                  width: 24,
                ),
                ScreenSize.width(15),
                getText(
                    title: title,
                    size: 16,
                    fontFamily: Constants.poppinsMedium,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w400)
              ],
            ),
            ScreenSize.height(14),
            customDivider(0),
          ],
        ),
      ),
    );
  }



  logoutDialogBox(BuildContext context,) async {
    generalDialogBox(
        context,true,
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(
                  title: 'Logout',
                  size: 18,
                  fontFamily: Constants.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w500),
              ScreenSize.height(15),
              getText(
                  title: 'Do you want to logout?',
                  size: 15,
                  fontFamily: Constants.poppinsRegular,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400),
              ScreenSize.height(30),
              Row(
                children: [
                  Flexible(
                      child: CustomBtn(
                          title: 'No', height: 44, width: 100, onTap: (){
                        Navigator.pop(context);
                      })),
                  ScreenSize.width(15),
                  Flexible(
                      child: CustomBtn(
                          title: 'Yes', height: 44, width: 100, onTap: (){
                        Utils.logOut();
                      })),
                ],
              )
            ],
          ),
        ));
  }

}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

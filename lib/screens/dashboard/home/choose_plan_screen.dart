// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:velvot_pay/approutes/app_routes.dart';
// import 'package:velvot_pay/helper/app_color.dart';
// import 'package:velvot_pay/helper/getText.dart';
// import 'package:velvot_pay/helper/images.dart';
// import 'package:velvot_pay/helper/screen_size.dart';
// import 'package:velvot_pay/provider/choose_plan_provider.dart';
// import 'package:velvot_pay/provider/data_subscription_provider.dart';
// import 'package:velvot_pay/screens/dashboard/home/pay_screen.dart';
// import 'package:velvot_pay/utils/constants.dart';
// import 'package:velvot_pay/utils/utils.dart';
// import 'package:velvot_pay/widget/appBar.dart';
// import 'package:velvot_pay/widget/custom_divider.dart';

// class ChoosePlanScreen extends StatefulWidget {
//   final String serviceId;
//   final String? number;
//   final String operatorName;
//   final String operatorImage;
//   final String  route;
//   final String isFromSearchNumberRoute;
//   Map? data;
//     ChoosePlanScreen({required this.serviceId, this.number, required this.operatorName,required this.operatorImage,this.data, required this.route,
//     required this.isFromSearchNumberRoute
//     });

//   @override
//   State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
// }

// class _ChoosePlanScreenState extends State<ChoosePlanScreen> {


//   @override
//   void initState() {
//     // TODO: implement initState
//     callInitFunction();
//     super.initState();
//   }


//   callInitFunction(){
//     final provider = Provider.of<ChoosePlanProvider>(context,listen: false);
//     Future.delayed(Duration.zero,(){
//      if(widget.route=='operator') {
//        provider.getDataSubscriptionPlanApiFunction(widget.serviceId);
//      }else if(widget.route=='electricity'){
//        // provider.getElectricityPlanApiFunction(widget.serviceId, widget.data!['meterNumber'], widget.data!['billType']);
//      }else if(widget.route=='education'){
//        provider.getEducationPlanApiFunction(widget.serviceId);
//      }else if(widget.route=='tv'){
//        provider.getTVSubscriptionPlanApiFunction(widget.serviceId);
//      }else if(widget.route.contains('insurance')){
//        provider.getInsurancePlanApiFunction(widget.serviceId);
//      }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(widget.serviceId);
//     return Scaffold(
//       appBar: appBar(
//           title: 'Choose Your Plan',
//           onTap: () {
//             Navigator.pop(context);
//           }),
//       body: Consumer<ChoosePlanProvider>(
//         builder: (context,myProvider,child) {
//           return widget.route=='operator'?
//           dataSubscriptionPlanWidget(myProvider):
//               widget.route=='education'?
//               educationPlanWidget(myProvider):
//                   widget.route=='tv'?
//           tvSubscriptionPlanWidget(myProvider):
//           widget.route.contains('insurance')?
//               insurancePlanWidget(myProvider):
//               Container();
//         }
//       ),
//     );
//   }

//   dataSubscriptionPlanWidget(ChoosePlanProvider provider,) {
//     return provider.model!=null&&provider.model!.data!=null&&
//         provider.model!.data!.varations!=null?ListView.separated(
//         separatorBuilder: (context, sp) {
//           return ScreenSize.height(15);
//         },
//         itemCount: provider.model!.data!.varations!.length,
//         padding:
//         const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 40),
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return
//             GestureDetector(
//               onTap: () {
//                 AppRoutes.pushNavigation(PayScreen(
//                   route: widget.route,
//                   isFromSearchNumberRoute: widget.isFromSearchNumberRoute,
//                   data: {
//                     'amount':provider.model!.data!.varations![index].price??"",
//                     'number':widget.number,
//                       'operatorImage':widget.operatorImage,
//                       'operatorName':widget.operatorName,
//                       'serviceId':widget.serviceId,
//                     'data':provider.model!.data!.varations![index].dataT??"",
//                     'validity':provider.model!.data!.varations![index].time??"",
//                     'variation_code':provider.model!.data!.varations![index].variationCode??"",
//                   },
//                 ));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: AppColor.lightAppColor,
//                     borderRadius: BorderRadius.circular(5)),
//                 padding:
//                 const EdgeInsets.only(left: 15, top: 17, right: 15, bottom: 15),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Column(
//                           children: [
//                             getText(
//                                 title: '₦${provider.model!.data!.varations![index].price??""}',
//                                 size: 23,
//                                 fontFamily: Constants.poppinsSemiBold,
//                                 color: AppColor.darkBlackColor,
//                                 fontWeight: FontWeight.w600),
//                             Row(
//                               children: [
//                                 getText(
//                                     title: 'Data :',
//                                     size: 12,
//                                     fontFamily: Constants.poppinsMedium,
//                                     color: AppColor.hintTextColor,
//                                     fontWeight: FontWeight.w400),
//                                 getText(
//                                     title: provider.model!.data!.varations![index].dataT??"",
//                                     size: 14,
//                                     fontFamily: Constants.poppinsSemiBold,
//                                     color: AppColor.darkBlackColor,
//                                     fontWeight: FontWeight.w600),
//                               ],
//                             )
//                           ],
//                         ),
//                         ScreenSize.width(35),
//                         Container(
//                           height: 40,
//                           width: 1,
//                           color: AppColor.hintTextColor,
//                         ),
//                         ScreenSize.width(20),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               getText(
//                                   title: 'Validity :',
//                                   size: 12,
//                                   fontFamily: Constants.poppinsMedium,
//                                   color: AppColor.hintTextColor,
//                                   fontWeight: FontWeight.w400),
//                               Text("${provider.model!.data!.varations![index].dataT??""} per pack",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontFamily: Constants.poppinsSemiBold,
//                                     color: AppColor.darkBlackColor,
//                                     fontWeight: FontWeight.w600
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // const Spacer(),
//                         SvgPicture.asset(Images.planArrowIcon)
//                       ],
//                     ),
//                     // ScreenSize.height(15),
//                     // customDivider(0),
//                     // ScreenSize.height(15),
//                     // Row(
//                     //   children: [
//                     //     getText(
//                     //         title: 'Sms :',
//                     //         size: 12,
//                     //         fontFamily: Constants.poppinsMedium,
//                     //         color: AppColor.hintTextColor,
//                     //         fontWeight: FontWeight.w400),
//                     //     ScreenSize.width(7),
//                     //     getText(
//                     //         title: '100/day',
//                     //         size: 14,
//                     //         fontFamily: Constants.poppinsSemiBold,
//                     //         color: AppColor.darkBlackColor,
//                     //         fontWeight: FontWeight.w600),
//                     //     ScreenSize.width(23),
//                     //     getText(
//                     //         title: 'Calls :',
//                     //         size: 12,
//                     //         fontFamily: Constants.poppinsMedium,
//                     //         color: AppColor.hintTextColor,
//                     //         fontWeight: FontWeight.w400),
//                     //     ScreenSize.width(7),
//                     //     getText(
//                     //         title: 'Unlimited Calls',
//                     //         size: 14,
//                     //         fontFamily: Constants.poppinsSemiBold,
//                     //         color: AppColor.darkBlackColor,
//                     //         fontWeight: FontWeight.w600),
//                     //   ],
//                     // )
//                   ],
//                 ),
//               ),
//             );
//         }):Container();

//   }

// tvSubscriptionPlanWidget(ChoosePlanProvider provider){
//     return provider.tvSubscriptionPlanModel!=null&&provider.tvSubscriptionPlanModel!.data!=null&&
//         provider.tvSubscriptionPlanModel!.data!.varations!=null?
//         ListView.separated(
//             separatorBuilder: (context,sp){
//               return ScreenSize.height(15);
//             },
//           itemCount: provider.tvSubscriptionPlanModel!.data!.varations!.length,
//           padding:
//               const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 40),
//           shrinkWrap: true,
//             itemBuilder: (context,index){
//           return GestureDetector(
//             onTap: (){
//               AppRoutes.pushNavigation(PayScreen(
//                 isFromSearchNumberRoute: widget.isFromSearchNumberRoute,
//                 route: widget.route,
//                 data: {
//                   'amount':provider.tvSubscriptionPlanModel!.data!.varations![index].variationAmount,
//                   'billerData':widget.data,
//                   'operatorImage':widget.operatorImage,
//                   'operatorName':widget.operatorName,
//                   'planName':provider.tvSubscriptionPlanModel!.data!.varations![index].name,
//                   'serviceId':widget.serviceId,
//                   'variation_code':provider.tvSubscriptionPlanModel!.data!.varations![index].variationCode??"",
//                 },
//               ));
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   color: AppColor.lightAppColor,
//                   borderRadius: BorderRadius.circular(5)),
//               padding:
//               const EdgeInsets.only(left: 15, top: 17, right: 15, bottom: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         getText(
//                             title: '₦${provider.tvSubscriptionPlanModel!.data!.varations![index].variationAmount??''}',
//                             size: 23,
//                             fontFamily: Constants.poppinsSemiBold,
//                             color: AppColor.darkBlackColor,
//                             fontWeight: FontWeight.w600),
//                         getText(
//                             title: provider.tvSubscriptionPlanModel!.data!.varations![index].name??'',
//                             size: 13,
//                             fontFamily: Constants.poppinsSemiBold,
//                             color: AppColor.hintTextColor,
//                             fontWeight: FontWeight.w600),
//                       ],
//                     ),
//                   ),
//                   ScreenSize.width(5),
//                   SvgPicture.asset(Images.planArrowIcon)
//                 ],
//               ),
//             ),
//           );
//         },
//         ):Container();
//  }

//   educationPlanWidget(ChoosePlanProvider provider){
//     return provider.educationPlanModel!=null&&provider.educationPlanModel!.data!=null&&
//         provider.educationPlanModel!.data!.varations!=null?
//     ListView.separated(
//       separatorBuilder: (context,sp){
//         return ScreenSize.height(15);
//       },
//       itemCount: provider.educationPlanModel!.data!.varations!.length,
//       padding:
//       const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 40),
//       shrinkWrap: true,
//       itemBuilder: (context,index){
//         return GestureDetector(
//           onTap: (){
//             AppRoutes.pushNavigation(PayScreen(
//               isFromSearchNumberRoute: widget.isFromSearchNumberRoute,
//               route: widget.route,
//               data: {
//                 'amount':provider.educationPlanModel!.data!.varations![index].variationAmount,
//                 'billerData':widget.data,
//                 'operatorImage':widget.operatorImage,
//                 'operatorName':widget.operatorName,
//                 'planName':provider.educationPlanModel!.data!.varations![index].name,
//                 'serviceId':widget.serviceId,
//                 'variation_code':provider.educationPlanModel!.data!.varations![index].variationCode??"",
//               },
//             ));
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 color: AppColor.lightAppColor,
//                 borderRadius: BorderRadius.circular(5)),
//             padding:
//             const EdgeInsets.only(left: 15, top: 17, right: 15, bottom: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       getText(
//                           title: '₦${provider.educationPlanModel!.data!.varations![index].variationAmount??''}',
//                           size: 23,
//                           fontFamily: Constants.poppinsSemiBold,
//                           color: AppColor.darkBlackColor,
//                           fontWeight: FontWeight.w600),
//                       getText(
//                           title: provider.educationPlanModel!.data!.varations![index].name??'',
//                           size: 13,
//                           fontFamily: Constants.poppinsSemiBold,
//                           color: AppColor.hintTextColor,
//                           fontWeight: FontWeight.w600),
//                     ],
//                   ),
//                 ),
//                 ScreenSize.width(5),
//                 SvgPicture.asset(Images.planArrowIcon)
//               ],
//             ),
//           ),
//         );
//       },
//     ):Container();
//   }

//   insurancePlanWidget(ChoosePlanProvider provider){
//     return provider.insurancePlanModel!=null&&provider.insurancePlanModel!.data!=null&&
//         provider.insurancePlanModel!.data!.varations!=null?
//     ListView.separated(
//       separatorBuilder: (context,sp){
//         return ScreenSize.height(15);
//       },
//       itemCount: provider.insurancePlanModel!.data!.varations!.length,
//       padding:
//       const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 40),
//       shrinkWrap: true,
//       itemBuilder: (context,index){
//         return GestureDetector(
//           onTap: (){
//             AppRoutes.pushNavigation(PayScreen(
//               isFromSearchNumberRoute: widget.isFromSearchNumberRoute,
//               route: widget.route,
//               data: {
//                 'amount':provider.insurancePlanModel!.data!.varations![index].variationAmount,
//                   'billerData':widget.data,
//                 'operatorImage':widget.operatorImage,
//                 'operatorName':widget.operatorName,
//                 'serviceId':widget.serviceId,
//                 'planName':provider.insurancePlanModel!.data!.varations![index].name,
//                 'variation_code':provider.insurancePlanModel!.data!.varations![index].variationCode??"",
//               },
//             ));
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 color: AppColor.lightAppColor,
//                 borderRadius: BorderRadius.circular(5)),
//             padding:
//             const EdgeInsets.only(left: 15, top: 17, right: 15, bottom: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       getText(
//                           title: '₦${provider.insurancePlanModel!.data!.varations![index].variationAmount??''}',
//                           size: 23,
//                           fontFamily: Constants.poppinsSemiBold,
//                           color: AppColor.darkBlackColor,
//                           fontWeight: FontWeight.w600),
//                       getText(
//                           title: provider.insurancePlanModel!.data!.varations![index].name??'',
//                           size: 13,
//                           fontFamily: Constants.poppinsSemiBold,
//                           color: AppColor.hintTextColor,
//                           fontWeight: FontWeight.w600),
//                     ],
//                   ),
//                 ),
//                 ScreenSize.width(5),
//                 SvgPicture.asset(Images.planArrowIcon)
//               ],
//             ),
//           ),
//         );
//       },
//     ):Container();
//   }


// }

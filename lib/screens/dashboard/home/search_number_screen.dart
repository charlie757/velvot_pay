// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:velvot_pay/approutes/app_routes.dart';
// import 'package:velvot_pay/helper/app_color.dart';
// import 'package:velvot_pay/helper/getText.dart';
// import 'package:velvot_pay/helper/images.dart';
// import 'package:velvot_pay/helper/screen_size.dart';
// import 'package:velvot_pay/provider/data_subscription_provider.dart';
// import 'package:velvot_pay/screens/dashboard/home/choose_plan_screen.dart';
// import 'package:velvot_pay/utils/Constants.dart';

// import 'bill_number_screen.dart';

// class SearchNumberScreen extends StatefulWidget {
//   final String serviceId;
//   String operatorName;
//   String operatorImage;
//   final String route;
//   final String? minimiumAmount;
//   final String? maximumAmount;
//    SearchNumberScreen({required this.serviceId, required this.operatorName,required this.operatorImage,required this.route,
//    this.minimiumAmount,this.maximumAmount
//    });

//   @override
//   State<SearchNumberScreen> createState() => _SearchNumberScreenState();
// }

// class _SearchNumberScreenState extends State<SearchNumberScreen> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     callInitFunction();
//     super.initState();
//   }

//   callInitFunction(){
//     final provider = Provider.of<DataSubscriptionProvider>(context,listen: false);
//     provider.resetValues();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Consumer<DataSubscriptionProvider>(
//         builder: (context,myProvider, child) {
//           return SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [customSearchBarWidget(myProvider),
//                  Padding(
//                      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
//                      child: getText(
//                       title: 'Search Results',
//                       size: 16,
//                       fontFamily: Constants.poppinsSemiBold,
//                       color: AppColor.darkBlackColor,
//                       fontWeight: FontWeight.w600)),
//                   ScreenSize.height(5),
//                   myProvider.searchList.isEmpty&&myProvider.unknownNumber.isNotEmpty?
//                   Container(
//                     padding:const EdgeInsets.only(left: 30,right: 30,top: 15),
//                     child: showNumberWidget(myProvider.unknownNumber,  () {
//                        if(widget.route=='topup'){
//                          AppRoutes.pushNavigation(BillNumberScreen(
//                            route: widget.route,
//                            serviceId: widget.serviceId,
//                            operatorName: widget.operatorName,operatorImage: widget.operatorImage,
//                            maximumAmount: widget.maximumAmount,
//                            minimiumAmount:widget. minimiumAmount,
//                            number: myProvider.unknownNumber.toString(),
//                            isFromSearchNumberRoute: 'search',
//                          ));
//                        }
//                        else {
//                          AppRoutes.pushNavigation(ChoosePlanScreen(
//                            serviceId: widget.serviceId,
//                            number: myProvider.unknownNumber.toString(),
//                            operatorImage: widget.operatorImage,
//                            operatorName: widget.operatorName,
//                            route: widget.route,
//                            isFromSearchNumberRoute: 'search',
//                          ));
//                        }
//                     }),
//                   ):
//                   Expanded(child: searchResultWidget(myProvider))
//                 ],
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }

//   searchResultWidget(DataSubscriptionProvider provider) {
//     return
//     ListView.separated(
//       separatorBuilder: (context,sp){
//         return ScreenSize.height(13);
//       },
//         itemCount: provider.searchList.length,
//         padding: const EdgeInsets.only(left: 30, right: 30, top: 15,bottom: 30),
//         shrinkWrap: true,
//         itemBuilder: (context,index){
//           return showNumberWidget( provider.searchList[index].phones.isNotEmpty? provider.searchList[index].phones.first.number.toString():"", () {
//             if(widget.route=='topup'){
//               AppRoutes.pushNavigation(BillNumberScreen(
//                 route: widget.route,
//                 serviceId: widget.serviceId,
//                 operatorName: widget.operatorName,operatorImage: widget.operatorImage,
//                 maximumAmount: widget.maximumAmount,
//                 minimiumAmount:widget. minimiumAmount,
//                 number: provider.searchList[index].phones.first.number
//                     .toString(),
//                 isFromSearchNumberRoute: 'search',
//               ));
//             }
//             else {
//               AppRoutes.pushNavigation(ChoosePlanScreen(
//                 serviceId: widget.serviceId,
//                 number: provider.searchList[index].phones.first.number
//                     .toString(),
//                 operatorImage: widget.operatorImage,
//                 operatorName: widget.operatorName,
//                 route: widget.route,
//                 isFromSearchNumberRoute: 'search',
//               ));
//             }
//           });
//         });
//   }

//   showNumberWidget(String number, Function()onTap){
//     return  GestureDetector(
//       onTap: onTap,
//       child: Container(
//         color: AppColor.whiteColor,
//         child: Row(
//           children: [
//             Container(
//               height: 47,
//               width: 47,
//               decoration: BoxDecoration(
//                   color:const Color(0xff181D3D),
//                   border: Border.all(color: AppColor.e1Color),
//                   borderRadius: BorderRadius.circular(25)),
//               alignment: Alignment.center,
//               child: getText(
//                   title:number.isNotEmpty?
//                   number.length>2?
//                   number.contains('+')?
//                   number.substring(1,3):
//                   number.substring(0,2):
//                   number:
//                   "",
//                   size: 18,
//                   fontFamily: Constants.poppinsMedium,
//                   color: AppColor.whiteColor,
//                   fontWeight: FontWeight.w600),
//             ),
//             ScreenSize.width(14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     number,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: Constants.poppinsMedium,
//                         color: AppColor.darkBlackColor,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   ScreenSize.height(5),
//                   getText(
//                       title: 'Tap to recharge this number',
//                       size: 14,
//                       fontFamily: Constants.poppinsMedium,
//                       color: AppColor.purpleColor,
//                       fontWeight: FontWeight.w500)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   customSearchBarWidget(DataSubscriptionProvider provider) {
//     return Container(
//       height: 58,
//       width: double.infinity,
//       padding: const EdgeInsets.only(left: 18, right: 10),
//       decoration: BoxDecoration(color: AppColor.lightAppColor),
//       child: Row(
//         children: [
//           GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: SvgPicture.asset(Images.arrowBackImage)),
//           ScreenSize.width(15),
//           Expanded(
//               child: TextFormField(
//                 // keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9 ]+$'))
//                   // LengthLimitingTextInputFormatter(10),
//                   // FilteringTextInputFormatter.digitsOnly
//                 ],
//             style: TextStyle(

//                 color: AppColor.darkBlackColor,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: Constants.poppinsMedium),
//             decoration: const InputDecoration(border: InputBorder.none),
//                 onChanged: (val){
//                   if(val.isEmpty){
//                     provider.noDataFound=false;
//                     provider.unknownNumber='';
//                     provider.searchList.clear();
//                     setState(() {

//                     });
//                   }
//                   else{
//                     provider.searchFunction(val);
//                   }
//                 },
//           ))
//         ],
//       ),
//     );
//   }
// }

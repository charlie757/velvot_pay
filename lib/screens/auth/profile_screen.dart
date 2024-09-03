// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:velvot_pay/helper/app_color.dart';
// import 'package:velvot_pay/helper/custom_btn.dart';
// import 'package:velvot_pay/helper/custom_textfield.dart';
// import 'package:velvot_pay/helper/getText.dart';
// import 'package:velvot_pay/helper/images.dart';
// import 'package:velvot_pay/helper/network_image_helper.dart';
// import 'package:velvot_pay/helper/screen_size.dart';
// import 'package:velvot_pay/provider/profile_provider.dart';
// import 'package:velvot_pay/utils/emoji_restrict.dart';
// import 'package:velvot_pay/utils/utils.dart';
// import 'package:velvot_pay/widget/appBar.dart';
//
// import '../../utils/constants.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final String route;
//   final String number;
//   const ProfileScreen({required this.route, this.number = ''});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     callInitFunction();
//     super.initState();
//   }
//
//   callInitFunction() {
//     final profileProvider =
//         Provider.of<ProfileProvider>(context, listen: false);
//     if (widget.route == 'login') {
//       profileProvider.resetValues();
//       profileProvider.numberController.text = widget.number;
//     } else {
//       Future.delayed(Duration.zero, () {
//         profileProvider.getProfileApiFunction();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(
//           title: widget.route == 'login' ? 'Complete Profile' : "Profile",
//           isShowArrow: widget.route == 'login' ? true : false,
//           onTap: () {
//             Navigator.pop(context);
//           }),
//       body: Consumer<ProfileProvider>(builder: (context, myProvider, child) {
//         return Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 top: 20,
//                 bottom: widget.route == 'login' ? 30 : 120),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: profileWidget(myProvider),
//                 ),
//                 ScreenSize.height(30),
//                 getText(
//                     title: 'Name',
//                     size: 16,
//                     fontFamily: Constants.poppinsMedium,
//                     color: AppColor.darkBlackColor,
//                     fontWeight: FontWeight.w500),
//                 ScreenSize.height(10),
//                 CustomTextField(
//                   isReadOnly: myProvider.isLoading,
//                   hintText: 'Full Name',
//                   inputFormatters: [EmojiRestrictingTextInputFormatter()],
//                   textInputAction: TextInputAction.next,
//                   controller: myProvider.firstNameController,
//                   validator: (val) {
//                     if (val.isEmpty) {
//                       return "Enter your name";
//                     }
//                   },
//                 ),
//                 ScreenSize.height(30),
//                 getText(
//                     title: 'Email Address',
//                     size: 16,
//                     fontFamily: Constants.poppinsMedium,
//                     color: AppColor.darkBlackColor,
//                     fontWeight: FontWeight.w500),
//                 ScreenSize.height(10),
//                 CustomTextField(
//                   isReadOnly:
//                       widget.route == 'login' ? myProvider.isLoading : true,
//                   hintText: 'Email Address',
//                   textInputAction: TextInputAction.next,
//                   controller: myProvider.emailController,
//                   inputFormatters: [EmojiRestrictingTextInputFormatter()],
//                   validator: (val) {
//                     RegExp regExp = RegExp(Utils.emailPattern.trim());
//
//                     if (val.isEmpty) {
//                       return "Enter your email";
//                     } else if (!regExp.hasMatch(val)) {
//                       return "Email should be valid";
//                     }
//                   },
//                   suffixWidget: Container(
//                     height: 20,
//                     width: 20,
//                     alignment: Alignment.center,
//                     child: SvgPicture.asset(
//                       Images.emailVerifyIcon,
//                     ),
//                   ),
//                 ),
//                 ScreenSize.height(30),
//                 getText(
//                     title: 'Mobile Number',
//                     size: 16,
//                     fontFamily: Constants.poppinsMedium,
//                     color: AppColor.darkBlackColor,
//                     fontWeight: FontWeight.w500),
//                 ScreenSize.height(10),
//                 CustomTextField(
//                   hintText: 'Mobile Number',
//                   isReadOnly: true,
//                   fillColor: AppColor.hintTextColor,
//                   controller: myProvider.numberController,
//                   textInputAction: TextInputAction.next,
//                   textColor: AppColor.whiteColor,
//                 ),
//                 ScreenSize.height(30),
//                 getText(
//                     title: 'Address',
//                     size: 16,
//                     fontFamily: Constants.poppinsMedium,
//                     color: AppColor.darkBlackColor,
//                     fontWeight: FontWeight.w500),
//                 ScreenSize.height(10),
//                 addressTextField(myProvider),
//                 ScreenSize.height(20),
//                 CustomBtn(
//                     isLoading: myProvider.isLoading,
//                     title: widget.route == 'login' ? "Continue" : 'Save',
//                     onTap: () {
//                       if (widget.route == 'login') {
//                         myProvider.checkValidation(formKey);
//                       } else {
//                         myProvider.checkUpdateProfileValidation(formKey);
//                       }
//                     })
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   profileWidget(ProfileProvider provider) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             Container(
//               height: 96,
//               width: 96,
//               decoration: BoxDecoration(
//                   border: Border.all(color: AppColor.darkBlackColor, width: 3),
//                   borderRadius: BorderRadius.circular(50)),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: provider.file != null
//                       ? Image.file(
//                           File(provider.file!.path),
//                           width: double.infinity,
//                           height: double.infinity,
//                           fit: BoxFit.cover,
//                         )
//                       : provider.model != null && provider.model!.data != null
//                           ? NetworkImagehelper(
//                               img: provider.model!.data!.imageUrl,
//                               height: 96.0,
//                               width: 96.0,
//                             )
//                           : Image.asset('assets/icons/Mask.png')),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: () {
//                   imagePickerBottomSheet(provider);
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                       color: AppColor.whiteColor,
//                       borderRadius: BorderRadius.circular(15),
//                       border:
//                           Border.all(color: AppColor.darkBlackColor, width: 2)),
//                   alignment: Alignment.center,
//                   child: Image.asset(
//                     Images.cameraIcon,
//                     height: 11,
//                     width: 11,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         ScreenSize.height(6),
//         provider.isPhotoError
//             ? getText(
//                 title: 'Select photo',
//                 size: 13,
//                 fontFamily: Constants.poppinsRegular,
//                 color: AppColor.redColor,
//                 fontWeight: FontWeight.w400)
//             : Container()
//       ],
//     );
//   }
//
//   addressTextField(ProfileProvider provider) {
//     return TextFormField(
//       autofocus: false,
//       maxLines: 4,
//       controller: provider.addressController,
//       textInputAction: TextInputAction.done,
//       readOnly: provider.isLoading,
//       inputFormatters: [EmojiRestrictingTextInputFormatter()],
//       style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 12,
//           color: Color(0xff0E0E0E),
//           fontFamily: Constants.poppinsRegular),
//       cursorColor: AppColor.blackColor,
//       decoration: InputDecoration(
//         fillColor: AppColor.lightAppColor,
//         filled: true,
//         border: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColor.redColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColor.redColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         hintText: 'Type here...',
//         errorStyle: TextStyle(
//           color: AppColor.redColor,
//         ),
//         hintStyle: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 14,
//             color: AppColor.hintTextColor,
//             fontFamily: Constants.poppinsRegular),
//       ),
//       validator: (val) {
//         if (val!.isEmpty) {
//           return "Enter your address";
//         }
//       },
//     );
//   }
//
//   imagePickerBottomSheet(ProfileProvider profileProvider) {
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: AppColor.whiteColor,
//         builder: (context) {
//           return Container(
//             padding:
//                 const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     getText(
//                         title: 'Profile Photo',
//                         size: 17,
//                         fontFamily: Constants.poppinsMedium,
//                         color: AppColor.blackColor,
//                         fontWeight: FontWeight.w500),
//                     GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Icon(Icons.close))
//                   ],
//                 ),
//                 ScreenSize.height(25),
//                 Row(
//                   children: [
//                     imagePickType(Icons.camera_alt_outlined, "Camera", () {
//                       Navigator.pop(context);
//                       profileProvider.imagePicker(ImageSource.camera);
//                     }),
//                     ScreenSize.width(30),
//                     imagePickType(Icons.image_outlined, "Gallery", () {
//                       Navigator.pop(context);
//                       profileProvider.imagePicker(ImageSource.gallery);
//                     }),
//                   ],
//                 )
//               ],
//             ),
//           );
//         });
//   }
//
//   imagePickType(icon, String title, Function() onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 50,
//             width: 50,
//             decoration: BoxDecoration(
//               color: AppColor.hintTextColor,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: AppColor.lightAppColor,
//             ),
//           ),
//           ScreenSize.height(5),
//           getText(
//               title: title,
//               size: 14,
//               fontFamily: Constants.poppinsRegular,
//               color: AppColor.blackColor,
//               fontWeight: FontWeight.w400)
//         ],
//       ),
//     );
//   }
// }

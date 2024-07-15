// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/images.dart';

class NetworkImagehelper extends StatelessWidget {
  final img;
  final height;
  final width;
  const NetworkImagehelper({ this.img, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      height: height,
      width: width,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              color: AppColor.hintTextColor,
              strokeWidth: 2,
              value: downloadProgress.progress)),
      errorWidget: (context, url, error) => Image.asset(Images.vpLogo),
    );
  }
}

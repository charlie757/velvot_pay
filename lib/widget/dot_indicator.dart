import 'package:flutter/material.dart';
import 'package:velvot_pay/helper/app_color.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int activeDotIndex;
  final double dotWidth;
  final double dotHeight;

  const DotsIndicator({
    Key? key,
    required this.dotsCount,
    required this.activeDotIndex,
    this.dotWidth = 4.0,
    this.dotHeight = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotsCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: index == activeDotIndex ?18:5,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == activeDotIndex ?AppColor.greenColor:AppColor.blackColor,
            border: Border.all(color: AppColor.greenColor,)
          ),
          padding:const EdgeInsets.all(2),
        );
      }),
    );
  }
}

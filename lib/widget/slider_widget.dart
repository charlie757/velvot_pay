import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/helper/network_image_helper.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';

sliderWidget(DashboardProvider dashboardProvider) {
  return SizedBox(
    height: 184,
    width: double.infinity,
    child: CarouselSlider.builder(
      itemCount: dashboardProvider.bannerModel!.data!.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Container(
          margin: const EdgeInsets.only(right: 5, left: 5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: NetworkImagehelper(
                img:
                    "${ApiUrl.imgBaseUrl}${dashboardProvider.bannerModel!.data![itemIndex].imageUrl}",
                height: 168.0,
                width: double.infinity,
              )),
        );
      },
      options: CarouselOptions(
          autoPlay: true,
          scrollDirection: Axis.horizontal,
          // enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 1.0,
          initialPage: 0,
          autoPlayCurve: Curves.ease,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 400),
          autoPlayInterval: const Duration(seconds: 4),
          onPageChanged: (val, _) {
            // provider.updateSliderIndex(val);
          }),
    ),
  );
}

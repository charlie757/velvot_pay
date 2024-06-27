import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

sliderWidget() {
  return SizedBox(
    height: 184,
    width: double.infinity,
    child: CarouselSlider.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Container(
          margin: const EdgeInsets.only(right: 5, left: 5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/icons/slider_image.png',
                width: double.infinity,
                fit: BoxFit.cover,
              )
              // NetworkImageHelper(
              //   img:
              //   "${provider.homeModel!.data!.bannerPath}${provider.homeModel!.data!.banners![itemIndex].bannerImage}",
              //   height: 168.0,
              //   width: double.infinity,
              //   isAnotherColorOfLodingIndicator: true,
              // )
              ),
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

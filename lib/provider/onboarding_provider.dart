import 'package:flutter/material.dart';
import 'package:velvot_pay/helper/images.dart';

class OnBoardingProvider extends ChangeNotifier{

  int currentIndex =0;

  updateIndex(int index){
    currentIndex=index;
    notifyListeners();
  }

  List list = [
    {
      'img':Images.onBoarding1Image,
      'title':"All Your Bills in One Place",
      'des':'Track your transaction history and keep all your payments organized.'
    },
    {
      'img':Images.onBoarding2Image,
      'title':"Pay your Electricity bills in an instant",
      'des':'Experience fast, secure electricity bill payments and keep the lights on effortlessly'
    },
    {
      'img':Images.onBoarding3Image,
      'title':"Make Secure Payments with Just a Tap",
      'des':'Quick, secure POS payments for hassle-free transactions, anytime, anywhere.'
    },
  ];
}
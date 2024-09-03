import 'package:flutter/material.dart';

class AddEmailProvider extends ChangeNotifier{
  bool isLoading = false;
  updateLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}
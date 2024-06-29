import 'package:flutter/material.dart';

import '../screens/dashboard/history/history_screen.dart';
import '../screens/dashboard/home/home_screen.dart';
import '../screens/dashboard/myprofile/profile_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 1;
  List screenList = [HistoryScreen(), HomeScreen(), ProfileScreen()];

  updateIndex(val) {
    currentIndex = val;
    notifyListeners();
  }
}

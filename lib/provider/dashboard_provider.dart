import 'package:flutter/material.dart';
import 'package:velvot_pay/screens/auth/profile_screen.dart';

import '../screens/dashboard/history/history_screen.dart';
import '../screens/dashboard/home/home_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 1;
  List screenList = [
    HistoryScreen(),
    HomeScreen(),
    ProfileScreen(
      route: '',
    )
  ];

  updateIndex(val) {
    currentIndex = val;
    notifyListeners();
  }
}

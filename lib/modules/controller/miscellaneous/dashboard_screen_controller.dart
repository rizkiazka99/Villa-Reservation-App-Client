import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/view/contents/bookings_screen.dart';
import 'package:reservilla/modules/view/contents/home_screen.dart';
import 'package:reservilla/modules/view/contents/profile_screen.dart';

class DashboardScreenController extends GetxController {
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    const HomeScreen(
      key: PageStorageKey('Page1'),
    ),
    const BookingsScreen(
      key: PageStorageKey('Page2'),
    ),
    const ProfileScreen(
      key: PageStorageKey('Page3'),
    )
  ];

  RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int selectedIndex) =>
      this._selectedIndex.value = selectedIndex;
}
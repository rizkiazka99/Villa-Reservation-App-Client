import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/view/contents/bookings/bookings_screen.dart';
import 'package:reservilla/modules/view/contents/home_screen.dart';
import 'package:reservilla/modules/view/contents/profile_screen.dart';

class DashboardScreenController extends GetxController with GetTickerProviderStateMixin {
  final PageStorageBucket bucket = PageStorageBucket();

  late AnimationController homeController;
  late AnimationController bookingsController;
  late AnimationController profileController;

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

  @override
  void onInit() {
    super.onInit();
    homeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
    bookingsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
    profileController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
  }

  @override
  void dispose() {
    homeController.dispose();
    bookingsController.dispose();
    profileController.dispose();
    super.dispose();
  }
  
  void onItemTapped(int index) {
    selectedIndex = index;
  }
}
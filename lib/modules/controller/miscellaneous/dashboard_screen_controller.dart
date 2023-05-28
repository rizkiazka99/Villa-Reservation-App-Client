import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/miscellaneous/user_response.dart';
import 'package:reservilla/modules/view/contents/bookings/bookings_screen.dart';
import 'package:reservilla/modules/view/contents/home_screen.dart';
import 'package:reservilla/modules/view/contents/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreenController extends GetxController with GetTickerProviderStateMixin {
  final PageStorageBucket bucket = PageStorageBucket();
  Repository repository = Repository();

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
  RxBool _userLoading = false.obs;
  Rxn<UserResponse> _user = Rxn<UserResponse>();

  int get selectedIndex => _selectedIndex.value;
  bool get userLoading => _userLoading.value;
  UserResponse? get user => _user.value;

  set selectedIndex(int selectedIndex) =>
      this._selectedIndex.value = selectedIndex;
  set userLoading(bool userLoading) =>
      this._userLoading.value = userLoading;
  set user(UserResponse? user) => 
      this._user.value = user;

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
    getUserById();
  }

  @override
  void dispose() {
    homeController.dispose();
    bookingsController.dispose();
    profileController.dispose();
    super.dispose();
  }
  
  void onItemTapped(int index) {
    if (index == 0) {
      if (homeController.status == AnimationStatus.dismissed) {
        homeController.reset();
        homeController.animateTo(0.6);
      } else {
        homeController.reverse();
      }
      selectedIndex = index;
    } else {
      if (index == 1) {
        bookingsController.reset();
        bookingsController.forward();
        selectedIndex = index;
      } else {
        profileController.reset();
        profileController.forward();
        selectedIndex = index;
      }
    }
  }

  Future<UserResponse?> getUserById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('id').toString();

    userLoading = true;
    UserResponse? res = await repository.getUserById(id);
    user = res;
    userLoading = false;

    return user;
  }
}
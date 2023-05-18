import 'dart:async';
import 'package:get/get.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  void nextDestination() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      Get.offAllNamed(loginScreenRoute);
    } else {
      Get.offAllNamed(dashboardScreenRoute);
    }
  }

  loadingApp() {
    return Timer(
      const Duration(seconds: 2), 
      nextDestination
    );
  }

  @override
  void onInit() {
    super.onInit();
    loadingApp();
  }
}
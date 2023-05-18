import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/miscellaneous/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController controller = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
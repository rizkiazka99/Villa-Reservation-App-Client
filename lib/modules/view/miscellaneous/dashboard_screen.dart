import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardScreenController controller = Get.find<DashboardScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => PageStorage(
        bucket: controller.bucket, 
        child: controller.pages[controller.selectedIndex]
      ))
    );
  }
}
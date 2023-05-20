import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/home_screen_controller.dart';
import 'package:reservilla/modules/view/home/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

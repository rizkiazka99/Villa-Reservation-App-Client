import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';
import 'package:lottie/lottie.dart';

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
      )),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Obx(() => BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    if (controller.homeController.status == AnimationStatus.dismissed) {
                      controller.homeController.reset();
                      controller.homeController.animateTo(0.6);
                    } else {
                      controller.homeController.reverse();
                    }
                    controller.onItemTapped(0);
                  },
                  splashRadius: 50,
                  splashColor: contextOrange,
                  icon: Lottie.asset(
                    Icons8.icons8_home_7_,
                    controller: controller.homeController,
                    width: 35,
                    height: 35
                  )
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    controller.bookingsController.reset();
                    controller.bookingsController.forward();
                    controller.onItemTapped(1);
                  },
                  splashRadius: 50,
                  splashColor: contextOrange,
                  icon: Lottie.asset(
                    Icons8.list,
                    controller: controller.bookingsController,
                    width: 35,
                    height: 35
                  ),
                ),
                label: 'Bookings'
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    controller.profileController.reset();
                    controller.profileController.forward();
                    controller.onItemTapped(2);
                  },
                  splashRadius: 50,
                  splashColor: contextOrange, 
                  icon: Lottie.asset(
                    Icons8.icons8_user_male,
                    controller: controller.profileController,
                    width: 35,
                    height: 35
                  )
                ),
                label: 'Profile'
              )
            ],
            currentIndex: controller.selectedIndex,
            elevation: 16
          )),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/modules/controller/contents/locations/location_screen_controller.dart';
import 'package:reservilla/modules/controller/contents/home_screen_controller.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/skeleton_loader.dart';
import 'package:reservilla/widgets/villa_card.dart';
import 'package:reservilla/widgets/city_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.find<HomeScreenController>();
  LocationScreenController locationController = Get.find<LocationScreenController>();
  DashboardScreenController dashboardScreenController = Get.find<DashboardScreenController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        locationController.getLocations();
        return controller.getVillas();
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: edge,
                      ),
                      // NOTE: TITLE/HEADER
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Obx(() => dashboardScreenController.user == null ? 
                            const SizedBox.shrink() : Text(
                            'Hi, ${dashboardScreenController.user!.data.name}',
                            style: blackTextStyle.copyWith(fontSize: 24),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Selamat Datang di ReserVilla',
                          style: greyTextStyle.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // NOTE: POPULAR CITIES
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Kota - Kota Populer',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 150,
                        child: Obx(() => locationController.locationsLoading ? const SkeletonLoader()
                            : CityCard(locationController.locations)
                        )
                      ),
                      const SizedBox(height: 30),
                      // NOTE: RECOMMENDED SPACE
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Villa - Villa Paling Recommended',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() => controller.villasLoading ? Column(
                          children: List.generate(4, (index) => const SkeletonLoader()),
                        ) : Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: VillaCard(controller.villas),
                      ))
                    ],
                  ),
                )
              ] 
            )
          ),
        ),
      ),
    );
  }
}

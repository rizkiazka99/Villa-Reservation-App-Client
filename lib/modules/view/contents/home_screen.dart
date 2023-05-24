import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/modules/controller/contents/locations/location_screen_controller.dart';
import 'package:reservilla/modules/controller/contents/home_screen_controller.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/villa_card.dart';
import 'package:reservilla/widgets/city_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationScreenController locationController =
      Get.find<LocationScreenController>();
  HomeScreenController controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Obx(() {
                if (controller.villasLoading) {
                  return LoadingState(
                    height: MediaQuery.of(context).size.height / 1.7,
                  );
                } else {
                  return Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: edge,
                        ),
                        // NOTE: TITLE/HEADER
                        Padding(
                          padding: EdgeInsets.only(left: edge),
                          child: Text(
                            'Explore Now',
                            style: blackTextStyle.copyWith(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: edge),
                          child: Text(
                            'Mencari Villa yang cozy',
                            style: greyTextStyle.copyWith(
                              fontSize: 16,
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
                            'Popular Cities',
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
                          child: Obx(
                            () {
                              if (locationController.locationsLoading) {
                                return LoadingState(
                                  height:
                                      MediaQuery.of(context).size.height / 1.7,
                                );
                              } else {
                                return CityCard(locationController.locations);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // NOTE: RECOMMENDED SPACE
                        Padding(
                          padding: EdgeInsets.only(left: edge),
                          child: Text(
                            'Recommended Villa',
                            style: regularTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: edge),
                          child: Column(
                            children: [
                              VillaCard(controller.villas),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // NOTE: TIPS & GUIDANCE
                        // Padding(
                        //   padding: EdgeInsets.only(left: edge),
                        //   child: Text(
                        //     'Tips & Guidance',
                        //     style: regularTextStyle.copyWith(
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: edge,
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       TipsCard(
                        //         Tips(
                        //           id: 1,
                        //           title: 'City Guidelines',
                        //           imageUrl: 'assets/tips1.png',
                        //           updatedAt: '20 Apr',
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 20,
                        //       ),
                        //       TipsCard(
                        //         Tips(
                        //           id: 2,
                        //           title: 'Jakarta Fairship',
                        //           imageUrl: 'assets/tips2.png',
                        //           updatedAt: '11 Dec',
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 100 + edge,
                        // ),
                      ],
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

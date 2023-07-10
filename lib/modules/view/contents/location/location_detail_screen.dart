import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/contents/locations/location_detail_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/custom_form.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/villa_card.dart';

class LocationDetailScreen extends StatefulWidget {
  const LocationDetailScreen({super.key});

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    LocationDetailScreenController controller = Get.find<LocationDetailScreenController>();
    
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: Text(controller.locationName),
        actions: [
          Obx(() => IconButton(
            splashColor: contextOrange,
            onPressed:  () {
              controller.showSearchBar = !controller.showSearchBar;
            },
            icon: Icon(
              controller.showSearchBar == false ? Icons.search_rounded :
                  Icons.search_off_rounded,
              color: contextOrange,
              size: 25,
            ),
          ))
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              if (controller.locationDetailLoading) {
                return LoadingState(
                  height: MediaQuery.of(context).size.height
                );
              } else {
                if (!controller.isFetched && controller.locationDetailData == null) {
                  return const SizedBox.shrink();
                } else if (controller.isFetched && controller.locationDetailData!.data.isEmpty) {
                  return EmptyState(
                    height: MediaQuery.of(context).size.height, 
                    imageAsset: 'assets/images/no_villa_available.webp', 
                    message: 'Tidak ada villa di lokasi ini'
                  );
                } else {
                  return Column(
                    children: [
                      Obx(() => !controller.showSearchBar ? const SizedBox.shrink() : 
                          CustomForm(
                            formKey: controller.searchFormKey, 
                            autovalidateMode: controller.autoValidateSearch, 
                            controller: controller.searchController, 
                            hintText: 'Cari Villa...',
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.searchController.clear();
                              },
                              child: const Icon(
                                Icons.clear,
                                color: contextOrange,
                              ),
                            ),
                            validator: (value) {

                            },
                            onChanged: (query) {
                              controller.searchVilla(query);
                            },
                          )
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(() {
                            if (controller.searchController.text.isEmpty) {
                              return LocationVillaCard(controller.locationDetailData!.data);
                            } else {
                              if (controller.searchResult.isEmpty) {
                                return EmptyState(
                                  height: MediaQuery.of(context).size.height / 1.7,
                                  imageAsset: 'assets/images/no_villa_available.webp',
                                  message: 'Villa dengan nama "${controller.searchController.text}" tidak ditemukan',
                                );
                              } else {
                                return LocationVillaCard(controller.searchResult);
                              }
                            }
                          }),
                        ),
                      ),
                    ],
                  );
                }
              }
            }),
          ),
        ),
      ),
    );
  }
}
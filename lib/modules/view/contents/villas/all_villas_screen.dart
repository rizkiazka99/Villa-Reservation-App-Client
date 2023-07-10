import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/contents/villas/all_villas_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/custom_form.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/villa_card.dart';

class AllVillasScreen extends StatefulWidget {
  const AllVillasScreen({super.key});

  @override
  State<AllVillasScreen> createState() => _AllVillasScreenState();
}

class _AllVillasScreenState extends State<AllVillasScreen> {
  @override
  Widget build(BuildContext context) {
    AllVillasScreenController controller = Get.find<AllVillasScreenController>();
    
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: const Text('Villa'),
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
              if (controller.villasLoading) {
                return LoadingState(
                  height: MediaQuery.of(context).size.height
                );
              } else {
                if (!controller.isFetched && controller.villasData == null) {
                  return const SizedBox.shrink();
                } else if (controller.isFetched && controller.villasData!.data.isEmpty) {
                  return EmptyState(
                    height: MediaQuery.of(context).size.height, 
                    imageAsset: 'assets/images/no_villa_available.webp', 
                    message: 'Villa tidak ditemukan'
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
                            onChanged: (query) async {
                              await controller.searchVilla(query);
                            },
                          )
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(() {
                            if (controller.searchController.text.isEmpty) {
                              return VillaCard(controller.villasData!.data);
                            } else {
                              if (controller.searchLoading) {
                                return LoadingState(
                                  height: MediaQuery.of(context).size.height / 1.7
                                );
                              } else {
                                if (controller.searchResult!.data.isEmpty) {
                                  return EmptyState(
                                    height: MediaQuery.of(context).size.height / 1.7,
                                    imageAsset: 'assets/images/no_villa_available.webp',
                                    message: 'Villa dengan nama "${controller.searchController.text}" tidak ditemukan',
                                  );
                              } else {
                                // API Search
                                return SearchedVillaCard(controller.searchResult!.data);

                                /*// Local Search
                                return VillaCard(controller.searchResult);
                                */
                              }
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
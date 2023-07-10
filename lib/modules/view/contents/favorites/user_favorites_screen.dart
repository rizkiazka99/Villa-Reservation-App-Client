import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/contents/favorites/user_favorites_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/custom_form.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/favorite_card.dart';
import 'package:reservilla/widgets/loading_state.dart';

class UserFavoritesScreen extends StatefulWidget {
  const UserFavoritesScreen({super.key});

  @override
  State<UserFavoritesScreen> createState() => _UserFavoritesScreenState();
}

class _UserFavoritesScreenState extends State<UserFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    UserFavoritesScreenController controller = Get.find<UserFavoritesScreenController>();
    
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: const Text('Favorit Saya'),
        actions: [
          Obx(() => controller.favoritesData == null ? const SizedBox.shrink() :
           controller.favoritesData!.data.isNotEmpty ? IconButton(
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
          ) : const SizedBox.shrink())
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              if (controller.favoritesLoading) {
                return Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 8),
                  child: LoadingState(
                    height: MediaQuery.of(context).size.height
                  ),
                );
              } else {
                if (!controller.isFetched && controller.favoritesData == null) {
                  return const SizedBox.shrink();
                } else if (controller.isFetched && controller.favoritesData!.data.isEmpty) {
                  return Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 6),
                    child: EmptyState(
                      height: MediaQuery.of(context).size.height, 
                      imageAsset: 'assets/images/empty_favorite.webp', 
                      message: 'Anda belum memiliki villa favorit'
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Obx(() => !controller.showSearchBar ? const SizedBox.shrink() : 
                          CustomForm(
                            formKey: controller.searchFormKey, 
                            autovalidateMode: controller.autoValidateSearch, 
                            controller: controller.searchController, 
                            hintText: 'Cari Villa Favorit',
                            onChanged: (query) {
                              controller.searchFavorite(query);
                            },
                            validator: (value) {

                            }
                          )
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(() {
                            if (controller.searchController.text.isEmpty) {
                              return FavoriteCard(
                                favorites: controller.favoritesData!,
                              );
                            } else {
                              if (controller.searchResult.isEmpty) {
                                return EmptyState(
                                  height: MediaQuery.of(context).size.height / 1.7, 
                                  imageAsset: 'assets/images/empty_favorite.webp', 
                                  message: 'Villa dengan nama "${controller.searchController.text}" tidak ditemukan'
                                );
                              } else {
                                return SearchedFavoriteCard(
                                  favorites: controller.searchResult
                                );
                              }
                            }
                          }),
                        )
                      )
                    ],
                  );
                }
              }
            })
            /*Column(
              children: [
                Obx(() => !controller.showSearchBar ? const SizedBox.shrink() : 
                      CustomForm(
                        formKey: controller.searchFormKey, 
                        autovalidateMode: controller.autoValidateSearch, 
                        controller: controller.searchController, 
                        hintText: 'Cari Villa Favorit', 
                        validator: (value) {

                        }
                      )
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StreamBuilder<UserFavoritesResponse?>(
                      stream: controller.getRealtimeUserFavorites(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return LoadingState(
                              height: MediaQuery.of(context).size.height / 1.4
                            );
                          default: 
                            if (snapshot.hasError) {
                              return ErrorState(
                                iconSize: 100,
                                color: contextRed,
                                textStyle: h4(),
                              );
                            } else if (snapshot.data!.data.isEmpty) {
                              return EmptyState(
                                height: MediaQuery.of(context).size.height / 1.4, 
                                imageAsset: 'assets/images/empty_favorite.webp', 
                                message: 'Anda belum memiliki villa favorit'
                              );
                            } else {
                              return FavoriteCard(
                                favorites: snapshot.data!
                              );
                            }
                        }
                      }
                    )
                  )
                )
              ],
            )*/
          ),
        ),
      ),
    );
  }
}
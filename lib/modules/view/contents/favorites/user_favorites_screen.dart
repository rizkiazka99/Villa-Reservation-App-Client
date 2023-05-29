import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';
import 'package:reservilla/modules/controller/contents/favorites/user_favorites_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/custom_form.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/error_state.dart';
import 'package:reservilla/widgets/favorite_card.dart';
import 'package:reservilla/widgets/loading_state.dart';

class UserFavoritesScreen extends StatefulWidget {
  const UserFavoritesScreen({super.key});

  @override
  State<UserFavoritesScreen> createState() => _UserFavoritesScreenState();
}

class _UserFavoritesScreenState extends State<UserFavoritesScreen> {
  UserFavoritesScreenController controller = Get.find<UserFavoritesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: const Text('Favorit Saya'),
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: /*Obx(() {
              if (controller.favoritesLoading) {
                return LoadingState(
                  height: MediaQuery.of(context).size.height
                );
              } else {
                if (!controller.isFetched && controller.favoritesData == null) {
                  return const SizedBox.shrink();
                } else if (controller.isFetched && controller.favoritesData!.data.isEmpty) {
                  return EmptyState(
                    height: MediaQuery.of(context).size.height, 
                    imageAsset: 'assets/images/empty_favorite.webp', 
                    message: 'Anda belum memiliki villa favorit'
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
                              /*return FavoriteCard(
                                favorites: controller.favoritesData!,
                              );*/
                              return StreamBuilder<UserFavoritesResponse?>(
                                stream: controller.getRealtimeUserFavorites(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return LoadingState(
                                        height: MediaQuery.of(context).size.height
                                      );
                                      default: 
                                        if (snapshot.hasError) {
                                          return ErrorState(
                                            iconSize: 100,
                                            color: contextRed,
                                            textStyle: h4(),
                                          );
                                        } else if (!snapshot.hasData) {
                                          return EmptyState(
                                            height: MediaQuery.of(context).size.height, 
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
                              );
                            } else {
                              return Text('');
                            }
                          }),
                        )
                      )
                    ],
                  );
                }
              }
            })*/
            Column(
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
            )
          ),
        ),
      ),
    );
  }
}
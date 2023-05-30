import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/data/models/miscellaneous/user_response.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/helpers/currency_formatter.dart';
import 'package:reservilla/modules/controller/contents/villas/villa_detail_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/bottom_navbar_button.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';
import 'package:reservilla/widgets/custom_icon_button.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/facility_item.dart';
import 'package:reservilla/widgets/loading_state.dart';

class VillaDetailScreen extends StatefulWidget {
  const VillaDetailScreen({super.key});

  @override
  State<VillaDetailScreen> createState() => _VillaDetailScreenState();
}

class _VillaDetailScreenState extends State<VillaDetailScreen> {
  VillaDetailController controller = Get.find<VillaDetailController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Obx(() {
          if (controller.villaDetailLoading && controller.favoriteLoading) {
            return LoadingState(
              height: MediaQuery.of(context).size.height,
            );
          } else {
            if (controller.villaDetailData == null) {
              return const SizedBox.shrink();
            } else {
              return Stack(
                children: [
                  controller.villaDetailData!.data.villaGaleries.isNotEmpty
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 350,
                          imageUrl: baseUrlImg +
                              controller.villaDetailData!.data.villaGaleries[0]
                                  .imageName!,
                          fadeInDuration: const Duration(milliseconds: 300),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) =>
                              const SpinKitThreeBounce(
                                  color: contextOrange, size: 18),
                        )
                      : Image.asset('assets/images/placeholder.webp'),
                  ListView(
                    children: [
                      const SizedBox(height: 328),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            // NOTE: TITLE
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: edge,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.villaDetailData!.data.name,
                                        style: blackTextStyle.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text.rich(
                                        TextSpan(
                                          text: CurrencyFormatter.convertToIdr(
                                              controller
                                                  .villaDetailData!.data.price,
                                              2),
                                          style: oceanTextStyle.copyWith(
                                              fontSize: 16,
                                              color: contextOrange),
                                          children: [
                                            TextSpan(
                                              text: ' / hari',
                                              style: greyTextStyle.copyWith(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Obx(() => controller.villaDetailData!
                                                .data.averageRating !=
                                            null
                                        ? RatingBarIndicator(
                                            rating: controller.villaDetailData!
                                                .data.averageRating!,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemBuilder: (context, index) {
                                              return const Icon(
                                                  Icons.star_rounded,
                                                  color: contextOrange);
                                            })
                                        : Column(
                                            children: [
                                              const Icon(Icons.star_rounded,
                                                  color: contextOrange),
                                              Text(
                                                '0.0',
                                                style: h4(color: contextGrey),
                                              ),
                                            ],
                                          )),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // NOTE: MAIN FACILITIES
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Fasilitas Utama',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: edge,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FacilityItem(
                                    name: 'Pool',
                                    imageUrl:
                                        'assets/icons/icon_swimming_pool.webp',
                                    total: controller
                                            .villaDetailData!.data.swimmingPool
                                        ? "Available"
                                        : "Unavailable",
                                  ),
                                  FacilityItem(
                                    name: 'Bedroom',
                                    imageUrl: 'assets/icons/icon_bedroom.png',
                                    total:
                                        '${controller.villaDetailData!.data.bedroom}',
                                  ),
                                  FacilityItem(
                                    name: 'Bathroom',
                                    imageUrl: 'assets/icons/icon_bathroom.png',
                                    total:
                                        '${controller.villaDetailData!.data.bathroom}',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            controller.villaDetailData!.data.averageRating !=
                                    null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: edge, right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Ulasan',
                                              style: regularTextStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      villaReviewsScreenRoute,
                                                      arguments: {
                                                        'id': controller
                                                            .villaDetailData!
                                                            .data
                                                            .id,
                                                        'name': controller
                                                            .villaDetailData!
                                                            .data
                                                            .name
                                                      });
                                                },
                                                child: Text('Lihat Semua',
                                                    style: bodySm(
                                                        color: contextOrange)))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            margin: EdgeInsets.only(left: edge),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                        'assets/icons/icon_star.png'),
                                                    const SizedBox(width: 8),
                                                    Text.rich(TextSpan(
                                                        text: controller
                                                            .villaDetailData!
                                                            .data
                                                            .averageRating
                                                            .toString(),
                                                        style: oceanTextStyle
                                                            .copyWith(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    contextOrange),
                                                        children: [
                                                          TextSpan(
                                                              text: ' / 5',
                                                              style: greyTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14))
                                                        ]))
                                                  ],
                                                ),
                                                Text(
                                                  '(${controller.villaDetailData!.data.villaReviews.length} ulasan)',
                                                  style: bodySm(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            height: 60,
                                            width: 1,
                                            child: Container(
                                              color: contextOrange,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                margin: EdgeInsets.only(
                                                    right: edge),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        controller
                                                                    .villaDetailData!
                                                                    .data
                                                                    .villaReviews[
                                                                        0]
                                                                    .user
                                                                    .profilePicture ==
                                                                null
                                                            ? const Icon(
                                                                Icons
                                                                    .account_circle_rounded,
                                                                color:
                                                                    backgroundColorPrimary,
                                                                size: 40)
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  height: 40,
                                                                  width: 40,
                                                                  imageUrl: baseUrlImg +
                                                                      controller
                                                                          .villaDetailData!
                                                                          .data
                                                                          .villaReviews[
                                                                              0]
                                                                          .user
                                                                          .profilePicture,
                                                                  fadeInDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error,
                                                                          size:
                                                                              40),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const SpinKitThreeBounce(
                                                                          color:
                                                                              contextOrange,
                                                                          size:
                                                                              18),
                                                                ),
                                                              ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                controller
                                                                    .villaDetailData!
                                                                    .data
                                                                    .villaReviews[
                                                                        0]
                                                                    .user
                                                                    .name,
                                                                style:
                                                                    bodyMd()),
                                                            RatingBarIndicator(
                                                                rating: controller
                                                                    .villaDetailData!
                                                                    .data
                                                                    .villaReviews[
                                                                        0]
                                                                    .rating,
                                                                itemCount: 5,
                                                                itemSize: 15,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return const Icon(
                                                                      Icons
                                                                          .star_rounded,
                                                                      color:
                                                                          contextOrange);
                                                                })
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                      controller
                                                          .villaDetailData!
                                                          .data
                                                          .villaReviews[0]
                                                          .comment,
                                                      style: bodyMd(
                                                          color: Colors.black),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Deskripsi',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: edge),
                              child: Text(
                                controller.villaDetailData!.data.description,
                                style: greyTextStyle,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // NOTE: PHOTO
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Foto',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            controller.villaDetailData!.data.villaGaleries
                                    .isNotEmpty
                                ? SizedBox(
                                    height: 100,
                                    child: ListView(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(right: 16),
                                      children: controller
                                          .villaDetailData!.data.villaGaleries
                                          .map((item) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(left: 24),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.network(
                                              "$baseUrlImg${item.imageName}",
                                              width: 150,
                                              height: 180,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : const EmptyState(
                                    height: 135,
                                    imageAsset: 'assets/images/empty.png',
                                    imageHeight: 100,
                                    imageWidth: 100,
                                    message: 'Foto tidak tersedia'),
                            const SizedBox(height: 30),
                            // NOTE: LOCATION
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Kota',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: edge),
                              child: Text(
                                controller.villaDetailData!.data.location.name,
                                style: greyTextStyle,
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: edge,
                      vertical: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/icons/btn_back.png',
                            width: 40,
                          ),
                        ),
                        Obx(() => controller.isFavorite
                            ? InkWell(
                                onTap: () async {
                                  Get.dialog(ConfirmationDialog(
                                      title: 'Tunggu Sebentar!',
                                      content:
                                          'Apakah Anda yakin ingin menghilangkan ${controller.villaDetailData!.data.name} dari favorit?',
                                      onConfirmation: () {
                                        controller.initiateRemoveFromFavorite(
                                            controller.favoriteId,
                                            controller
                                                .villaDetailData!.data.name);
                                        Get.back();
                                      }));
                                },
                                child: Image.asset(
                                  'assets/icons/btn_wishlist_active.png',
                                  width: 40,
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  controller.initiateAddToFavorite(
                                      controller.villaDetailData!.data.id,
                                      controller.villaDetailData!.data.name);
                                },
                                child: Image.asset(
                                  'assets/icons/btn_wishlist.png',
                                  width: 40,
                                ),
                              ))
                      ],
                    ),
                  ),
                ],
              );
            }
          }
        }),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => BottomNavBarButton(
                onPressed: ()  {
                  if (!controller.villaDetailLoading) {
                    Get.toNamed(
                      bookVillaScreenRoute,
                      arguments: {
                        'villa_id': controller.villaDetailData!.data.id,
                        'name': controller.villaDetailData!.data.name,
                        'price': controller.villaDetailData!.data.price
                      }
                    );
                  }
                },
                width: MediaQuery.of(context).size.width / 1.6,
                buttonColor: controller.villaDetailLoading ? contextGrey : contextOrange,
                buttonText: 'Book Villa',
              )),
              Row(
                children: [
                  Obx(() => CustomIconButton(
                    onTap: () {
                      if (!controller.villaDetailLoading) {
                        String mapsUrl = controller.villaDetailData!.data.mapUrl;
                        controller.launchMaps(mapsUrl);
                      }
                    },
                    radius: 100, 
                    icon: Icons.location_on,
                    iconColor: controller.villaDetailLoading ? contextGrey : contextOrange,
                    borderColor: controller.villaDetailLoading ? contextGrey : contextOrange,
                  )),
                  const SizedBox(width: 8),
                  Obx(() => CustomIconButton(
                    onTap: () {
                      if (!controller.villaDetailLoading) {
                        String phoneNumber = controller.villaDetailData!.data.phone;
                        controller.launchDialer(phoneNumber);
                      }
                    },
                    radius: 100,
                    icon: Icons.phone,
                    iconColor: controller.villaDetailLoading ? contextGrey : contextOrange,
                    borderColor: controller.villaDetailLoading ? contextGrey : contextOrange,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

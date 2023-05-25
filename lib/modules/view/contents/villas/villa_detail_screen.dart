import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/helpers/currency_formatter.dart';
import 'package:reservilla/modules/controller/contents/villas/villa_detail_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/bottom_navbar_button.dart';
import 'package:reservilla/widgets/custom_icon_button.dart';
import 'package:reservilla/widgets/facility_item.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/rating_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VillaDetailScreen extends StatefulWidget {
  const VillaDetailScreen({super.key});

  @override
  State<VillaDetailScreen> createState() => _VillaDetailScreenState();
}

class _VillaDetailScreenState extends State<VillaDetailScreen> {
  VillaDetailController controller = Get.find<VillaDetailController>();

  @override
  Widget build(BuildContext context) {
    Future<void> handleBook(Data space) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Apakah kamu ingin menghubungi pemilik villa?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Nanti',
                  style: greyTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Hubungi'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // launchUrl('tel:${space.phone}');
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          if (controller.villaDetailLoading) {
            return LoadingState(
              height: MediaQuery.of(context).size.height / 2,
            );
          } else {
            return Stack(
              children: [
                controller.villaDetailData!.data.villaGaleries.isNotEmpty ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 350,
                  imageUrl: baseUrlImg + controller.villaDetailData!.data.villaGaleries[0].imageName!,
                  fadeInDuration: const Duration(milliseconds: 300),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => const SpinKitThreeBounce(
                    color: contextOrange,
                    size: 18
                  ),
                ) : Image.asset(
                  'assets/images/placeholder.webp'
                ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: contextOrange
                                        ),
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
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Obx(() => controller.villaDetailData!.data.averageRating != null ? RatingBarIndicator(
                                    rating: controller.villaDetailData!.data.averageRating!,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star_rounded,
                                        color: contextOrange
                                      );
                                    }
                                  ) : Column(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: contextOrange
                                      ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FacilityItem(
                                  name: 'Pool',
                                  imageUrl: 'assets/icons/icon_kitchen.png',
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
                                  imageUrl: 'assets/icons/icon_cupboard.png',
                                  total:
                                      '${controller.villaDetailData!.data.bathroom}',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
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
                          SizedBox(
                            height: 88,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(right: 16),
                              children: controller
                                  .villaDetailData!.data.villaGaleries
                                  .map((item) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 24),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      "http://10.0.2.2:3000/${item.imageName}",
                                      width: 150,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
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
                              controller
                                  .villaDetailData!.data.location.name,
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
                      InkWell(
                        child: Image.asset(
                          'assets/icons/btn_wishlist.png',
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomNavBarButton(
              onPressed: () async {
                Get.toNamed(
                  bookVillaScreenRoute,
                  arguments: {
                    'villa_id': controller.villaDetailData!.data.id
                  }
                );
              },
              width: MediaQuery.of(context).size.width / 1.6,
              buttonColor: contextOrange,
              buttonText: 'Book Villa',
            ),
            Row(
              children: [
                CustomIconButton(
                  onTap: () {
                    String mapsUrl = controller.villaDetailData!.data.mapUrl;
                    controller.launchMaps(mapsUrl);
                  },
                  radius: 100, 
                  icon: Icons.location_on
                ),
              ],
            ),
            const SizedBox(width: 8),
            CustomIconButton(
              onTap: () {
                String phoneNumber = controller.villaDetailData!.data.phone;
                controller.launchDialer(phoneNumber);
              },
              radius: 100,
              icon: Icons.phone,
            ),
          ],
        ),
      ),
    );
  }
}
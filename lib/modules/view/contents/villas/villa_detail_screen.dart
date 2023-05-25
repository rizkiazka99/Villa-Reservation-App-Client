import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/helpers/currency_formatter.dart';
import 'package:reservilla/modules/controller/contents/villas/villa_detail_controller.dart';
import 'package:reservilla/widgets/facility_item.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/rating_item.dart';

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
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' / month',
                                            style: greyTextStyle.copyWith(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [1, 2, 3, 4, 5].map((index) {
                                    return Container(
                                      margin: const EdgeInsets.only(left: 2),
                                      child: RatingItem(
                                        index: index,
                                        rating: 5,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          // NOTE: MAIN FACILITIES
                          Padding(
                            padding: EdgeInsets.only(left: edge),
                            child: Text(
                              'Main Facilities',
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
                              'Description',
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
                            ),
                          ),
                          const SizedBox(height: 30),
                          // NOTE: PHOTO
                          Padding(
                            padding: EdgeInsets.only(left: edge),
                            child: Text(
                              'Photos',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 88,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: controller
                                  .villaDetailData!.data.villaGaleries
                                  .map((item) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 24),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      "http://10.0.2.2:3000/${item.imageName}",
                                      width: 110,
                                      height: 88,
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
                              'Location',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: edge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller
                                      .villaDetailData!.data.location.name,
                                  style: greyTextStyle,
                                ),
                                InkWell(
                                  onTap: () {
                                    String mapUrl =
                                        controller.villaDetailData!.data.mapUrl;
                                    controller.launchMaps(mapUrl);
                                  },
                                  child: Image.asset(
                                    'assets/icons/btn_map.png',
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: edge,
                            ),
                            height: 50,
                            width:
                                MediaQuery.of(context).size.width - (2 * edge),
                            child: ElevatedButton(
                              onPressed: () {
                                handleBook(controller.villaDetailData!.data);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: oceanColor,
                              ),
                              child: Text(
                                'Book Now',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
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
    );
  }
}

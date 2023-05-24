import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
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
                Image.network(
                  "http://10.0.2.2:3000/${controller.villaDetailData!.data.villaGaleries[0].imageName}",
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  fit: BoxFit.cover,
                ),
                ListView(
                  children: [
                    SizedBox(
                      height: 328,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
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
                                    SizedBox(
                                      height: 2,
                                    ),
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
                                      margin: EdgeInsets.only(
                                        left: 2,
                                      ),
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
                          SizedBox(
                            height: 30,
                          ),
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
                          SizedBox(
                            height: 12,
                          ),
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
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: edge),
                            child: Text(
                              'Description',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: edge),
                            child: Container(
                              child: Text(
                                controller.villaDetailData!.data.description,
                                style: greyTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
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
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 88,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: controller
                                  .villaDetailData!.data.villaGaleries
                                  .map((item) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: 24,
                                  ),
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
                          SizedBox(
                            height: 30,
                          ),
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
                          SizedBox(
                            height: 6,
                          ),
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
                          SizedBox(
                            height: 40,
                          ),
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
                          SizedBox(
                            height: 40,
                          ),
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
                      // Image.asset(
                      //   'assets/btn_wishlist.png',
                      //   width: 40,
                      // ),
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

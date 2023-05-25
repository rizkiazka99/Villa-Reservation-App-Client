import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/models/contents/villas/villas_response.dart' as villas;
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/helpers/currency_formatter.dart';
import 'package:reservilla/router/route_variables.dart';
import '../data/models/contents/locations/location_detail_response.dart';

class VillaCard extends StatefulWidget {
  final List<villas.Datum> villa;

  const VillaCard(this.villa, {super.key});

  @override
  State<VillaCard> createState() => _VillaCardState();
}

class _VillaCardState extends State<VillaCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.villa.length,
        (index) => InkWell(
          onTap: () {
            Get.toNamed(
              villaDetailScreenRoute,
              arguments: {
                'id': widget.villa[index].id.toString(),
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 7,
                  offset: const Offset(0, 3)
                )
              ]
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    width: 130,
                    height: 110,
                    child: Stack(
                      children: [
                        widget.villa[index].villaGalleries.isNotEmpty ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 130,
                          height: 110,
                          imageUrl: baseUrlImg + widget.villa[index].villaGalleries[0].imageName,
                          fadeInDuration: const Duration(milliseconds: 300),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          placeholder: (context, url) => const SpinKitThreeBounce(
                            color: contextOrange,
                            size: 18
                          ),
                        ) : Image.asset(
                          'assets/images/placeholder.webp'
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/icon_star.png',
                                  width: 22,
                                  height: 22,
                                ),
                                Text(
                                  '${widget.villa[index].averageRating ?? "0.0"}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.villa[index].name,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text.rich(
                          TextSpan(
                            text: CurrencyFormatter.convertToIdr(
                                widget.villa[index].price, 2),
                            style: oceanTextStyle.copyWith(
                              fontSize: 16,
                              color: contextOrange
                            ),
                            children: [
                              TextSpan(
                                text: ' / hari',
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: contextRed,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.villa[index].location.name,
                              style: blackTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationVillaCard extends StatefulWidget {
  final List<Datum> villa;

  const LocationVillaCard(this.villa, {super.key});

  @override
  State<LocationVillaCard> createState() => _LocationVillaCardState();
}

class _LocationVillaCardState extends State<LocationVillaCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.villa.length,
        (index) => InkWell(
          onTap: () {
            Get.toNamed(
              villaDetailScreenRoute,
              arguments: {
                'id': widget.villa[index].id.toString(),
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 7,
                  offset: const Offset(0, 3)
                )
              ]
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    width: 130,
                    height: 110,
                    child: Stack(
                      children: [
                        widget.villa[index].villaGalleries.isNotEmpty ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 130,
                          height: 110,
                          imageUrl: baseUrlImg + widget.villa[index].villaGalleries[0].imageName,
                          fadeInDuration: const Duration(milliseconds: 300),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          placeholder: (context, url) => const SpinKitThreeBounce(
                            color: contextOrange,
                            size: 18
                          ),
                        ) : Image.asset(
                          'assets/images/placeholder.webp'
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/icon_star.png',
                                  width: 22,
                                  height: 22,
                                ),
                                Text(
                                  '${widget.villa[index].averageRating ?? "0.0"}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.villa[index].name,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text.rich(
                          TextSpan(
                            text: CurrencyFormatter.convertToIdr(
                                widget.villa[index].price, 2),
                            style: oceanTextStyle.copyWith(
                              fontSize: 16,
                              color: contextOrange
                            ),
                            children: [
                              TextSpan(
                                text: ' / hari',
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: contextRed,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.villa[index].location,
                              style: blackTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

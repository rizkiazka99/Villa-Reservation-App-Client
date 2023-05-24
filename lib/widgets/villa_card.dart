import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/models/contents/villas/villas_response.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/router/route_variables.dart';

class VillaCard extends StatelessWidget {
  final List<Datum> villa;

  const VillaCard(this.villa, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        villa.length,
        (index) => InkWell(
          onTap: () {
            Get.toNamed(
              villaDetailScreenRoute,
              arguments: {
                'id': villa[index].id.toString(),
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 130,
                    height: 110,
                    child: Stack(
                      children: [
                        Image.network(
                          "http://10.0.2.2:3000/${villa[index].villaGalleries[0].imageName}",
                          width: 130,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              color: whitegreyColor,
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
                                  '${villa[index].averageRating ?? "0.0"}',
                                  style: whiteTextStyle.copyWith(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      villa[index].name,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text.rich(
                      TextSpan(
                        text: '\Rp${villa[index].price}',
                        style: oceanTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: ' / day',
                            style: greyTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      villa[index].location.name,
                      style: greyTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

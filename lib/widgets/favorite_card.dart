import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/helpers/currency_formatter.dart';
import 'package:reservilla/modules/controller/contents/favorites/user_favorites_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';

class FavoriteCard extends StatefulWidget {
  final UserFavoritesResponse favorites;

  const FavoriteCard({
    super.key, 
    required this.favorites
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  UserFavoritesScreenController controller = Get.find<UserFavoritesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.favorites.data.length,
        (index) => InkWell(
          onTap: () {
            Get.toNamed(
              villaDetailScreenRoute,
              arguments: {
                'id': widget.favorites.data[index].villaId.toString()
              }
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: contextGrey.withOpacity(0.1),
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: const Offset(0, 3)
                )
              ]
            ),
            child: Column(
              children: [
                widget.favorites.data[index].villa.villaGaleries.isNotEmpty ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: baseUrlImg + widget.favorites.data[index].villa.villaGaleries[0].imageName,
                  fadeInDuration: const Duration(milliseconds: 300),
                  errorWidget: (context, url, error) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.error)
                  ),
                  placeholder: (context, url) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: contextGrey.withOpacity(0.1),
                          blurRadius: 7,
                          spreadRadius: 5,
                          offset: const Offset(0, 3)
                        )
                      ]
                    ),
                    child: const SpinKitThreeBounce(
                      color: contextOrange,
                      size: 18
                    ),
                  ),
                ) : Image.asset(
                  'assets/images/placeholder.webp'
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: contextGrey.withOpacity(0.1),
                        blurRadius: 7,
                        spreadRadius: 5,
                        offset: const Offset(0, 3)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              widget.favorites.data[index].villa.name,
                              style: h4(),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.dialog(
                                ConfirmationDialog(
                                  title: 'Tunggu Sebentar!', 
                                  content: 'Apakah Anda yakin ingin menghilangkan ${widget.favorites.data[index].villa.name} dari favorit?', 
                                  onConfirmation: () {
                                    controller.initiateRemoveFromFavorite(
                                      widget.favorites.data[index].id,
                                      widget.favorites.data[index].villa.name
                                    );
                                    Get.back();
                                  }
                                )
                              );
                            },
                            child: const Icon(
                              Icons.favorite_rounded,
                              color: contextOrange,
                            ) 
                          )
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          text: CurrencyFormatter.convertToIdr(
                            widget.favorites.data[index].villa.price, 2
                          ),
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
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: contextRed,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.favorites.data[index].villa.location.name,
                            style: blackTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}

class SearchedFavoriteCard extends StatefulWidget {
  final List<Datum> favorites;

  const SearchedFavoriteCard({
    super.key, 
    required this.favorites
  });

  @override
  State<SearchedFavoriteCard> createState() => _SearchedFavoriteCardState();
}

class _SearchedFavoriteCardState extends State<SearchedFavoriteCard> {
  UserFavoritesScreenController controller = Get.find<UserFavoritesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.favorites.length,
        (index) => InkWell(
          onTap: () {
            Get.toNamed(
              villaDetailScreenRoute,
              arguments: {
                'id': widget.favorites[index].villaId.toString()
              }
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: contextGrey.withOpacity(0.1),
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: const Offset(0, 3)
                )
              ]
            ),
            child: Column(
              children: [
                widget.favorites[index].villa.villaGaleries.isNotEmpty ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: baseUrlImg + widget.favorites[index].villa.villaGaleries[0].imageName,
                  fadeInDuration: const Duration(milliseconds: 300),
                  errorWidget: (context, url, error) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.error)
                  ),
                  placeholder: (context, url) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: contextGrey.withOpacity(0.1),
                          blurRadius: 7,
                          spreadRadius: 5,
                          offset: const Offset(0, 3)
                        )
                      ]
                    ),
                    child: const SpinKitThreeBounce(
                      color: contextOrange,
                      size: 18
                    ),
                  ),
                ) : Image.asset(
                  'assets/images/placeholder.webp'
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: contextGrey.withOpacity(0.1),
                        blurRadius: 7,
                        spreadRadius: 5,
                        offset: const Offset(0, 3)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              widget.favorites[index].villa.name,
                              style: h4(),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.dialog(
                                ConfirmationDialog(
                                  title: 'Tunggu Sebentar!', 
                                  content: 'Apakah Anda yakin ingin menghilangkan ${widget.favorites[index].villa.name} dari favorit?', 
                                  onConfirmation: () {
                                    controller.initiateRemoveFromFavorite(
                                      widget.favorites[index].id,
                                      widget.favorites[index].villa.name
                                    );
                                    Get.back();
                                  }
                                )
                              );
                            },
                            child: const Icon(
                              Icons.favorite_rounded,
                              color: contextOrange,
                            ) 
                          )
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          text: CurrencyFormatter.convertToIdr(
                            widget.favorites[index].villa.price, 2
                          ),
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
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: contextRed,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.favorites[index].villa.location.name,
                            style: blackTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
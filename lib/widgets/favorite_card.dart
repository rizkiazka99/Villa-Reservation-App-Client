import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/router/route_variables.dart';

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
                Column(
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
                              IconButton(
                                onPressed: () {
        
                                },
                                icon: const Icon(
                                  Icons.favorite_rounded,
                                  color: contextOrange,
                                ) 
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
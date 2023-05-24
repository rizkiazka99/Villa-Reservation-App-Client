import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/helpers/common_variables.dart';
import '../data/models/contents/reviews/user_reviews_response.dart';

class ReviewCard extends StatefulWidget {
  final UserReviewsResponse reviews;

  const ReviewCard({
    super.key, 
    required this.reviews
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.reviews.data.length,
        (index) => Container(
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
                  widget.reviews.data[index].villa.villaGaleries.isNotEmpty ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: baseUrlImg + widget.reviews.data[index].villa.villaGaleries[0].imageName,
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
                                widget.reviews.data[index].villa.name,
                                style: h4(),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: RatingBarIndicator(
                                rating: widget.reviews.data[index].rating,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, index) {
                                  return const Icon(
                                    Icons.star_rounded,
                                    color: contextOrange
                                  );
                                }),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                          color: contextOrange,
                        ),
                        Text(
                          widget.reviews.data[index].comment.isNotEmpty ?
                              widget.reviews.data[index].comment : 'Tidak diberikan komentar',
                          style: bodyMd(),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/core/theme.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/modules/controller/contents/reviews/villa_reviews_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/default_dropdown.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/skeleton_loader.dart';

class VillaReviewsScreen extends StatefulWidget {
  const VillaReviewsScreen({super.key});

  @override
  State<VillaReviewsScreen> createState() => _VillaReviewsScreenState();
}

class _VillaReviewsScreenState extends State<VillaReviewsScreen> {
  VillaReviewsScreenController controller = Get.find<VillaReviewsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton(iconColor: Colors.white),
        title: Text('Ulasan ${controller.name}'),
        backgroundColor: contextOrange,
      ),
      backgroundColor: contextOrange,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.25),
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(() {
                    if (controller.reviewsLoading) {
                      return LoadingState(
                        height: MediaQuery.of(context).size.height / 2
                      );
                    } else {
                      if (!controller.isFetched && controller.villaReviewsData!.data!.reviews.isEmpty) {
                        return const SizedBox.shrink();
                      } else if (controller.isFetched && controller.villaReviewsData!.data!.reviews.isEmpty) {
                        return EmptyState(
                          height: MediaQuery.of(context).size.height / 2,
                          imageAsset: 'assets/images/empty_villa_review.png',
                          message: 'Review untuk ${controller.name} tidak ditemukan',
                        );
                      } else {
                        return Column(
                          children: List.generate(controller.villaReviewsData!.data!.reviews.length, (index) {
                            return Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          controller.villaReviewsData!.data!.reviews[index].user.profilePicture == null
                                              ? const Icon(
                                                Icons.account_circle_rounded,
                                                color: backgroundColorPrimary,
                                                size: 80
                                              ) : ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fitWidth,
                                                  height: 70,
                                                  width: 70,
                                                  imageUrl: baseUrlImg + controller.villaReviewsData!.data!.reviews[index].user.profilePicture,
                                                  fadeInDuration: const Duration(milliseconds: 300),
                                                  errorWidget: (context, url, error) => const Icon(
                                                    Icons.error,
                                                    size: 40
                                                  ),
                                                  placeholder: (context, url) => const SpinKitThreeBounce(
                                                    color: contextOrange,
                                                    size: 18
                                                  ),
                                                ),
                                              ),
                                          controller.villaReviewsData!.data!.reviews[index].user.profilePicture == null 
                                            ? const SizedBox(width: 5) : const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.villaReviewsData!.data!.reviews[index].user.name,
                                                style: h4(
                                                  color: textGrey,
                                                  fontWeight: FontWeight.normal
                                                )
                                              ),
                                              RatingBarIndicator(
                                                rating: controller.villaReviewsData!.data!.reviews[index].rating,
                                                itemCount: 5,
                                                itemSize: 20,
                                                itemBuilder: (context, index) {
                                                  return const Icon(
                                                    Icons.star_rounded,
                                                    color: contextOrange
                                                  );
                                                }
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                    controller.villaReviewsData!.data!.reviews[index].user.profilePicture == null 
                                        ? const SizedBox(height: 3) : const SizedBox(height: 8),
                                    controller.villaReviewsData!.data!.reviews[index].comment.isNotEmpty ? Text(
                                      controller.villaReviewsData!.data!.reviews[index].comment,
                                      style: bodyMd(color: Colors.black)
                                    ) : const SizedBox.shrink()
                                  ],
                                )),
                                const Divider(
                                  color: contextGrey,
                                  thickness: 1,
                                )
                              ],
                            );
                          }),
                        );
                      }
                    }
                  }),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4.5,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                decoration: const BoxDecoration(
                  color: contextOrange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() => !controller.reviewsLoading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon_star.png'
                          ),
                          const SizedBox(width: 8),
                          Text.rich(
                            TextSpan(
                              text: controller.villaReviewsData!.data!.averageRating.toString(),
                              style: oceanTextStyle.copyWith(
                                fontSize: 65,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                              children: [
                                TextSpan(
                                  text: ' / 5',
                                  style: blackTextStyle.copyWith(fontSize: 30)
                                )
                              ]
                            )
                          )
                        ],
                      ) : const SkeletonLoader()),
                    ),
                    Obx(() => !controller.reviewsLoading ? DefaultDropdown(
                      backgroundColor: Colors.white,
                      value: controller.selectedOrder, 
                      onChanged: (value) {
                        controller.selectedOrder = value!;
                    
                        if (controller.selectedOrder == 'Tinggi ke Rendah') {
                          controller.getVillaReviewsDesc();
                        } else {
                          controller.getVillaReviewsAsc();
                        }
                      }, 
                      items: controller.orders.map((String order) {
                        return DropdownMenuItem<String>(
                          value: order,
                          child: Text(order),
                        );
                      }).toList()
                    ) : const SizedBox.shrink())
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
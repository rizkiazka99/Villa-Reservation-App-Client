import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/reviews/user_reviews_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/review_card.dart';

class UserReviewsScreen extends StatefulWidget {
  const UserReviewsScreen({super.key});

  @override
  State<UserReviewsScreen> createState() => _UserReviewsScreenState();
}

class _UserReviewsScreenState extends State<UserReviewsScreen> {
  UserReviewsScreenController controller = Get.find<UserReviewsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: const Text('Ulasan Saya'),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              if (controller.userReviewsLoading) {
                return LoadingState(
                  height: MediaQuery.of(context).size.height
                );
              } else {
                if (!controller.isFetched && controller.userReviewsData!.data.isEmpty) {
                  return const SizedBox.shrink();
                } else if (controller.isFetched && controller.userReviewsData!.data.isEmpty) {
                  return EmptyState(
                    height: MediaQuery.of(context).size.height, 
                    imageAsset: 'assets/images/empty_review.png', 
                    message: 'Hmm... Anda belum mengulas villa sama sekali'
                  );
                } else {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ReviewCard(
                      reviews: controller.userReviewsData!,
                    ),
                  );
                }
              }
            })
          ),
        ),
      ),
    );
  }
}
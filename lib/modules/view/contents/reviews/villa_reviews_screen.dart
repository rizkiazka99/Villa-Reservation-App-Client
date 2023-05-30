import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/reviews/villa_reviews_screen_controller.dart';

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
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Villa Reviews Screen')
              ],
            ),
          ),
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/contents/reviews/add_review_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/bottom_navbar_button.dart';
import 'package:reservilla/widgets/custom_form.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  AddReviewController controller = Get.find<AddReviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: backButton(),
        title: Text(
          'Ulas ${controller.villaName}'
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: const Offset(0, 3)
                        )
                      ]
                    ),
                    child: RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: contextOrange,
                      ), 
                      onRatingUpdate: (rating) {
                        controller.rating = rating;
                      }
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomForm(
                    formKey: controller.commentFormKey, 
                    autovalidateMode: controller.autoValidateComment, 
                    controller: controller.commentController, 
                    hintText: 'Berikan kritik dan saran Anda disini...',
                    minLines: 8,
                    maxLines: 8,
                    validator: (value) {
                      
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarButton(
        onPressed: () {
          controller.initiateAddReview();
        },
        buttonColor: contextOrange,
        buttonText: 'Kirim Ulasan'
      ),
    );
  }
}
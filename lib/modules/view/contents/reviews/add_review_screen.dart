import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/modules/controller/contents/reviews/add_review_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/custom_form.dart';
import 'package:reservilla/widgets/default_button.dart';

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
            child: Column(
              children: [
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: contextOrange,
                  ), 
                  onRatingUpdate: (rating) {
                    controller.rating = rating;
                  }
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
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ElevatedButton(
          onPressed: () {
            controller.initiateAddReview();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(contextOrange),
            padding: MaterialStateProperty.all(const EdgeInsets.all(16))
          ),
          child: Text(
            'Kirim Ulasan',
            style: buttonMd(color: Colors.white),
            
          )
        ),
      ),
    );
  }
}
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/reviews/add_review_controller.dart';

class AddReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddReviewController>(() => AddReviewController());
  }
}
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/reviews/villa_reviews_screen_controller.dart';

class VillaReviewsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VillaReviewsScreenController>(() => VillaReviewsScreenController());
  }
}
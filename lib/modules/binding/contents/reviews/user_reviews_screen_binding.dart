import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/reviews/user_reviews_screen_controller.dart';

class UserReviewsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserReviewsScreenController>(() => UserReviewsScreenController());
  }
}
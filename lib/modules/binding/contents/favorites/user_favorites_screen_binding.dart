import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/favorites/user_favorites_screen_controller.dart';

class UserFavoritesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserFavoritesScreenController>(() => UserFavoritesScreenController());
  }
}
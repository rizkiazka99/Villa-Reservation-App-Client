import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/profile/profile_screen_controller.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<DashboardScreenController>(() => DashboardScreenController(), fenix: true);
  }
}
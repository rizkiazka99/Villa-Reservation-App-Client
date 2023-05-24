import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/profile/edit_profile_screen_controller.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';

class EditProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileScreenController>(() => EditProfileScreenController());
    Get.lazyPut<DashboardScreenController>(() => DashboardScreenController(), fenix: true);
  }
}
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';

class DashboardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardScreenController>(() => DashboardScreenController());
  }
}
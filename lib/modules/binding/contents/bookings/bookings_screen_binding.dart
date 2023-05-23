import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/bookings/bookings_screen_controller.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';

class BookingsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingsScreenController>(() => BookingsScreenController());
    Get.lazyPut<DashboardScreenController>(() => DashboardScreenController(), fenix: true);
  }
}
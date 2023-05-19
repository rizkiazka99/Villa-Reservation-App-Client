import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/bookings_screen_controller.dart';

class BookingsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingsScreenController>(() => BookingsScreenController());
  }
}
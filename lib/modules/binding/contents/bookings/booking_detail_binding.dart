import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/bookings/booking_detail_controller.dart';

class BookingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailController>(() => BookingDetailController());
  }
}
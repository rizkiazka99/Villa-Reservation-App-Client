import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/villas/book_villa_screen_controller.dart';

class BookVillaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookVillaScreenController>(() => BookVillaScreenController());
  }
}
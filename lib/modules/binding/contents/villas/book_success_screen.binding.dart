import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/villas/book_success_screen_controller.dart';

class BookSuccessScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookSuccessScreenController>(() => BookSuccessScreenController());
  }
}
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/auth/register_screen_controller.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}
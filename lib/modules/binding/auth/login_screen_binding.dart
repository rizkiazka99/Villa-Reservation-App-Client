import 'package:get/get.dart';
import 'package:reservilla/modules/controller/auth/login_screen_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController> (() => LoginScreenController());
  }
}
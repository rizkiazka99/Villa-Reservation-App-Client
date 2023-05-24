import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/home_screen_controller.dart';
import 'package:reservilla/modules/controller/contents/locations/location_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<LocationScreenController>(() => LocationScreenController());
  }
}

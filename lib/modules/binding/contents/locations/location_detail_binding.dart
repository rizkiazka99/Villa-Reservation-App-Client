import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/locations/location_detail_screen_controller.dart';

class LocationDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationDetailScreenController>(() => LocationDetailScreenController());
  }
}
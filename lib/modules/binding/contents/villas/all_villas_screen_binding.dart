import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/villas/all_villas_screen_controller.dart';

class AllVillasScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllVillasScreenController>(() => AllVillasScreenController());
  }
}
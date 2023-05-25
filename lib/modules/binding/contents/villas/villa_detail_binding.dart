import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/villas/villa_detail_controller.dart';

class VillaDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VillaDetailController>(() => VillaDetailController());
  }
}

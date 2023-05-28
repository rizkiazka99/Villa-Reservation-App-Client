import 'package:get/get.dart';

class BookSuccessScreenController extends GetxController {
  RxString _id = ''.obs;
  RxString _name = ''.obs;

  String get id => _id.value;
  String get name => _name.value;

  set id(String id) => this._id.value = id;
  set name(String name) => this._name.value = name;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['booking_id'];
    print(id);
    name = Get.arguments['name'];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
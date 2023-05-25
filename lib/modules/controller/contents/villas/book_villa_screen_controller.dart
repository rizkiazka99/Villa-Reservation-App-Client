import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';

class BookVillaScreenController extends GetxController {
  Repository repository = Repository();

  RxBool _bookLoading = false.obs;
  Rx<DateTime> _currentDateStart = DateTime.now().obs;
  Rx<DateTime> _currentDateEnd = DateTime.now().obs;
  Rx<bool> _bookingStartDateUpdated = false.obs;
  Rx<bool> _bookingEndDateUpdated = false.obs;
  RxInt _grossAmount = 0.obs;
  RxString _orderId = ''.obs;
  RxString _villaId = ''.obs;
  RxString _bookingStartDate = ''.obs;
  RxString _bookingEndDate = ''.obs;

  bool get bookLoading => _bookLoading.value;
  DateTime get currentDateStart => _currentDateStart.value;
  DateTime get currentDateEnd => _currentDateEnd.value;
  bool get bookingStartDateUpdated => _bookingStartDateUpdated.value;
  bool get bookingEndDateUpdated => _bookingEndDateUpdated.value;
  int get grossAmount => _grossAmount.value;
  String get orderId => _orderId.value;
  String get villaId => _villaId.value;
  String get bookingStartDate => _bookingStartDate.value;
  String get bookingEndDate => _bookingEndDate.value;

  set bookLoading(bool bookLoading) =>
      this._bookLoading.value = bookLoading;
  set currentDateStart(DateTime currentDateStart) =>
      this._currentDateStart.value = currentDateStart;
  set currentDateEnd(DateTime currentDateEnd) =>
      this._currentDateEnd.value = currentDateEnd;
  set bookingStartDateUpdated(bool bookingStartDateUpdated) =>
      this._bookingStartDateUpdated.value = bookingStartDateUpdated;
  set bookingEndDateUpdated(bool bookingEndDateUpdated) =>
      this._bookingEndDateUpdated.value = bookingEndDateUpdated;
  set orderId(String orderId) =>
      this._orderId.value = orderId;
  set villaId(String villaId) =>
      this._villaId.value = villaId;
  set bookingStartDate(String bookingStartDate) =>
      this._bookingStartDate.value = bookingStartDate;
  set bookingEndDate(String bookingEndDate) =>
      this._bookingEndDate.value = bookingEndDate;

  @override
  void onInit() {
    super.onInit();
    villaId = Get.arguments['villa_id'].toString();
    print(villaId);
  }

  @override
  void dispose() {
    super.dispose();
  }

}
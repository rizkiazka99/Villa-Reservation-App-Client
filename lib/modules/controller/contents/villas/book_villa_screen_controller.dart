import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/helpers/days_between_dates.dart';

class BookVillaScreenController extends GetxController {
  Repository repository = Repository();

  RxInt _price = 0.obs;
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
  RxString _selectedPaymentMethod = 'permata'.obs;
  RxInt _stayingDays = 0.obs;

  int get price => _price.value;
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
  String get selectedPaymentMethod => _selectedPaymentMethod.value;
  int get stayingDays => _stayingDays.value;

  set price(int price) => this._price.value = price;
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
  set orderId(String orderId) => this._orderId.value = orderId;
  set villaId(String villaId) => this._villaId.value = villaId;
  set bookingStartDate(String bookingStartDate) =>
      this._bookingStartDate.value = bookingStartDate;
  set bookingEndDate(String bookingEndDate) =>
      this._bookingEndDate.value = bookingEndDate;
  set selectedPaymentMethod(String selectedPaymentMethod) =>
      this._selectedPaymentMethod.value = selectedPaymentMethod;
  set stayingDays(int stayingDays) => this._stayingDays.value = stayingDays;
  

  List paymentMethods = [
    {
      'name': 'permata',
      'logo': 'assets/images/bank_permata.png'
    },
    {
      'name': 'bca',
      'logo': 'assets/images/bca.png'
    }
  ];

  @override
  void onInit() {
    super.onInit();
    villaId = Get.arguments['villa_id'].toString();
    price = Get.arguments['price'];
    print(price);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> selectCheckInDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(currentDateStart.year, currentDateStart.month, currentDateStart.day + 122),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: contextOrange,
              onPrimary: backgroundColorPrimary,
              onSurface: contextOrange
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: contextOrange)
            )
          ), 
          child: child!
        );
      }
    );

    if (newDate == null) {
      return null;
    } else {
      bookingStartDateUpdated = true;
      currentDateStart = newDate;
      bookingStartDate = '${currentDateStart.day}-${currentDateStart.month}-${currentDateStart.year}';
    }
  }

  Future<Null> selectCheckOutDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: currentDateStart.add(const Duration(days: 1)),
      firstDate: currentDateStart.add(const Duration(days: 1)),
      lastDate: DateTime(currentDateStart.year, currentDateStart.month, currentDateStart.day + 121),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: contextOrange,
              onPrimary: backgroundColorPrimary,
              onSurface: contextOrange
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: contextOrange)
            )
          ), 
          child: child!
        );
      }
    );

    if (newDate == null) {
      return null;
    } else {
      bookingEndDateUpdated = true;
      currentDateEnd = newDate;
      bookingEndDate = '${currentDateEnd.day}-${currentDateEnd.month}-${currentDateEnd.year}';
      stayingDays = getDaysInBetween(currentDateStart, currentDateEnd).length;
    }
  }
}
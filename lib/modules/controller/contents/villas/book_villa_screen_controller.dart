import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/local/storage_repository.dart';
import 'package:reservilla/data/models/auth/user_data_response.dart';
import 'package:reservilla/data/models/contents/bookings/book_response.dart';
import 'package:reservilla/helpers/date_formatter.dart';
import 'package:reservilla/helpers/days_between_dates.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookVillaScreenController extends GetxController {
  Repository repository = Repository();
  StorageRepository storageRepository = StorageRepository();

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
  Rxn<UserData> _user = Rxn<UserData>();
  Rxn<BookResponse> _bookData = Rxn<BookResponse>();

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
  UserData? get user => _user.value;
  BookResponse? get bookData => _bookData.value;

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
  set grossAmount(int grossAmount) => this._grossAmount.value = grossAmount;
  set orderId(String orderId) => this._orderId.value = orderId;
  set villaId(String villaId) => this._villaId.value = villaId;
  set bookingStartDate(String bookingStartDate) =>
      this._bookingStartDate.value = bookingStartDate;
  set bookingEndDate(String bookingEndDate) =>
      this._bookingEndDate.value = bookingEndDate;
  set selectedPaymentMethod(String selectedPaymentMethod) =>
      this._selectedPaymentMethod.value = selectedPaymentMethod;
  set stayingDays(int stayingDays) => this._stayingDays.value = stayingDays;
  set user(UserData? user) => this._user.value = user;
  set bookData(BookResponse? bookData) => this._bookData.value = bookData;
  

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
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<UserData?> getUserData() async {
    UserData? res = await storageRepository.getUserData();
    user = res;

    return user;
  }

  int totalPayment(int stayingDays, int villaPrice) {
    grossAmount = stayingDays * villaPrice;
    return grossAmount;
  }

  Future<Null> selectCheckInDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: currentDateStart,
      firstDate: currentDateStart,
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
      bookingStartDate = DateFormatter.monthNameExcluded(currentDateStart, 'id_ID');
    }
  }

  Future<Null> selectCheckOutDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: !bookingEndDateUpdated ? currentDateStart.add(const Duration(days: 1)) : currentDateEnd,
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
      bookingEndDate = DateFormatter.monthNameExcluded(currentDateEnd, 'id_ID');
      stayingDays = getDaysInBetween(currentDateStart, currentDateEnd).length;
      totalPayment(stayingDays, price);
    }
  }

  generateOrderId()  {
    String id = user!.id.toString();
    String bookTime = DateFormatter.monthNameExcludedUndashed(DateTime.now(), 'id_ID');
    orderId = 'C$id$villaId$bookTime';

    return orderId;
  }

  Future<BookResponse?> book() async {
    BookResponse? res;
    generateOrderId();

    dynamic dataBca = {
      "payment_type": "bank_transfer",
      "bank_transfer": {
          "bank": "bca"
      },
      "transaction_details": {
        "gross_amount": _grossAmount.value,
        "order_id": _orderId.value
      },
      "VillaId": _villaId.value,
      "total_price": _grossAmount.value,
      "booking_start_date": _bookingStartDate.value,
      "booking_end_date": _bookingEndDate.value,
      "payment_via": "bca"
    };

    dynamic dataPermata = {
      "payment_type": "bank_transfer",
      "bank_transfer": {
          "bank": "permata"
      },
      "transaction_details": {
        "gross_amount": _grossAmount.value,
        "order_id": _orderId.value
      },
      "VillaId": _villaId.value,
      "total_price": _grossAmount.value,
      "booking_start_date": _bookingStartDate.value,
      "booking_end_date": _bookingEndDate.value,
      "payment_via": "permata"
    };
    
    bookLoading = true;
    if (selectedPaymentMethod == 'bca') {
      res = await repository.book(dataBca);
    } else {
      res = await repository.book(dataPermata);
    }
    bookData = res;
    bookLoading = false;

    return bookData;
  }

  initiateBook() async {
    loaderDialog(
      const SpinKitRing(color: contextOrange),
      'Mohon Tunggu...'
    );
    await book();

    if (bookData!.status) {
      Get.back();
      Get.offAllNamed(dashboardScreenRoute);
      defaultSnackbar('Sukses!', 'Booking Anda telah diajukan');
    } else {
      Get.back();
      defaultSnackbar('Ups!', 'Terjadi kesalahan, silahkan coba lagi');
    }
  }
}
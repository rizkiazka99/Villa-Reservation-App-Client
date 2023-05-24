import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/bookings/bookings_response.dart';
import 'package:reservilla/data/models/contents/bookings/payment_check_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingsScreenController extends GetxController {
  Repository repository = Repository();

  ScrollController scrollController = ScrollController();

  RxBool _bookingsLoading = false.obs;
  RxBool _isFetched = false.obs;
  RxBool _paymentCheckLoading = false.obs;
  Rxn<BookingsResponse> _bookingsData = Rxn<BookingsResponse>();
  RxList<Datum> _booked = <Datum>[].obs;
  RxList<Datum> _filteredBooked = <Datum>[].obs;
  RxList<Datum> _pastBooking = <Datum>[].obs;
  RxList<Datum> _cancelledBooking = <Datum>[].obs;
  Rxn<PaymentCheckResponse> _paymentCheckResult = Rxn<PaymentCheckResponse>();
  RxInt _tabBarIndex = 0.obs;
  RxString _selectedStatus = 'Semua'.obs;
  RxBool _needReview = false.obs;

  bool get bookingsLoading => _bookingsLoading.value;
  bool get isFetched => _isFetched.value;
  bool get paymentCheckLoading => _paymentCheckLoading.value;
  BookingsResponse? get bookingsData => _bookingsData.value;
  List<Datum> get filteredBooked => _filteredBooked;
  List<Datum> get booked => _booked;
  List<Datum> get pastBooking => _pastBooking;
  List<Datum> get cancelledBooking => _cancelledBooking;
  PaymentCheckResponse? get paymentCheckResult => _paymentCheckResult.value;
  int get tabBarIndex => _tabBarIndex.value;
  String get selectedStatus => _selectedStatus.value;
  bool get needReview => _needReview.value;

  set bookingsLoading(bool bookingsLoading) =>
      this._bookingsLoading.value = bookingsLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set paymentCheckLoading(bool paymentCheckLoading) =>
      this._paymentCheckLoading.value = paymentCheckLoading;
  set bookingsData(BookingsResponse? bookingsData) =>
      this._bookingsData.value = bookingsData;
  set booked(List<Datum> booked) =>
      this._booked.value = booked;
  set filteredBooked(List<Datum> filteredBooked) =>
      this._filteredBooked.value = filteredBooked;
  set pastBooking(List<Datum> pastBooking) =>
      this._pastBooking.value = pastBooking;
  set cancelledBooking(List<Datum> cancelledBooking) =>
      this._cancelledBooking.value = cancelledBooking;
  set paymentCheckResult(PaymentCheckResponse? paymentCheckResult) =>
      this._paymentCheckResult.value = paymentCheckResult;
  set tabBarIndex(int tabBarIndex) =>
      this._tabBarIndex.value = tabBarIndex;
  set selectedStatus(String selectedStatus) =>
      this._selectedStatus.value = selectedStatus;
  set needReview(bool needReview) =>
      this._needReview.value = needReview;

  List<String> bookingStatus = ['Semua', 'Menunggu Pembayaran', 'Telah Dibayar'];
  
  @override
  void onInit() {
    super.onInit();
    getBookingsByUser();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  getBooked() {
    if (bookingsData!.data.isNotEmpty) {
      booked = bookingsData!.data.where((booking) {
        DateTime formattedBookingStartDate = DateFormat('dd-MM-yyyy').parse(booking.bookingStartDate);
        return formattedBookingStartDate.isAfter(DateTime.now()) && booking.status != 'expire';
      }).toList();

      if (selectedStatus == 'Semua') {
        filteredBooked = booked;
      }
    } else {
      booked = [];
    }
  }

  getPastBookings() {
    if (bookingsData!.data.isNotEmpty) {
      pastBooking = bookingsData!.data.where((booking) {
        DateTime formattedBookingEndDate = DateFormat('dd-MM-yyyy').parse(booking.bookingEndDate);
        return formattedBookingEndDate.isBefore(DateTime.now()) && booking.status != 'expire';
      }).toList();
    } else {
      pastBooking = [];
    }
  }

  getCancelledBookings() {
    if (bookingsData!.data.isNotEmpty) {
      cancelledBooking = bookingsData!.data.where((booking) {
        return booking.status == 'expire';
      }).toList();
    } else {
      cancelledBooking = [];
    }
  }

  Future<BookingsResponse?> getBookingsByUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId = prefs.getInt('id').toString();

    isFetched = false;
    bookingsLoading = true;
    BookingsResponse? res = await repository.getBookingsByUser(UserId);
    bookingsData = res;
    getBooked();
    getPastBookings();
    getCancelledBookings();
    bookingsLoading = false;
    isFetched = true;

    return bookingsData;
  }

  Future<PaymentCheckResponse?> paymentCheck(id) async {
    paymentCheckLoading = true;
    PaymentCheckResponse? res = await repository.paymentCheck(id);
    paymentCheckResult = res;
    paymentCheckLoading = false;

    return paymentCheckResult;
  }
}
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/bookings_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingsScreenController extends GetxController {
  Repository repository = Repository();

  RxBool _bookingsLoading = false.obs;
  RxBool _isFetched = false.obs;
  Rxn<BookingsResponse> _bookingsData = Rxn<BookingsResponse>();
  RxList<Datum> _booked = <Datum>[].obs;
  RxList<Datum> _pastBooking = <Datum>[].obs;
  RxList<Datum> _cancelledBooking = <Datum>[].obs;
  RxInt _tabBarIndex = 0.obs;

  bool get bookingsLoading => _bookingsLoading.value;
  bool get isFetched => _isFetched.value;
  BookingsResponse? get bookingsData => _bookingsData.value;
  List<Datum> get booked => _booked;
  List<Datum> get pastBooking => _pastBooking;
  List<Datum> get cancelledBooking => _cancelledBooking;
  int get tabBarIndex => _tabBarIndex.value;

  set bookingsLoading(bool bookingsLoading) =>
      this._bookingsLoading.value = bookingsLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set bookingsData(BookingsResponse? bookingsData) =>
      this._bookingsData.value = bookingsData;
  set booked(List<Datum> booked) =>
      this._booked.value = booked;
  set pastBooking(List<Datum> pastBooking) =>
      this._pastBooking.value = pastBooking;
  set cancelledBooking(List<Datum> cancelledBooking) =>
      this._cancelledBooking.value = cancelledBooking;
  set tabBarIndex(int tabBarIndex) =>
      this._tabBarIndex.value = tabBarIndex;
  
  @override
  void onInit() {
    super.onInit();
    getBookingsByUser();
  }

  getBooked() {
    if (bookingsData!.data.isNotEmpty) {
      booked = bookingsData!.data.where((booking) {
        DateTime formattedBookingStartDate = DateFormat('dd-MM-yyyy').parse(booking.bookingStartDate);
        return formattedBookingStartDate.isAfter(DateTime.now()) && booking.status != 'expire';
      }).toList();
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
}
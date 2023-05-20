import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/bookings_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingsScreenController extends GetxController {
  Repository repository = Repository();

  RxBool _bookingsLoading = false.obs;
  Rxn<BookingsResponse> _bookingsData = Rxn<BookingsResponse>();
  RxInt _tabBarIndex = 0.obs;

  bool get bookingsLoading => _bookingsLoading.value;
  BookingsResponse? get bookingsData => _bookingsData.value;
  int get tabBarIndex => _tabBarIndex.value;

  set bookingsLoading(bool bookingsLoading) =>
      this._bookingsLoading.value = bookingsLoading;
  set bookingsData(BookingsResponse? bookingsData) =>
      this._bookingsData.value = bookingsData;
  set tabBarIndex(int tabBarIndex) =>
      this._tabBarIndex.value = tabBarIndex;
  
  @override
  void onInit() {
    super.onInit();
    getBookingsByUser();
  }

  Future<BookingsResponse?> getBookingsByUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId = prefs.getInt('id').toString();

    bookingsLoading = true;
    BookingsResponse? res = await repository.getBookingsByUser(UserId);
    bookingsData = res;
    bookingsLoading = false;

    return bookingsData;
  }
}
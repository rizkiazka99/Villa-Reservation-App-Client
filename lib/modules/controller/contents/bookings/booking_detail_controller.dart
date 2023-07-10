import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/bookings/booking_detail_response.dart';
import 'package:reservilla/helpers/days_between_dates.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailController extends GetxController {
  Repository repository = Repository();

  RxBool _bookingDetailLoading = false.obs;
  RxString _id = ''.obs;
  Rxn<BookingDetailResponse> _bookingDetailData = Rxn<BookingDetailResponse>();
  RxInt _stayingDays = 0.obs;

  bool get bookingDetailLoading => _bookingDetailLoading.value;
  String get id => _id.value;
  BookingDetailResponse? get bookingDetailData => _bookingDetailData.value;
  int get stayingDays => _stayingDays.value;

  set bookingDetailLoading(bool bookingDetailLoading) =>
      this._bookingDetailLoading.value = bookingDetailLoading;
  set id(String id) =>
      this._id.value = id;
  set bookingDetailData(BookingDetailResponse? bookingDetailData) =>
      this._bookingDetailData.value = bookingDetailData;
  set stayingDays(int stayingDays) => this._stayingDays.value = stayingDays;

  @override
  void onInit() {
    super.onInit();
    getBookingDetail();
    print(Get.previousRoute);
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<BookingDetailResponse?> getBookingDetail() async {
    id = Get.arguments['id'];

    bookingDetailLoading = true;
    BookingDetailResponse? res = await repository.getBookingDetail(id);
    bookingDetailData = res;
    bookingDetailLoading = false;
    stayingDays = getDaysInBetween(
      DateFormat('dd-MM-yyyy').parse(bookingDetailData!.data.bookingStartDate),
      DateFormat('dd-MM-yyyy').parse(bookingDetailData!.data.bookingEndDate)
    ).length;

    return bookingDetailData;
  }

  launchDialer(String contactNumber) async {
    Uri dialerUri = Uri.parse('tel:+62$contactNumber');

    try {
      await launchUrl(dialerUri);
    } catch(err) {
      print(err);
      return defaultSnackbar('Ups', 'Terjadi kesalahan, silahkan coba lagi');
    }
  }

  launchMaps(String mapsUrl) async {
    Uri mapsUri = Uri.parse(mapsUrl);

    try {
      if (await canLaunchUrl(mapsUri)) {
        await launchMaps(mapsUrl);
      } else {
        await launchUrl(mapsUri);
      }
    } catch(err) {
      print(err);
      return defaultSnackbar('Ups', 'Terjadi kesalahan, silahkan coba lagi');
    }
  }
}
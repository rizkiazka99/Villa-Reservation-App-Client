import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/favorites/add_to_favorite_response.dart';
import 'package:reservilla/data/models/contents/favorites/remove_from_favorite_response.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
import 'package:reservilla/helpers/days_between_dates.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class VillaDetailController extends GetxController {
  Repository repository = Repository();

  RxBool _villaDetailLoading = false.obs;
  RxBool _favoriteLoading = false.obs;
  RxBool _addToFavoriteLoading = false.obs;
  RxBool _isFavorite = false.obs;
  RxString _id = ''.obs;
  RxInt _favoriteId = 0.obs;
  Rxn<VillaDetailResponse> _villaDetailData = Rxn<VillaDetailResponse>();
  Rxn<UserFavoritesResponse> _userFavorites = Rxn<UserFavoritesResponse>();
  Rxn<AddToFavoriteResponse> _addToFavoriteData = Rxn<AddToFavoriteResponse>();
  RxList<Datum> _favoriteData = <Datum>[].obs;
  RxBool _removeFromFavoriteLoading = false.obs;
  Rxn<RemoveFromFavoriteResponse> _removeFromFavoriteData = Rxn<RemoveFromFavoriteResponse>();
  RxList _bookedDates = [].obs;

  bool get villaDetailLoading => _villaDetailLoading.value;
  bool get favoriteLoading => _favoriteLoading.value;
  bool get addToFavoriteLoading => _addToFavoriteLoading.value;
  bool get isFavorite => _isFavorite.value;
  String get id => _id.value;
  int get favoriteId => _favoriteId.value;
  VillaDetailResponse? get villaDetailData => _villaDetailData.value;
  UserFavoritesResponse? get userFavorites => _userFavorites.value;
  AddToFavoriteResponse? get addToFavoriteData => _addToFavoriteData.value;
  List<Datum> get favoriteData => _favoriteData;
  bool get removeFromFavoriteLoading => _removeFromFavoriteLoading.value;
  RemoveFromFavoriteResponse? get removeFromFavoriteData => _removeFromFavoriteData.value;
  List get bookedDates => _bookedDates;

  set villaDetailLoading(bool villaDetailLoading) =>
      this._villaDetailLoading.value = villaDetailLoading;
  set favoriteLoading(bool favoriteLoading) =>
      this._favoriteLoading.value = favoriteLoading;
  set addToFavoriteLoading(bool addToFavoriteLoading) =>
      this._addToFavoriteLoading.value = addToFavoriteLoading;
  set isFavorite(bool isFavorite) => this._isFavorite.value = isFavorite;
  set id(String id) => this._id.value = id;
  set favoriteId(int favoriteId) => this._favoriteId.value = favoriteId;
  set villaDetailData(VillaDetailResponse? villaDetailData) =>
      this._villaDetailData.value = villaDetailData;
  set userFavorites(UserFavoritesResponse? userFavorites) =>
      this._userFavorites.value = userFavorites;
  set addToFavoriteData(AddToFavoriteResponse? addToFavoriteData) =>
      this._addToFavoriteData.value = addToFavoriteData;
  set favoriteData(List<Datum> favoriteData) =>
      this._favoriteData.value = favoriteData;
  set removeFromFavoriteLoading(bool removeFromFavoriteLoading) =>
      this._removeFromFavoriteLoading.value = removeFromFavoriteLoading;
  set removeFromFavoriteData(RemoveFromFavoriteResponse? removeFromFavoriteData) =>
      this._removeFromFavoriteData.value = removeFromFavoriteData;
  set bookedDates(List bookedDates) => this._bookedDates.value = bookedDates;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    getVillaDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getActiveBookingDates() {
    if (villaDetailData!.data.bookings.isNotEmpty) {
      for(var i = 0; i < villaDetailData!.data.bookings.length; i++) {
        List dates = [];
        DateTime bookingStartDate = DateFormat('dd-MM-yyyy').parse(villaDetailData!.data.bookings[i].bookingStartDate);
        DateTime bookingEndDate = DateFormat('dd-MM-yyyy').parse(villaDetailData!.data.bookings[i].bookingEndDate);

        if (bookingStartDate.isBefore(DateTime.now()) && bookingEndDate.isBefore(DateTime.now())) {

        } else {
          dates.add(getDaysInBetween(
            DateFormat('dd-MM-yyyy').parse(villaDetailData!.data.bookings[i].bookingStartDate), 
            DateFormat('dd-MM-yyyy').parse(villaDetailData!.data.bookings[i].bookingEndDate)
          ));
          dates.forEach((dates) => bookedDates.addAll(dates));
        }
      }
    } else {
      bookedDates = [];
    }
    
    print(bookedDates);
  }

  Future<VillaDetailResponse?> getVillaDetail() async {
    villaDetailLoading = true;
    VillaDetailResponse? res = await repository.getVillaDetail(id);
    villaDetailData = res;
    getUserFavorites();
    getActiveBookingDates();
    villaDetailLoading = false;

    return villaDetailData;
  }

  setIsFavorite() {
    isFavorite = userFavorites!.data.any((favorite) => favorite.villaId == villaDetailData!.data.id);
    if (isFavorite) {
      favoriteData = userFavorites!.data.where((favorite) => favorite.villaId == villaDetailData!.data.id).toList();
      favoriteId = favoriteData[0].id;
    }
  }

  Future<UserFavoritesResponse?> getUserFavorites() async {
    favoriteLoading = true;
    UserFavoritesResponse? res = await repository.getUserFavorites();
    userFavorites = res;
    favoriteLoading = false;
    setIsFavorite();

    return userFavorites;
  }

  Future<AddToFavoriteResponse?> addToFavorite(villaId) async {
    dynamic data = {
      'VillaId': villaId
    };

    addToFavoriteLoading = true;
    AddToFavoriteResponse? res = await repository.addToFavorite(data);
    addToFavoriteData = res;
    addToFavoriteLoading = false;

    return addToFavoriteData;
  }

  initiateAddToFavorite(villaId, villaName) async {
    loaderDialog(
      const SpinKitRing(color: contextOrange), 
      'Mohon tunggu...'
    );
    await addToFavorite(villaId);
    await getUserFavorites();

    if (addToFavoriteData!.status && userFavorites!.message.isNotEmpty) {
      Get.back();
      defaultSnackbar('Sukses!', 'Berhasil menambahkan $villaName ke favorit');
    } else {
      Get.back();
      defaultSnackbar('Ups!', 'Terjadi kesalahan, mohon coba lagi');
    }
  }

  Future<RemoveFromFavoriteResponse?> removeFromFavorite(id) async {
    removeFromFavoriteLoading = true;
    RemoveFromFavoriteResponse? res = await repository.removeFromFavorite(id);
    removeFromFavoriteData = res;
    removeFromFavoriteLoading = false;

    return removeFromFavoriteData;
  }

  initiateRemoveFromFavorite(id, villaName) async {
    Get.back();
    loaderDialog(
      const SpinKitRing(color: contextOrange), 
      'Mohon tunggu...'
    );
    await removeFromFavorite(id);
    await getUserFavorites();

    if (removeFromFavoriteData!.status && userFavorites!.message.isNotEmpty) {
      Get.back();
      defaultSnackbar('Sukses!', 'Berhasil menghilangkan $villaName dari favorit');
    } else {
      Get.back();
      defaultSnackbar('Ups!', 'Terjadi kesalahan, mohon coba lagi');
    }
  }

  launchDialer(String contactNumber) async {
    Uri dialerUri = Uri.parse('tel:+62$contactNumber');

    try {
      await launchUrl(dialerUri);
    } catch (err) {
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
    } catch (err) {
      return defaultSnackbar('Ups', 'Terjadi kesalahan, silahkan coba lagi');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/favorites/remove_from_favorite_response.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';

class UserFavoritesScreenController extends GetxController {
  Repository repository = Repository();

  TextEditingController searchController = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  var autoValidateSearch = AutovalidateMode.disabled;

  RxBool _favoritesLoading = false.obs;
  RxBool _isFetched = false.obs;
  RxBool _showSearchBar = false.obs;
  Rxn<UserFavoritesResponse> _favoritesData = Rxn<UserFavoritesResponse>();
  RxList<Datum> _searchResult = <Datum>[].obs;
  RxBool _removeFromFavoriteLoading = false.obs;
  Rxn<RemoveFromFavoriteResponse> _removeFromFavoriteData = Rxn<RemoveFromFavoriteResponse>();

  bool get favoritesLoading => _favoritesLoading.value;
  bool get isFetched => _isFetched.value;
  bool get showSearchBar => _showSearchBar.value;
  UserFavoritesResponse? get favoritesData => _favoritesData.value;
  List<Datum> get searchResult => _searchResult;
  bool get removeFromFavoriteLoading => _removeFromFavoriteLoading.value;
  RemoveFromFavoriteResponse? get removeFromFavoriteData => _removeFromFavoriteData.value;

  set favoritesLoading(bool favoritesLoading) =>
      this._favoritesLoading.value = favoritesLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set showSearchBar(bool showSearchBar) =>
      this._showSearchBar.value = showSearchBar;
  set favoritesData(UserFavoritesResponse? favoritesData) =>
      this._favoritesData.value = favoritesData;
  set searchResult(List<Datum> searchResult) =>
      this._searchResult.value = searchResult;
  set removeFromFavoriteLoading(bool removeFromFavoriteLoading) =>
      this._removeFromFavoriteLoading.value = removeFromFavoriteLoading;
  set removeFromFavoriteData(RemoveFromFavoriteResponse? removeFromFavoriteData) =>
      this._removeFromFavoriteData.value = removeFromFavoriteData;

  @override
  void onInit() {
    super.onInit();
    getUserFavorites();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<UserFavoritesResponse?> getUserFavorites() async {
    favoritesLoading = true;
    isFetched = false;
    UserFavoritesResponse? res = await repository.getUserFavorites();
    favoritesData = res;
    favoritesLoading = false;
    isFetched = true;

    return favoritesData;
  }

  searchFavorite(query) {
    if (favoritesData!.data.isNotEmpty) {
      searchResult = favoritesData!.data.where((favorite) =>
        favorite.villa.name.toLowerCase().contains(query.toString().toLowerCase())
      ).toList();
    } else {
      searchResult = [];
    }
  }

  Stream<UserFavoritesResponse?> getRealtimeUserFavorites() {
    return Stream.periodic(const Duration(seconds: 3)).asyncMap((event) => getUserFavorites());
  }

  Future<RemoveFromFavoriteResponse?> removeFromFavorite(id) async {
    removeFromFavoriteLoading = true;
    RemoveFromFavoriteResponse? res = await repository.removeFromFavorite(id);
    removeFromFavoriteData = res;
    removeFromFavoriteLoading = false;

    return removeFromFavoriteData;
  }

  initiateRemoveFromFavorite(id, villaName) async {
    Get.closeCurrentSnackbar();
    Get.back();
    loaderDialog(
      const SpinKitRing(color: contextOrange), 
      'Mohon tunggu...'
    );
    await removeFromFavorite(id);
    await getUserFavorites();

    if (removeFromFavoriteData!.status && favoritesData!.message.isNotEmpty) {
      Get.back();
      defaultSnackbar('Sukses!', 'Berhasil menghilangkan $villaName dari favorit');
    } else {
      Get.back();
      defaultSnackbar('Ups!', 'Terjadi kesalahan, mohon coba lagi');
    }
  }
}
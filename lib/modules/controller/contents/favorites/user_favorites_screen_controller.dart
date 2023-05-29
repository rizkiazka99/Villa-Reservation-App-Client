import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';

class UserFavoritesScreenController extends GetxController {
  Repository repository = Repository();

  TextEditingController searchController = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  var autoValidateSearch = AutovalidateMode.disabled;

  RxBool _favoritesLoading = false.obs;
  RxBool _isFetched = false.obs;
  RxBool _showSearchBar = false.obs;
  Rxn<UserFavoritesResponse> _favoritesData = Rxn<UserFavoritesResponse>();
  RxBool _searchLoading = false.obs;
  RxBool _isSearchResultFetched = false.obs;
  RxList<Datum> _searchResult = <Datum>[].obs;

  bool get favoritesLoading => _favoritesLoading.value;
  bool get isFetched => _isFetched.value;
  bool get showSearchBar => _showSearchBar.value;
  UserFavoritesResponse? get favoritesData => _favoritesData.value;
  bool get searchLoading => _searchLoading.value;
  bool get isSearchResultFetched => _isSearchResultFetched.value;
  List<Datum> get searchResult => _searchResult;

  set favoritesLoading(bool favoritesLoading) =>
      this._favoritesLoading.value = favoritesLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set showSearchBar(bool showSearchBar) =>
      this._showSearchBar.value = showSearchBar;
  set favoritesData(UserFavoritesResponse? favoritesData) =>
      this._favoritesData.value = favoritesData;
  set searchLoading(bool searchLoading) => _searchLoading.value = searchLoading;
  set isSearchResultFetched(bool isSearchResultFetched) => 
      _isSearchResultFetched.value = isSearchResultFetched;
  set searchResult(List<Datum> searchResult) =>
      this._searchResult.value = searchResult;

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

  Stream<UserFavoritesResponse?> getRealtimeUserFavorites() {
    return Stream.periodic(const Duration(seconds: 3)).asyncMap((event) => getUserFavorites());
  }
}
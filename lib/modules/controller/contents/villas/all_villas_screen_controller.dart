import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/villas/villa_search_response.dart';
import 'package:reservilla/data/models/contents/villas/villas_response.dart';

class AllVillasScreenController extends GetxController {
  Repository repository = Repository();

  TextEditingController searchController = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  var autoValidateSearch = AutovalidateMode.disabled;

  RxBool _villasLoading = false.obs;
  RxBool _isFetched = false.obs;
  Rxn<VillasResponse> _villasData = Rxn<VillasResponse>();
  RxBool _showSearchBar = false.obs;
  //RxList<Datum> _searchResult = <Datum>[].obs; // Local Search
  // API Search
  RxBool _searchLoading = false.obs;
  RxBool _isSearchResultFetched = false.obs;
  Rxn<VillaSearchResponse> _searchResult = Rxn<VillaSearchResponse>();

  bool get villasLoading => _villasLoading.value;
  bool get isFetched => _isFetched.value;
  VillasResponse? get villasData => _villasData.value;
  bool get showSearchBar => _showSearchBar.value;
  //List<Datum> get searchResult => _searchResult; // Local Search
  // API Search
  bool get searchLoading => _searchLoading.value;
  bool get isSearchResultFetched => _isSearchResultFetched.value;
  VillaSearchResponse? get searchResult => _searchResult.value;

  set villasLoading(bool villasLoading) => _villasLoading.value = villasLoading;
  set isFetched(bool isFetched) => _isFetched.value = isFetched;
  set villasData(VillasResponse? villasData) => _villasData.value = villasData;
  set showSearchBar(bool showSearchBar) =>
      this._showSearchBar.value = showSearchBar;
  /*set searchResult(List<Datum> searchResult) =>
      this._searchResult.value = searchResult;*/ // Local Search
  // API Search
  set searchLoading(bool searchLoading) => _searchLoading.value = searchLoading;
  set isSearchResultFetched(bool isSearchResultFetched) => 
      _isSearchResultFetched.value = isSearchResultFetched;
  set searchResult(VillaSearchResponse? searchResult) =>
      this._searchResult.value = searchResult;

  @override
  void onInit() {
    super.onInit();
    getVillas();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<VillasResponse?> getVillas() async {
    isFetched = false;
    villasLoading = true;
    VillasResponse? result = await repository.getVillas();
    villasData = result;
    villasLoading = false;
    isFetched = true;

    return villasData;
  }

  /*// Local Search
  searchVilla(String query) {
    if (villasData!.data.isNotEmpty) {
      searchResult = villasData!.data.where((villa) => 
        villa.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } else {
      searchResult = [];
    }
  }*/

  // API Search
  Future<VillaSearchResponse?> searchVilla(String query) async {
    searchLoading = true;
    isSearchResultFetched = false;
    VillaSearchResponse? res = await repository.searchVilla(query);
    searchResult = res;
    searchLoading = false;
    isSearchResultFetched = true;

    return searchResult;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/villas/villas_response.dart';

class AllVillasScreenController extends GetxController {
  Repository repository = Repository();

  TextEditingController searchController = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  var autoValidateSearch = AutovalidateMode.disabled;

  final RxBool _villasLoading = false.obs;
  final RxBool _isFetched = false.obs;
  final Rxn<VillasResponse> _villasData = Rxn<VillasResponse>();
  RxBool _showSearchBar = false.obs;
  RxList<Datum> _searchResult = <Datum>[].obs;

  bool get villasLoading => _villasLoading.value;
  bool get isFetched => _isFetched.value;
  VillasResponse? get villasData => _villasData.value;
  bool get showSearchBar => _showSearchBar.value;
  List<Datum> get searchResult => _searchResult;

  set villasLoading(bool villasLoading) => _villasLoading.value = villasLoading;
  set isFetched(bool isFetched) => _isFetched.value = isFetched;
  set villasData(VillasResponse? villasData) => _villasData.value = villasData;
  set showSearchBar(bool showSearchBar) =>
      this._showSearchBar.value = showSearchBar;
  set searchResult(List<Datum> searchResult) =>
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

  searchVilla(String query) {
    if (villasData!.data.isNotEmpty) {
      searchResult = villasData!.data.where((villa) => 
        villa.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } else {
      searchResult = [];
    }
  }
}
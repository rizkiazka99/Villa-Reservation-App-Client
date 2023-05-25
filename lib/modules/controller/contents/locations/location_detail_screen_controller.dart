import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/locations/location_detail_response.dart';

class LocationDetailScreenController extends GetxController {
  Repository repository = Repository();

  TextEditingController searchController = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  var autoValidateSearch = AutovalidateMode.disabled;

  RxString _id = ''.obs;
  RxString _locationName = ''.obs;
  RxBool _locationDetailLoading = false.obs;
  RxBool _isFetched = false.obs;
  Rxn<LocationDetailResponse> _locationDetailData = Rxn<LocationDetailResponse>();
  RxBool _showSearchBar = false.obs;
  RxList<Datum> _searchResult = <Datum>[].obs;

  String get id => _id.value;
  String get locationName => _locationName.value;
  bool get locationDetailLoading => _locationDetailLoading.value;
  bool get isFetched => _isFetched.value;
  LocationDetailResponse? get locationDetailData => _locationDetailData.value;
  bool get showSearchBar => _showSearchBar.value;
  List<Datum> get searchResult => _searchResult;

  set id(String id) => this._id.value = id;
  set locationName(String locationName) =>
      this._locationName.value = locationName;
  set locationDetailLoading(bool locationDetailLoading) =>
      this._locationDetailLoading.value = locationDetailLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set locationDetailData(LocationDetailResponse? locationDetailData) =>
      this._locationDetailData.value = locationDetailData;
  set showSearchBar(bool showSearchBar) =>
      this._showSearchBar.value = showSearchBar;
  set searchResult(List<Datum> searchResult) =>
      this._searchResult.value = searchResult;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'].toString();
    locationName = Get.arguments['location_name'];
    getLocationDetail();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<LocationDetailResponse?> getLocationDetail() async {
    isFetched = false;
    locationDetailLoading = true;
    LocationDetailResponse? res = await repository.getLocationDetail(id);
    locationDetailData = res;
    locationDetailLoading = false;
    isFetched = true;

    return locationDetailData;
  }

  searchVilla(String query) {
    if (locationDetailData!.data.isNotEmpty) {
      searchResult = locationDetailData!.data.where((villa) => 
        villa.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } else {
      searchResult = [];
    }
  }
}
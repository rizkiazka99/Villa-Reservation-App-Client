import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/locations/locations_response.dart';

class LocationScreenController extends GetxController {
  Repository repository = Repository();

  ScrollController scrollController = ScrollController();

  final RxBool _locationsLoading = false.obs;
  final RxBool _isFetched = false.obs;
  final Rxn<LocationsResponse> _locationsData = Rxn<LocationsResponse>();
  final RxList<Datum> _locations = <Datum>[].obs;

  bool get locationsLoading => _locationsLoading.value;
  bool get isFetched => _isFetched.value;
  LocationsResponse? get locationsData => _locationsData.value;
  List<Datum> get locations => _locations;

  set locationsLoading(bool locationsLoading) =>
      _locationsLoading.value = locationsLoading;
  set isFetched(bool isFetched) => _isFetched.value = isFetched;
  set locationsData(LocationsResponse? locationsData) =>
      _locationsData.value = locationsData;
  set locations(List<Datum> locations) => _locations.value = locations;

  @override
  void onInit() {
    super.onInit();
    getLocations();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  getAllLocations() {
    if (locationsData!.data.isNotEmpty) {
      locations = locationsData!.data.toList();
    } else {
      locations = [];
    }
  }

  Future<LocationsResponse?> getLocations() async {
    isFetched = false;
    locationsLoading = true;

    LocationsResponse? result = await repository.getLocations();
    locationsData = result;
    getAllLocations();

    locationsLoading = false;
    isFetched = true;

    return locationsData;
  }
}
